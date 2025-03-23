module pe 
#(
	parameter WIDTH = 32
)
(
	input clk,
	input reset,
	input 		signed	[WIDTH - 1:0] 	a_i,
	input 		signed	[WIDTH - 1:0] 	b_i,
	input 				[7:0]			t_i,
	output reg 	signed	[WIDTH - 1:0] 	a_o,
	output reg 	signed	[WIDTH - 1:0] 	b_o,
	output reg	signed	[WIDTH - 1:0] 	s_o,
	output reg 			[7:0]			t_o
);

	always @(posedge clk) begin
		//Keep at 0 at reset or
		//tag in is 0xFF or 0x4
		if (reset || t_i[2]) begin
			a_o <= 'd0;
			b_o <= 'd0;
			s_o <= 'd0;
		end else begin
			a_o <= a_i;
			b_o <= b_i;
			s_o <= s_o + a_i * b_i;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			t_o <= 'hFF;
		end else begin
			t_o <= t_i;
		end
	end

endmodule
