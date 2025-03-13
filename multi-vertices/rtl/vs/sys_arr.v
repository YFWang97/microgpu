module sys_arr 
#(
	parameter WIDTH = 32,
	parameter ROWS = 4,
	parameter COLS = 4
)
(
	input	clk,
	input	reset,

	input 	signed	[WIDTH - 1:0] 	A0,
	input 	signed	[WIDTH - 1:0] 	A1,
	input 	signed	[WIDTH - 1:0] 	A2,
	input 	signed	[WIDTH - 1:0] 	A3,
	input 	signed	[WIDTH - 1:0] 	B0,
	input 	signed	[WIDTH - 1:0] 	B1,
	input 	signed	[WIDTH - 1:0] 	B2,
	input 	signed	[WIDTH - 1:0] 	B3,
	output 	signed	[WIDTH - 1:0] 	C00,
	output 	signed	[WIDTH - 1:0] 	C01,
	output 	signed	[WIDTH - 1:0] 	C02,
	output 	signed	[WIDTH - 1:0] 	C03,
	output 	signed	[WIDTH - 1:0] 	C10,
	output 	signed	[WIDTH - 1:0] 	C11,
	output 	signed	[WIDTH - 1:0] 	C12,
	output 	signed	[WIDTH - 1:0] 	C13,
	output 	signed	[WIDTH - 1:0] 	C20,
	output 	signed	[WIDTH - 1:0] 	C21,
	output 	signed	[WIDTH - 1:0] 	C22,
	output 	signed	[WIDTH - 1:0] 	C23,
	output 	signed	[WIDTH - 1:0] 	C30,
	output 	signed	[WIDTH - 1:0] 	C31,
	output 	signed	[WIDTH - 1:0] 	C32,
	output 	signed	[WIDTH - 1:0] 	C33,

	input 			[7:0]			tag_0,
	input			[7:0]			tag_1,
	input			[7:0]			tag_2,
	input			[7:0]			tag_3
);

	wire [WIDTH - 1:0]	a_i	[ROWS - 1:0][COLS - 1:0];
	wire [WIDTH - 1:0] 	b_i	[ROWS - 1:0][COLS - 1:0];
	wire [WIDTH - 1:0] 	a_o	[ROWS - 1:0][COLS - 1:0];
	wire [WIDTH - 1:0] 	b_o	[ROWS - 1:0][COLS - 1:0];
	wire [WIDTH - 1:0] 	s_o	[ROWS - 1:0][COLS - 1:0];
	wire [7:0] 			t_i	[ROWS - 1:0][COLS - 1:0];
	wire [7:0] 			t_o	[ROWS - 1:0][COLS - 1:0];

	genvar row, col;
	generate
		for (row = 0; row < ROWS; row = row + 1) begin
			for (col = 0; col < COLS; col = col + 1) begin
				
				pe pe_inst (
					.clk(clk),
					.reset(reset),
					.a_i(a_i[row][col]),
					.b_i(b_i[row][col]),
					.a_o(a_o[row][col]),
					.b_o(b_o[row][col]),
					.s_o(s_o[row][col]),
					.t_i(t_i[row][col]),
					.t_o(t_o[row][col])
				);

				if (col > 0) begin
					assign a_i[row][col] = a_o[row][col - 1];
					assign t_i[row][col] = t_o[row][col - 1];
				end

				if (row > 0) begin
					assign b_i[row][col] = b_o[row - 1][col];
				end
			end
		end
	endgenerate

	assign a_i[0][0] = A0;
	assign a_i[1][0] = A1;
	assign a_i[2][0] = A2;
	assign a_i[3][0] = A3;

	assign b_i[0][0] = B0;
	assign b_i[0][1] = B1;
	assign b_i[0][2] = B2;
	assign b_i[0][3] = B3;

	assign t_i[0][0] = tag_0;
	assign t_i[1][0] = tag_1;
	assign t_i[2][0] = tag_2;
	assign t_i[3][0] = tag_3;

	assign C00 = s_o[0][0];
	assign C01 = s_o[0][1];
	assign C02 = s_o[0][2];
	assign C03 = s_o[0][3];
	assign C10 = s_o[1][0];
	assign C11 = s_o[1][1];
	assign C12 = s_o[1][2];
	assign C13 = s_o[1][3];
	assign C20 = s_o[2][0];
	assign C21 = s_o[2][1];
	assign C22 = s_o[2][2];
	assign C23 = s_o[2][3];
	assign C30 = s_o[3][0];
	assign C31 = s_o[3][1];
	assign C32 = s_o[3][2];
	assign C33 = s_o[3][3];


endmodule
