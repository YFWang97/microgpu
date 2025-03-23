module matrix_dot_vec
#(
	parameter FIXED_WIDTH = 16
)
(
    
	input [63:0] A0,
	input [63:0] A1,
	input [63:0] A2,
	input [63:0] A3,
	input [15:0] X0,
	input [15:0] X1,
	input [15:0] X2,
	input [15:0] X3,

	output signed	[31:0] Y0,
	output signed	[31:0] Y1,
	output signed	[31:0] Y2,
	output signed	[31:0] Y3
);
	
	//wire signed [15:0] A0 [3:0];
	//wire signed [15:0] A1 [3:0];
	//wire signed [15:0] A2 [3:0];
	//wire signed [15:0] A3 [3:0];
	//
	//genvar i;
	//generate
	//for (i = 0; i < 4; i = i + 1 begin


	//end
	//engenerate
	

	assign Y0 = $signed(A0[FIXED_WIDTH * 4 - 1 -: 16]) * $signed(X0) + $signed(A0[FIXED_WIDTH * 3 - 1 -: 16]) * $signed(X1) + 
				$signed(A0[FIXED_WIDTH * 2 - 1 -: 16]) * $signed(X2) + $signed(A0[FIXED_WIDTH * 1 - 1 -: 16]) * $signed(X3);
	assign Y1 = $signed(A1[FIXED_WIDTH * 4 - 1 -: 16]) * $signed(X0) + $signed(A1[FIXED_WIDTH * 3 - 1 -: 16]) * $signed(X1) + 
				$signed(A1[FIXED_WIDTH * 2 - 1 -: 16]) * $signed(X2) + $signed(A1[FIXED_WIDTH * 1 - 1 -: 16]) * $signed(X3);
	assign Y2 = $signed(A2[FIXED_WIDTH * 4 - 1 -: 16]) * $signed(X0) + $signed(A2[FIXED_WIDTH * 3 - 1 -: 16]) * $signed(X1) + 
				$signed(A2[FIXED_WIDTH * 2 - 1 -: 16]) * $signed(X2) + $signed(A2[FIXED_WIDTH * 1 - 1 -: 16]) * $signed(X3);
	assign Y3 = $signed(A3[FIXED_WIDTH * 4 - 1 -: 16]) * $signed(X0) + $signed(A3[FIXED_WIDTH * 3 - 1 -: 16]) * $signed(X1) + 
				$signed(A3[FIXED_WIDTH * 2 - 1 -: 16]) * $signed(X2) + $signed(A3[FIXED_WIDTH * 1 - 1 -: 16]) * $signed(X3);

endmodule

