module tb_top();

	import "DPI-C" function byte get_input(input int id);
	import "DPI-C" function void process_output(input byte vga);
	import "DPI-C" function int c_init();
	import "DPI-C" function int c_update();

	reg clk;
	reg rst_n;
	reg ena;
	reg [7:0] ui_in;
	reg [7:0] uio_out;
	
	reg [7:0] vga;
	
	parameter BIT_TIME = 8680;
	parameter CLK_PERIOD = 10;

	parameter UART_DLY_CYCLE = 27;

	task progress_clk(integer cycles);
		integer i;
		for (i = 0; i < cycles; i = i + 1) begin
			#(CLK_PERIOD/2); clk = ~clk;
			#(CLK_PERIOD/2); clk = ~clk;
		end
	endtask

	task progress_clk_till_vsync_low();
		forever begin
			if (uio_out[3] == 0) break;
			else #(CLK_PERIOD/2); clk = ~clk;
		end
	endtask

	integer index;
	integer bit_index;
	integer x, y;
	byte input_byte;
	integer ret;

	initial begin
		clk = 0;
		rst_n = 0;
		ena = 0;
		progress_clk(3);
		rst_n = 1;
		ena = 1;
	end

	initial begin
		@(posedge rst_n);
		ret = c_init();
		//progress_clk(10);
		ret = c_update();
		for (index = 0; index < 60; index = index + 1) begin
			input_byte = get_input(index);
			//$display("SV received id: %d, value: %d", index, input_byte);
			ui_in[3] = 0;
			progress_clk(1);

			ui_in[3] = 1;
			progress_clk(8 * UART_DLY_CYCLE);

			for (bit_index = 0; bit_index < 8; bit_index = bit_index + 1) begin
				ui_in[3] = input_byte[bit_index];
				progress_clk(16 * UART_DLY_CYCLE);
			end

			progress_clk(16 * UART_DLY_CYCLE);
		end
		ui_in[3] = 1;
		progress_clk_till_vsync_low();
		progress_clk(55999);
	
		index = 0;

		for (y = 0; y < 524; y = y + 1) begin
			for (x = 0; x < 800; x = x + 1) begin
				if (x < 640 && y < 480) begin
					process_output({{6'd0}, uio_out[0], uio_out[4]});
					process_output({{6'd0}, uio_out[2], uio_out[6]});
					process_output({{6'd0}, uio_out[1], uio_out[5]});
					//$display("SV sent id: %d, value %d %d %d", index, {uio_out[0], uio_out[4]}, {uio_out[2], uio_out[6]}, {uio_out[1], uio_out[5]});
					index = index + 1;
				end
				progress_clk(2);
			end
		end
	
		$display("Configure Completed");	
	end

	tt_um_pongsagon_tiniest_gpu gpu (
		.clk(clk),
		.rst_n(rst_n),
		.ena(ena),
		.ui_in(ui_in),
		.uio_out(uio_out)
	);

endmodule
