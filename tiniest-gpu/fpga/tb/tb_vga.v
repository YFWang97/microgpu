module tb_vga();

    reg clk_25;
    reg reset;

    initial begin
        clk_25 = 0;
        forever #4 clk_25 = ~clk_25;
    end

    initial begin
        reset = 1;
        #20;
        reset = 0;
        #100000;
        $stop();
    end 


    vga v (
        .clk(clk_25),
        .reset(reset)
    );


endmodule
