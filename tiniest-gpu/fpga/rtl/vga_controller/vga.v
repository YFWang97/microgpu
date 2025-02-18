//`timescale 1ns / 1ps
//`default_nettype wire

// 640x480 @60Hz
module vga(
	input clk, 		
	input reset,
	output HS, VS,
	output [9:0] x,
	output [9:0] y,
	output blank
	);
	
	// Counter Registers, two each for buffering to avoid glitches
	reg [9:0] xc, yc, xc_next, yc_next;
	
	// Horizontal 640 + fp 16 + HS 96 + bp 48 = 800 pixel clocks
	// Vertical, 480 + fp 10 lines + VS 2 lines + bp 33 lines = 525 lines
	assign blank = ((xc > 639) | (yc > 479));
	assign HS = ~ (xc > (655) && xc < (752));
	assign VS = ~ ((yc > 489) & (yc < 492));
	
	assign x = xc_next;
	assign y = yc_next;
	
	always @(posedge clk) begin
		if (reset) begin
			xc <= 0;
			yc <= 0;
			xc_next <= 0;
			yc_next <= 0;
		end
		else begin
            xc_next <= (xc_next == 'd799) ? 'd0 : xc_next + 'd1;
            yc_next <= (xc_next == 'd799) ? ((yc_next == 'd524) ? 'd0 : (yc_next + 'd1)) : y;
			xc <= xc_next;
			yc <= yc_next;
		end
	end
	
endmodule


