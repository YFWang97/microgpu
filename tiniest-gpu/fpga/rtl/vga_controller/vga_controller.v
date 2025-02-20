module vga_controller(
    input reset,
    input clk_20,
    input clk_25,
    input vga_data_valid_in,
    input [5:0] vga_data_in,
    output vga_ready_out,
    output vsync,
    output hsync,
    output reg [5:0] rgb
);
// Due to the limiation of BRAM on FPGA, only display the central 30 x 30 area
// X index from 295 to 344
// Y index from 215 to 264

localparam X_WINDOW_LOW = 'd305;
localparam X_WINDOW_HIGH = 'd334;
localparam Y_WINDOW_LOW = 'd225;
localparam Y_WINDOW_HIGH = 'd254;

localparam SCREEN_X = 'd799;
localparam SCREEN_Y = 'd524;
localparam SCREEN_X_VIS = 'd639;
localparam SCREEN_Y_VIS = 'd479;

(* ram_style = "block" *) reg [5:0] rgb_buf_0 [899:0];
(* ram_style = "block" *) reg [5:0] rgb_buf_1 [899:0];

reg pingpong;

wire write_buffer;
wire read_buffer;

assign write_buffer = pingpong;
assign read_buffer = ~pingpong; 

reg [9:0] write_x;
reg [9:0] write_y;
reg [11:0] write_index;

wire [9:0] read_x;
wire [9:0] read_y;
reg [11:0] read_index;

wire blank;

reg vga_ready_out_25;
reg vga_ready_out_20;

assign vga_ready_out = vga_ready_out_25 | vga_ready_out_20;

always @(posedge clk_25) begin
    if (reset) begin
        pingpong <= 0;
    end
    else begin
        if (vga_ready_out_25) begin
            pingpong <= ~pingpong;
        end
    end
end

always @(posedge clk_20) begin
    if (vga_data_valid_in) begin
        if ((write_x >= X_WINDOW_LOW && write_x <= X_WINDOW_HIGH) &&
            (write_y >= Y_WINDOW_LOW && write_y <= Y_WINDOW_HIGH)) begin
            if (vga_data_in == 'd0) begin
                if (write_buffer == 0) rgb_buf_0[write_index] <= 6'b111111;
                else rgb_buf_1[write_index] <= 6'b111111;
            end
            else begin
                if (write_buffer == 0) rgb_buf_0[write_index] <= vga_data_in[5:0];
                else rgb_buf_1[write_index] <= vga_data_in[5:0];
            end
        end
    end
end

always @(posedge clk_20) begin
    if (reset) begin
        write_x <= 'd0;
        write_y <= 'd0;
        write_index <= 'd0;
    end
    else begin
        if (vga_data_valid_in) begin
            write_x <= (write_x == SCREEN_X_VIS) ? 'd0 : (write_x + 'd1);
            write_y <= (write_x == SCREEN_X_VIS) ? ((write_y == SCREEN_Y_VIS) ? 'd0 : (write_y + 'd1)) : write_y;
    
            if ((write_x >= X_WINDOW_LOW && write_x <= X_WINDOW_HIGH) &&
                (write_y >= Y_WINDOW_LOW && write_y <= Y_WINDOW_HIGH)) begin
                write_index <= write_index + 'd1;
            end
        end
        else begin
            write_index <= 'd0;
        end
    end
end    

vga v(.clk(clk_25),.reset(reset), .HS (hsync),.VS (vsync), .x (read_x), .y (read_y), .blank (blank));

always @(posedge clk_25) begin
    if (reset) begin
        vga_ready_out_25 <= 0;
    end
    else begin
        if (vga_ready_out_20) begin
            vga_ready_out_25 <= 0;
        end
        else if (read_x == SCREEN_X && read_y == SCREEN_Y) begin
            vga_ready_out_25 <= 1;
        end
    end
end


always @(posedge clk_20) begin
    vga_ready_out_20 <= vga_ready_out_25;
end

always @(posedge clk_25) begin
    if (reset || vga_ready_out_25) begin
        read_index <= 'd0;
    end
    else begin
        if ((read_x >= X_WINDOW_LOW && read_x <= X_WINDOW_HIGH) &&
            (read_y >= Y_WINDOW_LOW && read_y <= Y_WINDOW_HIGH)) begin
            read_index <= read_index + 'd1;
        end
    end
end

always @(posedge clk_25) begin
    if (blank) begin 
        rgb <= 6'b100000;
    end
    else if ((read_x >= X_WINDOW_LOW && read_x <= X_WINDOW_HIGH) &&
             (read_y >= Y_WINDOW_LOW && read_y <= Y_WINDOW_HIGH)) begin
            if (read_buffer == 0) rgb <= rgb_buf_0[read_index];
            else rgb <= rgb_buf_1[read_index];
    end
    else begin
        rgb <= 6'b111010;
    end
end

endmodule
