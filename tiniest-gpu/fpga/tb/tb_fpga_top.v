module tb_fpga_top ();
    reg clk_50, clk_40, clk_20, clk_25;
    reg rst_n;
    wire vga_ready;
    wire vga_data_valid;
    wire [5:0] vga_data;
    wire [5:0] rgb;
    wire vsync, hsync, blank;

    wire [7:0] ui_in, uio_out;

    initial begin
        clk_40 = 1;
        forever #25 clk_40 = ~clk_40;
    end

    initial begin
        clk_20 = 1;
        forever #50 clk_20 = ~clk_20;
    end

    initial begin
        clk_25 = 1;
        forever #40 clk_25 = ~clk_25;
    end

    initial begin
        rst_n = 0;
        #100;
        rst_n = 1;
        #1000000000;
        $stop();
    end

    assign ui_in[3] = 0;
        
    tt_um_pongsagon_tiniest_gpu gpu (
        .ena(1),
        .clk_40(clk_40),
        .clk_20(clk_20),
        .rst_n(rst_n),
        .rx(ui_in[3]),
        .vga_ready_in(vga_ready),
        .vga_data_valid_out(vga_data_valid),
        .vga_data_out(vga_data)
    );

    vga_controller vga_contoller_inst (
        .reset(!rst_n),
        .clk_20(clk_20),
        .clk_25(clk_25),
        .vga_data_valid_in(vga_data_valid),
        .vga_data_in(vga_data),
        .vga_ready_out(vga_ready),
        .vsync(uio_out[3]),
        .hsync(uio_out[7]),
        .rgb(rgb)
    );

endmodule
