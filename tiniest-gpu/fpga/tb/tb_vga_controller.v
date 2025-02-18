module tb_vga_controller();
    reg clk_20;
    reg clk_25;
    reg reset;
    reg vga_data_valid_in;
    
    wire vga_ready_out;

    vga_controller vga_controller_inst (
        .reset(reset),
        .clk_20(clk_20),
        .clk_25(clk_25),
        .vga_data_valid_in(vga_data_valid_in),
        .vga_ready_out(vga_ready_out)
    );


    initial begin
        clk_20 = 0;
        forever #5 clk_20 = ~clk_20;
    end

    initial begin
        clk_25 = 0;
        forever #4 clk_25 = ~clk_25;
    end

    always @(posedge clk_20) begin
        if (reset) begin
            vga_data_valid_in <= 0;
        end
        else begin
            if (vga_ready_out) begin
                vga_data_valid_in <= 1;
            end
        end
    end

    initial begin
        reset = 1;
        #20;
        reset = 0;
        #1000000000;
        $stop();
    end
            

endmodule
