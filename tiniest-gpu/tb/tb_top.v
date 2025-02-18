module tb_top();

    reg ena, clk, clk_40, clk_20, rst_n, rx, vga_ready_in;
    wire vga_data_valid_out;
    wire [5:0] vga_data_out;


    initial begin 
        clk_40 <= 1;
        forever #5 clk_40 <= ~clk_40;
    end

    initial begin
        clk_20 <= 1;
        forever #10 clk_20 <= ~clk_20;
    end

    initial begin
        rst_n <= 0;
        #100;
        rst_n <= 1;
        vga_ready_in <= 1;
        #20;
        vga_ready_in <= 0;
        #100000;
        $stop();
    end

    tt_um_pongsagon_tiniest_gpu dut(.*);

endmodule
