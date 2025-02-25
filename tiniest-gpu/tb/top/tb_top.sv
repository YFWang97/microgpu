`timescale 1ns/1ps
module tb_top();

	import "DPI-C" function byte get_input(input int id);
	import "DPI-C" function void process_output(input byte vga);
	import "DPI-C" function byte get_texture(input int id);
	import "DPI-C" function int c_init();
	import "DPI-C" function int c_update();
    import "DPI-C" function int c_get_command();

	reg clk;
	reg rst_n;
	reg ena;
	reg [7:0] ui_in;
	reg [7:0] uio_out;
    reg [7:0] uio_in;
	
	reg [7:0] vga;

    supply1 VDD;
    supply0 VSS;
	
	parameter BIT_TIME = 8680;
	parameter CLK_PERIOD = 20;

	parameter UART_DLY_CYCLE = 27;

    reg clk_running;

    initial begin
        clk = 1;
        clk_running = 0;
        forever begin
            if (clk_running) begin
                #(CLK_PERIOD/2); clk = ~clk;
                #(CLK_PERIOD/2); clk = ~clk;
            end
            else begin
                #0;
            end
        end
    end

	task progress_clk(integer cycles);
		integer i;
        clk_running = 1;
		for (i = 0; i < cycles; i = i + 1) begin
            @(posedge clk);
		end
        clk_running = 0;
	endtask

    task stop_clk();
        clk_running = 0;
    endtask

    task start_clk();
        clk_running = 1;
    endtask

    initial begin
        uio_in[0] = 0;
        uio_in[1] = 0;
        uio_in[2] = 0;
    end

    task progress_phi();
        uio_in[0] = 1;
        #(CLK_PERIOD/2);
        uio_in[0] = 0;
        uio_in[1] = 1;        
        #(CLK_PERIOD/2);
        uio_in[0] = 0;
        uio_in[1] = 0;        
    endtask


    task load_texture_from_scan_chain();
        integer texture_byte_index;
        integer bit_index;
        byte texture_byte;
        for (texture_byte_index = 0; texture_byte_index < 2048; texture_byte_index = texture_byte_index + 1) begin
            texture_byte = get_texture(texture_byte_index);

            uio_in[4] <= 0;
            progress_phi();

			for (bit_index = 10; bit_index >= 0; bit_index = bit_index - 1) begin
                uio_in[4] <= texture_byte_index[bit_index];
                progress_phi();
            end

			for (bit_index = 7; bit_index >= 0; bit_index = bit_index - 1) begin
                uio_in[4] <= texture_byte[bit_index];
                progress_phi();
            end               

            uio_in[3] <= 1;
            @(posedge clk);
            uio_in[3] <= 0;
        end
    endtask

    task configure();
	    integer byte_index;
        integer bit_index;
	    byte input_byte;
		for (byte_index = 0; byte_index < 60; byte_index = byte_index + 1) begin
			input_byte = get_input(byte_index);
			//$display("SV received id: %d, value: %d", index, input_byte);
			ui_in[3] <= 0;
			progress_clk(1);

			ui_in[3] <= 1;
			progress_clk(8 * UART_DLY_CYCLE - 1);

			for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1) begin
				ui_in[3] <= input_byte[bit_index];
				progress_clk(16 * UART_DLY_CYCLE);
			end

			progress_clk(16 * UART_DLY_CYCLE);
		end
		ui_in[3] <= 1;
        start_clk();
        @(negedge uio_out[3]);
        stop_clk();
		progress_clk(56000);
    endtask

    task run_one_frame();
        integer index;
	    integer x, y;

        index = 0;
		progress_clk(2);
		for (y = 0; y < 525; y = y + 1) begin
			for (x = 0; x < 800; x = x + 1) begin
				if (x < 640 && y < 480) begin
					process_output({{6'd0}, uio_out[0], uio_out[4]});
					process_output({{6'd0}, uio_out[2], uio_out[6]});
					process_output({{6'd0}, uio_out[1], uio_out[5]});
                    if (x == 0 && y == 0) begin
                    $display("SV sent id: %d, x: %d, y: %d, value %d %d %d %0t", index, x, y, {uio_out[0], uio_out[4]}, {uio_out[2], uio_out[6]}, {uio_out[1], uio_out[5]}, $realtime);
                    end
					index = index + 1;
				end
				progress_clk(2);
			end
		end
        $display("end run one frame %0t", $realtime);
    endtask

	integer ret;

	initial begin
		rst_n <= 0;
		ena <= 0;
		ui_in[3] <= 1;
		progress_clk(3);
		rst_n <= 1;
		ena <= 1;
	end

    integer loop_index;

	initial begin
		@(posedge rst_n);
		ret = c_init();
		//progress_clk(10);

        start_clk();
        load_texture_from_scan_chain();
        @(posedge tb_top.top_inst.gpu.ia1.UART_UNIT.UART_RX_UNIT.sample_tick);
        stop_clk();
        progress_clk(1);
        
        for (loop_index = 0; loop_index < 10; loop_index = loop_index + 1) begin
            ret = c_update();
            configure();
            run_one_frame();
            start_clk();
            @(posedge tb_top.top_inst.gpu.ia1.UART_UNIT.UART_RX_UNIT.sample_tick);
            stop_clk();
            progress_clk(1);
            ret = c_get_command();
        end
        $stop();
	end

	top top_inst (
		.clk(clk),
		.rst_n(rst_n),
		.ena(ena),
		.ui_in(ui_in),
		.uio_out(uio_out),
        .uio_in(uio_in),
        .VDD(VDD),
        .VSS(VSS)
	);

endmodule
