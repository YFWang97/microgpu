module vs_top 
#(
    parameter FIXED_WIDTH = 16,
    parameter INDEX_BIT   = 4,
	parameter WIDTH = 32
)
(
    input           clk,
    input           reset,
    
	input	[9:0]	x,
	input	[9:0]	y,
    
    input   [FIXED_WIDTH * 3 - 1:0] 	vertex_buffer_vs_data,
    output  [INDEX_BIT - 1:0]   		vs_vertex_buffer_index,

    output reg [FIXED_WIDTH * 3 - 1:0]	vs_vs_vertex_data,
    output reg [INDEX_BIT - 1:0]   		vs_vs_vertex_index,
    output reg                     		vs_vs_vertex_wr,

    output reg [FIXED_WIDTH * 2 - 1:0] 	vs_2d_vertex_data,
    output reg [INDEX_BIT - 1:0]   		vs_2d_vertex_index,
    output reg 							vs_2d_vertex_wr,
    
    input   [INDEX_BIT - 1:0]   		num_vertex_in,

    input   [FIXED_WIDTH * 3 - 1:0] 	camera_coord_in,
    input   [FIXED_WIDTH * 3 - 1:0] 	camera_g_in,
    input   [FIXED_WIDTH * 3 - 1:0] 	camera_t_in,
    
    input   [FIXED_WIDTH - 1:0]     	rot_x_in,
    input   [FIXED_WIDTH - 1:0]     	rot_y_in,
    input   [FIXED_WIDTH - 1:0]     	rot_z_in,   

    input   [FIXED_WIDTH - 1:0]     	tran_x_in,
    input   [FIXED_WIDTH - 1:0]     	tran_y_in,
    input   [FIXED_WIDTH - 1:0]     	tran_z_in,   

	output								busy

);
    reg [INDEX_BIT - 1:0]   		curr_state;
    reg [INDEX_BIT - 1:0]   		next_state;

    reg [INDEX_BIT - 1:0]   		num_vertex_reg;
    reg [INDEX_BIT - 1:0]   		curr_vertex_index_reg;

    reg [FIXED_WIDTH - 1:0] 		camera_coord_x_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_coord_y_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_coord_z_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_g_x_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_g_y_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_g_z_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_t_x_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_t_y_reg;
    reg [FIXED_WIDTH - 1:0] 		camera_t_z_reg;

    reg [FIXED_WIDTH - 1:0]     	rot_x_reg;
    reg [FIXED_WIDTH - 1:0]     	rot_y_reg;
    reg [FIXED_WIDTH - 1:0]     	rot_z_reg;

    reg [FIXED_WIDTH - 1:0]     	tran_x_reg;
    reg [FIXED_WIDTH - 1:0]     	tran_y_reg;
    reg [FIXED_WIDTH - 1:0]     	tran_z_reg;

	wire signed [FIXED_WIDTH * 2 - 1:0] camera_g_x_t_0;
	wire signed [FIXED_WIDTH * 2 - 1:0] camera_g_x_t_1;
	wire signed [FIXED_WIDTH * 2 - 1:0] camera_g_x_t_2;

	assign camera_g_x_t_0 = camera_g_y_reg * camera_t_z_reg - camera_g_z_reg * camera_t_y_reg;
	assign camera_g_x_t_1 = camera_g_z_reg * camera_t_x_reg - camera_g_x_reg * camera_t_z_reg;
	assign camera_g_x_t_2 = camera_g_x_reg * camera_t_y_reg - camera_g_y_reg * camera_t_x_reg;

    localparam  S_IDLE          				= 'd0;
    localparam  S_GET_PARAM     				= 'd1;
	localparam	S_SAVE_MATRIX					= 'd2;
	localparam	S_INIT_SYS_ARR					= 'd3;
    localparam  S_DOT_PROD_INTER		   		= 'd4;
	localparam	S_GET_VERTEX					= 'd5;
	localparam	S_DOT_PROD_OVERALL				= 'd6;
	localparam	S_DOT_PROD_VIEW_AND_NORM		= 'd7;
	localparam	S_DOT_PROD_VIEWPOINT			= 'd8;
	localparam	S_WRITE_OUT						= 'd9;

	assign busy = (curr_state != S_IDLE);

    wire	[1:0]	div_done;
    reg     [1:0]	div_start;
    wire    [1:0]	div_valid;
	wire	[1:0]	div_busy;
	wire	[1:0]	div_ovf;
	reg signed	[FIXED_WIDTH * 2 - 1:0] div_in	[1:0];
	wire signed	[FIXED_WIDTH * 2 - 1:0] div_out	[1:0];
	

	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	overall_x;
	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	overall_y;
	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	overall_z;
	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	overall_w;

	reg signed	[FIXED_WIDTH * 2 - 1:0] normed_overall_x;
	reg signed	[FIXED_WIDTH * 2 - 1:0] normed_overall_y;

	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	view_x;
	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	view_y;
	reg	signed 	[FIXED_WIDTH * 2 - 1:0]	view_z;

	reg signed	[FIXED_WIDTH * 2 - 1:0] result_2d_x;
	reg signed	[FIXED_WIDTH * 2 - 1:0] result_2d_y;

	wire start;
	//TODO: Check coordinate
	assign start = (y == 'd480) && (x == 'd0);
	
	//Each word has 4 16bit fixed point numbers
	//Total is 8 matrices stores
	//TODO: Replace it with a register file instance
	reg [FIXED_WIDTH * 4 - 1:0] matrix_reg_file [39:0];

	reg [FIXED_WIDTH - 1:0] 	cos_arr[89:0];
	reg [FIXED_WIDTH - 1:0] 	sin_arr[89:0];

	initial begin
		sin_arr[0] = 16'b0000000000000000;	cos_arr[0] = 16'b0100000000000000;
		sin_arr[1] = 16'b0000000100011110;	cos_arr[1] = 16'b0011111111111110;
		sin_arr[2] = 16'b0000001000111100;	cos_arr[2] = 16'b0011111111110110;
		sin_arr[3] = 16'b0000001101011001;	cos_arr[3] = 16'b0011111111101010;
		sin_arr[4] = 16'b0000010001110111;	cos_arr[4] = 16'b0011111111011000;
		sin_arr[5] = 16'b0000010110010100;	cos_arr[5] = 16'b0011111111000010;
		sin_arr[6] = 16'b0000011010110001;	cos_arr[6] = 16'b0011111110100110;
		sin_arr[7] = 16'b0000011111001101;	cos_arr[7] = 16'b0011111110000110;
		sin_arr[8] = 16'b0000100011101000;	cos_arr[8] = 16'b0011111101100001;
		sin_arr[9] = 16'b0000101000000011;	cos_arr[9] = 16'b0011111100110110;
		sin_arr[10] = 16'b0000101100011101;	cos_arr[10] = 16'b0011111100000111;
		sin_arr[11] = 16'b0000110000110110;	cos_arr[11] = 16'b0011111011010011;
		sin_arr[12] = 16'b0000110101001110;	cos_arr[12] = 16'b0011111010011010;
		sin_arr[13] = 16'b0000111001100110;	cos_arr[13] = 16'b0011111001011100;
		sin_arr[14] = 16'b0000111101111100;	cos_arr[14] = 16'b0011111000011001;
		sin_arr[15] = 16'b0001000010010000;	cos_arr[15] = 16'b0011110111010010;
		sin_arr[16] = 16'b0001000110100100;	cos_arr[16] = 16'b0011110110000101;
		sin_arr[17] = 16'b0001001010110110;	cos_arr[17] = 16'b0011110100110100;
		sin_arr[18] = 16'b0001001111000111;	cos_arr[18] = 16'b0011110011011110;
		sin_arr[19] = 16'b0001010011010110;	cos_arr[19] = 16'b0011110010000011;
		sin_arr[20] = 16'b0001010111100100;	cos_arr[20] = 16'b0011110000100100;
		sin_arr[21] = 16'b0001011011110000;	cos_arr[21] = 16'b0011101111000000;
		sin_arr[22] = 16'b0001011111111010;	cos_arr[22] = 16'b0011101101010111;
		sin_arr[23] = 16'b0001100100000010;	cos_arr[23] = 16'b0011101011101010;
		sin_arr[24] = 16'b0001101000001000;	cos_arr[24] = 16'b0011101001111000;
		sin_arr[25] = 16'b0001101100001100;	cos_arr[25] = 16'b0011101000000001;
		sin_arr[26] = 16'b0001110000001110;	cos_arr[26] = 16'b0011100110000110;
		sin_arr[27] = 16'b0001110100001110;	cos_arr[27] = 16'b0011100100000110;
		sin_arr[28] = 16'b0001111000001100;	cos_arr[28] = 16'b0011100010000010;
		sin_arr[29] = 16'b0001111100000111;	cos_arr[29] = 16'b0011011111111010;
		sin_arr[30] = 16'b0010000000000000;	cos_arr[30] = 16'b0011011101101101;
		sin_arr[31] = 16'b0010000011110110;	cos_arr[31] = 16'b0011011011011100;
		sin_arr[32] = 16'b0010000111101010;	cos_arr[32] = 16'b0011011001000110;
		sin_arr[33] = 16'b0010001011011011;	cos_arr[33] = 16'b0011010110101101;
		sin_arr[34] = 16'b0010001111001010;	cos_arr[34] = 16'b0011010100001111;
		sin_arr[35] = 16'b0010010010110101;	cos_arr[35] = 16'b0011010001101101;
		sin_arr[36] = 16'b0010010110011110;	cos_arr[36] = 16'b0011001111000111;
		sin_arr[37] = 16'b0010011010000100;	cos_arr[37] = 16'b0011001100011101;
		sin_arr[38] = 16'b0010011101100111;	cos_arr[38] = 16'b0011001001101111;
		sin_arr[39] = 16'b0010100001000111;	cos_arr[39] = 16'b0011000110111101;
		sin_arr[40] = 16'b0010100100100011;	cos_arr[40] = 16'b0011000100000111;
		sin_arr[41] = 16'b0010100111111101;	cos_arr[41] = 16'b0011000001001101;
		sin_arr[42] = 16'b0010101011010011;	cos_arr[42] = 16'b0010111110010000;
		sin_arr[43] = 16'b0010101110100110;	cos_arr[43] = 16'b0010111011001110;
		sin_arr[44] = 16'b0010110001110101;	cos_arr[44] = 16'b0010111000001010;
		sin_arr[45] = 16'b0010110101000001;	cos_arr[45] = 16'b0010110101000001;
		sin_arr[46] = 16'b0010111000001010;	cos_arr[46] = 16'b0010110001110101;
		sin_arr[47] = 16'b0010111011001110;	cos_arr[47] = 16'b0010101110100110;
		sin_arr[48] = 16'b0010111110010000;	cos_arr[48] = 16'b0010101011010011;
		sin_arr[49] = 16'b0011000001001101;	cos_arr[49] = 16'b0010100111111101;
		sin_arr[50] = 16'b0011000100000111;	cos_arr[50] = 16'b0010100100100011;
		sin_arr[51] = 16'b0011000110111101;	cos_arr[51] = 16'b0010100001000111;
		sin_arr[52] = 16'b0011001001101111;	cos_arr[52] = 16'b0010011101100111;
		sin_arr[53] = 16'b0011001100011101;	cos_arr[53] = 16'b0010011010000100;
		sin_arr[54] = 16'b0011001111000111;	cos_arr[54] = 16'b0010010110011110;
		sin_arr[55] = 16'b0011010001101101;	cos_arr[55] = 16'b0010010010110101;
		sin_arr[56] = 16'b0011010100001111;	cos_arr[56] = 16'b0010001111001010;
		sin_arr[57] = 16'b0011010110101101;	cos_arr[57] = 16'b0010001011011011;
		sin_arr[58] = 16'b0011011001000110;	cos_arr[58] = 16'b0010000111101010;
		sin_arr[59] = 16'b0011011011011100;	cos_arr[59] = 16'b0010000011110110;
		sin_arr[60] = 16'b0011011101101101;	cos_arr[60] = 16'b0010000000000000;
		sin_arr[61] = 16'b0011011111111010;	cos_arr[61] = 16'b0001111100000111;
		sin_arr[62] = 16'b0011100010000010;	cos_arr[62] = 16'b0001111000001100;
		sin_arr[63] = 16'b0011100100000110;	cos_arr[63] = 16'b0001110100001110;
		sin_arr[64] = 16'b0011100110000110;	cos_arr[64] = 16'b0001110000001110;
		sin_arr[65] = 16'b0011101000000001;	cos_arr[65] = 16'b0001101100001100;
		sin_arr[66] = 16'b0011101001111000;	cos_arr[66] = 16'b0001101000001000;
		sin_arr[67] = 16'b0011101011101010;	cos_arr[67] = 16'b0001100100000010;
		sin_arr[68] = 16'b0011101101010111;	cos_arr[68] = 16'b0001011111111010;
		sin_arr[69] = 16'b0011101111000000;	cos_arr[69] = 16'b0001011011110000;
		sin_arr[70] = 16'b0011110000100100;	cos_arr[70] = 16'b0001010111100100;
		sin_arr[71] = 16'b0011110010000011;	cos_arr[71] = 16'b0001010011010110;
		sin_arr[72] = 16'b0011110011011110;	cos_arr[72] = 16'b0001001111000111;
		sin_arr[73] = 16'b0011110100110100;	cos_arr[73] = 16'b0001001010110110;
		sin_arr[74] = 16'b0011110110000101;	cos_arr[74] = 16'b0001000110100100;
		sin_arr[75] = 16'b0011110111010010;	cos_arr[75] = 16'b0001000010010000;
		sin_arr[76] = 16'b0011111000011001;	cos_arr[76] = 16'b0000111101111100;
		sin_arr[77] = 16'b0011111001011100;	cos_arr[77] = 16'b0000111001100110;
		sin_arr[78] = 16'b0011111010011010;	cos_arr[78] = 16'b0000110101001110;
		sin_arr[79] = 16'b0011111011010011;	cos_arr[79] = 16'b0000110000110110;
		sin_arr[80] = 16'b0011111100000111;	cos_arr[80] = 16'b0000101100011101;
		sin_arr[81] = 16'b0011111100110110;	cos_arr[81] = 16'b0000101000000011;
		sin_arr[82] = 16'b0011111101100001;	cos_arr[82] = 16'b0000100011101000;
		sin_arr[83] = 16'b0011111110000110;	cos_arr[83] = 16'b0000011111001101;
		sin_arr[84] = 16'b0011111110100110;	cos_arr[84] = 16'b0000011010110001;
		sin_arr[85] = 16'b0011111111000010;	cos_arr[85] = 16'b0000010110010100;
		sin_arr[86] = 16'b0011111111011000;	cos_arr[86] = 16'b0000010001110111;
		sin_arr[87] = 16'b0011111111101010;	cos_arr[87] = 16'b0000001101011001;
		sin_arr[88] = 16'b0011111111110110;	cos_arr[88] = 16'b0000001000111100;
		sin_arr[89] = 16'b0011111111111110;	cos_arr[89] = 16'b0000000100011110;
		sin_arr[90] = 16'b0100000000000000;	cos_arr[90] = 16'b0000000000000000;
	end

	reg [FIXED_WIDTH * 4 - 1:0] mat_in_a_reg_arr	[3:0];
	reg [FIXED_WIDTH * 4 - 1:0] mat_in_b_reg_arr	[3:0];

	reg signed [WIDTH - 1:0]	mat_in_a_reg		[3:0];
	reg signed [WIDTH - 1:0]	mat_in_b_reg		[3:0];

	wire signed [WIDTH - 1:0]	mat_out				[3:0][3:0];

	reg			[7:0] 			tag_mat_reg		 		[3:0];
	reg			[7:0] 			tag_arr_reg		 		[3:0];
	reg			[7:0] 			tag_dat_reg				[3:0];
	reg 		[7:0] 			matrix_index_reg		[3:0];
	reg 		[7:0] 			matrix_index_sys_reg	[3:0];

	reg	[FIXED_WIDTH * 4 - 1:0] mat_overall				[3:0];
	reg	[FIXED_WIDTH * 4 - 1:0] mat_view				[3:0];

	parameter NUM_MATRIXES = 'd8;

    always @(posedge clk) begin
        if (reset) begin
            curr_state <= S_IDLE;
        end else begin
            curr_state <= next_state;
        end
    end

	reg [5:0] matrix_write_cnt;

	always @(*) begin
		case (curr_state)
			S_IDLE: 					next_state = start ? S_GET_PARAM : S_IDLE;
			S_GET_PARAM: 				next_state = S_SAVE_MATRIX;
			S_SAVE_MATRIX: 				next_state = (matrix_write_cnt == 'd32) ? S_INIT_SYS_ARR : S_SAVE_MATRIX;
			S_INIT_SYS_ARR:				next_state = S_DOT_PROD_INTER; 
			S_DOT_PROD_INTER: 			next_state = (matrix_index_sys_reg[3] == 'd8) ? S_GET_VERTEX : S_DOT_PROD_INTER;
			S_GET_VERTEX:				next_state = S_DOT_PROD_OVERALL;
			S_DOT_PROD_OVERALL:			next_state = S_DOT_PROD_VIEW_AND_NORM;
			S_DOT_PROD_VIEW_AND_NORM:	next_state = (&div_done) ? S_DOT_PROD_VIEWPOINT : S_DOT_PROD_VIEW_AND_NORM;
			S_DOT_PROD_VIEWPOINT:		next_state = S_WRITE_OUT;
			S_WRITE_OUT:				next_state = (curr_vertex_index_reg == num_vertex_reg - 'd1) ? S_IDLE : S_GET_VERTEX;
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			curr_vertex_index_reg <= 'd0;
		end else begin
			if (curr_state == S_WRITE_OUT) curr_vertex_index_reg <= curr_vertex_index_reg + 'd1;
			else if (curr_state == S_IDLE) curr_vertex_index_reg <= 'd0;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			matrix_write_cnt <= 'd0;
		end else begin
			if (curr_state == S_SAVE_MATRIX) begin
				matrix_write_cnt <= matrix_write_cnt + 'd1;
			end else begin
				matrix_write_cnt <= 'd0;
			end
		end
	end

    always @(posedge clk) begin
        case (curr_state)
            S_GET_PARAM: begin
				rot_x_reg <= rot_x_in;
				rot_y_reg <= rot_y_in;
				rot_z_reg <= rot_z_in;

				tran_x_reg <= tran_x_in;
				tran_y_reg <= tran_y_in;
				tran_z_reg <= tran_z_in;

				camera_g_x_reg <= camera_g_in[FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH];
				camera_g_y_reg <= camera_g_in[FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH];
				camera_g_z_reg <= camera_g_in[FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH];

				camera_t_x_reg <= camera_t_in[FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH];
				camera_t_y_reg <= camera_t_in[FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH];
				camera_t_z_reg <= camera_t_in[FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH];
					
				camera_coord_x_reg <= camera_coord_in[FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH];
				camera_coord_y_reg <= camera_coord_in[FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH];
				camera_coord_z_reg <= camera_coord_in[FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH];

				num_vertex_reg <= num_vertex_in;
			end
        endcase 
    end

	reg [FIXED_WIDTH - 1:0] rot_x_cos, rot_x_sin;
	reg [FIXED_WIDTH - 1:0] rot_y_cos, rot_y_sin;
	reg [FIXED_WIDTH - 1:0] rot_z_cos, rot_z_sin;

	always @(*) begin
		if (rot_x_reg < 90) begin
			rot_x_sin = sin_arr[rot_x_reg];
			rot_x_cos = sin_arr[90 - rot_x_reg];
		end else if (rot_x_reg < 180) begin
			rot_x_sin = sin_arr[180 - rot_x_reg];
			rot_x_cos = -sin_arr[rot_x_reg - 90];
		end else if (rot_x_reg < 270) begin
			rot_x_sin = -sin_arr[rot_x_reg - 180];
			rot_x_cos = -sin_arr[270 - rot_x_reg];
		end else if (rot_x_reg < 360) begin
			rot_x_sin = -sin_arr[360 - rot_x_reg];
			rot_x_cos = sin_arr[rot_x_reg - 270];
		end
	end

	always @(*) begin
		if (rot_y_reg < 90) begin
			rot_y_sin = sin_arr[rot_y_reg];
			rot_y_cos = sin_arr[90 - rot_y_reg];
		end else if (rot_y_reg < 180) begin
			rot_y_sin = sin_arr[180 - rot_y_reg];
			rot_y_cos = -sin_arr[rot_y_reg - 90];
		end else if (rot_y_reg < 270) begin
			rot_y_sin = -sin_arr[rot_y_reg - 180];
			rot_y_cos = -sin_arr[270 - rot_y_reg];
		end else if (rot_y_reg < 360) begin
			rot_y_sin = -sin_arr[360 - rot_y_reg];
			rot_y_cos = sin_arr[rot_y_reg - 270];
		end
	end

	always @(*) begin
		if (rot_z_reg < 90) begin
			rot_z_sin = sin_arr[rot_z_reg];
			rot_z_cos = sin_arr[90 - rot_z_reg];
		end else if (rot_z_reg < 180) begin
			rot_z_sin = sin_arr[180 - rot_z_reg];
			rot_z_cos = -sin_arr[rot_z_reg - 90];
		end else if (rot_z_reg < 270) begin
			rot_z_sin = -sin_arr[rot_z_reg - 180];
			rot_z_cos = -sin_arr[270 - rot_z_reg];
		end else if (rot_z_reg < 360) begin
			rot_z_sin = -sin_arr[360 - rot_z_reg];
			rot_z_cos = sin_arr[rot_z_reg - 270];
		end
	end

	integer i;
	always @(posedge clk) begin
		if (reset) begin
			for (i = 0; i < 40; i = i + 1) begin
				matrix_reg_file[i] <= 'd0;
			end
		end else begin
			if (curr_state == S_SAVE_MATRIX) begin
				case (matrix_write_cnt)
					//Rotation View
					//Q8.8
					'd0: matrix_reg_file[0] <= {camera_g_x_t_0[23 -: FIXED_WIDTH], camera_g_x_t_1[23 -: FIXED_WIDTH], camera_g_x_t_2[23 -: FIXED_WIDTH], 16'd0};
					'd1: matrix_reg_file[1] <= {camera_t_x_reg, camera_t_y_reg, camera_t_z_reg, 16'd0};
					'd2: matrix_reg_file[2] <= {-camera_g_x_reg, -camera_g_y_reg, -camera_g_z_reg, 16'd0};
					'd3: matrix_reg_file[3] <= {16'd0, 16'd0, 16'd0, {8'd1, 8'd0}};
					
					//Translation View
					//Q8.8
					'd4: matrix_reg_file[4] <= {{8'd1, 8'd0}, 16'd0, 16'd0, -camera_coord_x_reg};
					'd5: matrix_reg_file[5] <= {16'd0, {8'd1, 8'd0}, 16'd0, -camera_coord_y_reg};
					'd6: matrix_reg_file[6] <= {16'd0, 16'd0, {8'd1, 8'd0}, -camera_coord_z_reg};
					'd7: matrix_reg_file[7] <= {16'd0, 16'd0, 16'd0, {8'd1, 8'd0}};

					//Translation World
					//Q8.8
					'd8: matrix_reg_file[8] <= {{8'd1, 8'd0}, 16'd0, 16'd0, tran_x_reg};
					'd9: matrix_reg_file[9] <= {16'd0, {8'd1, 8'd0}, 16'd0, tran_y_reg};
					'd10: matrix_reg_file[10] <= {16'd0, 16'd0, {8'd1, 8'd0}, tran_z_reg};
					'd11: matrix_reg_file[11] <= {16'd0, 16'd0, 16'd0, {8'd1, 8'd0}};

					//Rotation Z
					//Q2.14
					'd12: matrix_reg_file[12] <= {cos_arr[rot_z_reg], -sin_arr[rot_z_reg], 16'd0, 16'd0};
					'd13: matrix_reg_file[13] <= {sin_arr[rot_z_reg], cos_arr[rot_z_reg], 16'd0, 16'd0};
					'd14: matrix_reg_file[14] <= {16'd0, 16'd0, {2'd1, 14'd0}, 16'd0};
					'd15: matrix_reg_file[15] <= {16'd0, 16'd0, 16'd0, {2'd1, 14'd0}};

					//Rotation Y
					//Q2.14
					'd16: matrix_reg_file[16] <= {cos_arr[rot_y_reg], 16'd0, sin_arr[rot_y_reg], 16'd0};
					'd17: matrix_reg_file[17] <= {16'd0, {2'd1, 14'd0}, 16'd0, 16'd0};
					'd18: matrix_reg_file[18] <= {-sin_arr[rot_y_reg], 16'd0, cos_arr[rot_y_reg], 16'd0};
					'd19: matrix_reg_file[19] <= {16'd0, 16'd0, 16'd0, {2'd1, 14'd0}};

					//Rotation X
					//Q2.14
					'd20: matrix_reg_file[20] <= {{2'd1, 14'd0}, 16'd0, 16'd0, 16'd0};
					'd21: matrix_reg_file[21] <= {16'd0, cos_arr[rot_x_reg], -sin_arr[rot_x_reg], 16'd0};
					'd22: matrix_reg_file[22] <= {16'd0, sin_arr[rot_x_reg], cos_arr[rot_x_reg], 16'd0};
					'd23: matrix_reg_file[23] <= {16'd0, 16'd0, 16'd0, {2'd1, 14'd0}};

					//Perspective
					//Q4.12
					//n = 1;
					//f = 50;
					//fovy = 45;
					//r = -l = 0.552285
					//t = -b = 0.414214
					//Equation refers to the ref model
					//Maximum number is 2.414213
					'd24: matrix_reg_file[24] <= {{4'd1, 12'b110011111000}, 16'd0, 16'd0, 16'd0};
					'd25: matrix_reg_file[25] <= {16'd0, {4'd2, 12'b011010100000}, 16'd0, 16'd0};
					'd26: matrix_reg_file[26] <= {16'd0, 16'd0, {4'b1110, 12'b111101011001}, {4'b1101, 12'b111101011001}};
					'd27: matrix_reg_file[27] <= {16'd0, 16'd0, {4'b1111, 12'b000000000000}, 16'd0};

					//Viewpoint
					//Q14.2
					'd28: matrix_reg_file[28] <= {{14'd320, 2'd0}, 16'd0, 16'd0, {14'd319, 2'b10}}; 
					'd29: matrix_reg_file[29] <= {16'd0, {-14'd240, 2'd0}, 16'd0, {14'd239, 2'b10}};
					'd30: matrix_reg_file[30] <= {16'd0, 16'd0, 16'd0, 16'd0};
					'd31: matrix_reg_file[31] <= {16'd0, 16'd0, 16'd0, 16'd0};

					//View
					//Q8.8
					//32, 33, 34, 35
					//
					//Overall
					//Q8.8
					//36, 37, 38, 39
				endcase
			end
		end
	end

	genvar row_index_genvar, col_index_genvar;
	generate	
	for (row_index_genvar = 0; row_index_genvar < 4; row_index_genvar = row_index_genvar + 1) begin
		always @(posedge clk) begin
			if (reset) begin
				tag_mat_reg[row_index_genvar]	<= 'hFF;
				tag_arr_reg[row_index_genvar]	<= 'hFF;
				tag_dat_reg[row_index_genvar] 	<= 'hFF;
			end else begin
				if (row_index_genvar == 0) begin
					case (curr_state) 
						S_IDLE: begin
							tag_mat_reg[row_index_genvar]	<= 'hFF;
							tag_arr_reg[row_index_genvar]	<= 'hFF;
							tag_dat_reg[row_index_genvar] 	<= 'hFF;
						end
						S_INIT_SYS_ARR: tag_mat_reg[row_index_genvar] <= 'd0;
						S_DOT_PROD_INTER: begin
							tag_mat_reg[row_index_genvar] <= (tag_mat_reg[row_index_genvar] == 'd4) ? 'd0 : (tag_mat_reg[row_index_genvar] + 'd1);
							tag_arr_reg[row_index_genvar] <= tag_mat_reg[row_index_genvar];
							tag_dat_reg[row_index_genvar] <= tag_arr_reg[row_index_genvar];
						end
					endcase
				end else begin
					case (curr_state)
						S_IDLE: begin
							tag_mat_reg[row_index_genvar]	<= 'hFF;
							tag_arr_reg[row_index_genvar]	<= 'hFF;
							tag_dat_reg[row_index_genvar] 	<= 'hFF;
						end
						S_DOT_PROD_INTER: begin
							tag_mat_reg[row_index_genvar] <= tag_mat_reg[row_index_genvar - 1];
							tag_arr_reg[row_index_genvar] <= tag_mat_reg[row_index_genvar];
							tag_dat_reg[row_index_genvar] <= tag_arr_reg[row_index_genvar];
						end
					endcase
				end	
			end
		end
	end
	endgenerate
	
	generate
	for (row_index_genvar = 0; row_index_genvar < 4; row_index_genvar = row_index_genvar + 1) begin
		always @(posedge clk) begin
			if (reset) begin
				matrix_index_reg[row_index_genvar] 		<= 'hFF;
				matrix_index_sys_reg[row_index_genvar]	<= 'hFF;
			end else begin
				case (curr_state)
					S_INIT_SYS_ARR: begin
						matrix_index_reg[row_index_genvar] <= 'd0;
						matrix_index_sys_reg[row_index_genvar] <= 'd0;
					end
					S_DOT_PROD_INTER: begin
						matrix_index_reg[row_index_genvar] <= (tag_mat_reg[row_index_genvar] == 'd4) ? (matrix_index_reg[row_index_genvar] + 'd1) : matrix_index_reg[row_index_genvar];
						matrix_index_sys_reg[row_index_genvar] <= (tag_arr_reg[row_index_genvar] == 'd4) ? (matrix_index_sys_reg[row_index_genvar] + 'd1) : matrix_index_sys_reg[row_index_genvar];
					end
					default: begin
						matrix_index_reg[row_index_genvar] <= 'hFF;
						matrix_index_sys_reg[row_index_genvar] <= 'hFF;
					end
				endcase
			end
		end
	end
	endgenerate

	reg	[7:0]	matrix_reg_file_addr;

	always @(posedge clk) begin
		if (reset) begin
			matrix_reg_file_addr <= 'd0;
		end else begin
			case (curr_state)
				//tag_mat_reg[3] == 'd0 indicates that last row/col will load from
				//matrix reg file and after will have a bubble so do not increment
				//matrix_reg_file_addr
				S_DOT_PROD_INTER:	matrix_reg_file_addr <= (tag_mat_reg[3] == 'd0) ? matrix_reg_file_addr : (matrix_reg_file_addr + 'd1);	
				default:			matrix_reg_file_addr <= 'd0;
			endcase
		end
	end

	generate 
	for (row_index_genvar = 0; row_index_genvar < 4; row_index_genvar = row_index_genvar + 1) begin 
		always @(posedge clk) begin
			if (reset) begin
				mat_in_a_reg_arr[row_index_genvar] <= 'd0;
			end else begin
				case (curr_state)
					S_DOT_PROD_INTER: begin
						if (tag_mat_reg[row_index_genvar] == 'd0) begin
							case (matrix_index_reg[row_index_genvar])
								'd0: 		mat_in_a_reg_arr[row_index_genvar] <= ({8'd1, 8'd0}) << ((3 - row_index_genvar) * 16);
								'd6: 		mat_in_a_reg_arr[row_index_genvar] <= matrix_reg_file[matrix_reg_file_addr];
								default: 	mat_in_a_reg_arr[row_index_genvar] <= 'd0;
							endcase
						end
					end	
					default: begin
						mat_in_a_reg_arr[row_index_genvar] <= 'd0;
					end
				endcase
			end
		end
	end
	endgenerate

	generate 
	for (col_index_genvar = 0; col_index_genvar < 4; col_index_genvar = col_index_genvar + 1) begin 
		always @(posedge clk) begin
			if (reset) begin
				mat_in_b_reg_arr[col_index_genvar] <= 'd0;
			end else begin
				case (curr_state)
					S_DOT_PROD_INTER: begin
						if (tag_mat_reg[col_index_genvar] == 'd0) begin
							case (matrix_index_reg[col_index_genvar])
								'd6: 		mat_in_b_reg_arr[col_index_genvar] <= 'd0;
								default: 	mat_in_b_reg_arr[col_index_genvar] <= matrix_reg_file[matrix_reg_file_addr];
							endcase
						end
					end	
					default: begin
						mat_in_b_reg_arr[col_index_genvar] <= 'd0;
					end
				endcase
			end
		end
	end
	endgenerate

	generate 
	for (row_index_genvar = 0; row_index_genvar < 4; row_index_genvar = row_index_genvar + 1) begin 
		always @(posedge clk) begin
			if (reset) begin
				mat_in_a_reg[row_index_genvar] <= 'd0;
			end else begin
				if (curr_state == S_DOT_PROD_INTER) begin
					if (matrix_index_reg[row_index_genvar] == 'd0 || matrix_index_reg[row_index_genvar] == 'd6) begin
						case (tag_arr_reg[row_index_genvar]) 
							'd0: mat_in_a_reg[row_index_genvar] <= $signed(mat_in_a_reg_arr[row_index_genvar][FIXED_WIDTH * 4 - 1 -: FIXED_WIDTH]);
							'd1: mat_in_a_reg[row_index_genvar] <= $signed(mat_in_a_reg_arr[row_index_genvar][FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH]);
							'd2: mat_in_a_reg[row_index_genvar] <= $signed(mat_in_a_reg_arr[row_index_genvar][FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH]);
							'd3: mat_in_a_reg[row_index_genvar] <= $signed(mat_in_a_reg_arr[row_index_genvar][FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH]);
						endcase
					end else begin
						if (tag_arr_reg[row_index_genvar] < 'd4) begin
							if (matrix_index_reg[row_index_genvar] <= 'd3) begin 
								mat_in_a_reg[row_index_genvar] <= $signed(mat_out[row_index_genvar][tag_arr_reg[row_index_genvar]][23 -: FIXED_WIDTH]);	
							end
							else if (matrix_index_reg[row_index_genvar] <= 'd5) begin
								mat_in_a_reg[row_index_genvar] <= $signed(mat_out[row_index_genvar][tag_arr_reg[row_index_genvar]][29 -: FIXED_WIDTH]);	
							end
						end else begin
							mat_in_a_reg[row_index_genvar] <= 'd0;	
						end
					end
				end
				else begin
					mat_in_a_reg[row_index_genvar] <= 'd0;
				end
			end
		end
	end
	endgenerate

	generate 
	for (col_index_genvar = 0; col_index_genvar < 4; col_index_genvar = col_index_genvar + 1) begin 
		always @(posedge clk) begin
			if (reset) begin
				mat_in_b_reg[col_index_genvar] <= 'd0;
			end else begin
				if (curr_state == S_DOT_PROD_INTER) begin
					if (matrix_index_reg[col_index_genvar] < 'd6) begin
						case (tag_arr_reg[col_index_genvar]) 
							'd0: mat_in_b_reg[col_index_genvar] <= $signed(mat_in_b_reg_arr[0][FIXED_WIDTH * (4 - col_index_genvar) - 1 -: FIXED_WIDTH]);
							'd1: mat_in_b_reg[col_index_genvar] <= $signed(mat_in_b_reg_arr[1][FIXED_WIDTH * (4 - col_index_genvar) - 1 -: FIXED_WIDTH]);
							'd2: mat_in_b_reg[col_index_genvar] <= $signed(mat_in_b_reg_arr[2][FIXED_WIDTH * (4 - col_index_genvar) - 1 -: FIXED_WIDTH]);
							'd3: mat_in_b_reg[col_index_genvar] <= $signed(mat_in_b_reg_arr[3][FIXED_WIDTH * (4 - col_index_genvar) - 1 -: FIXED_WIDTH]);
						endcase
					end else begin
						if (matrix_index_reg[col_index_genvar] == 'd6) begin
							mat_in_b_reg[col_index_genvar] <= $signed(mat_out[tag_arr_reg[col_index_genvar]][col_index_genvar][29 -: FIXED_WIDTH]);
						end else begin
							mat_in_b_reg[col_index_genvar] <= 'd0;
						end
					end
				end
				else begin
					mat_in_b_reg[col_index_genvar] <= 'd0;
				end
			end
		end
	end
	endgenerate

	generate 
	for (row_index_genvar = 0; row_index_genvar < 4; row_index_genvar = row_index_genvar + 1) begin 
		always @(posedge clk) begin
			if (reset) begin
				mat_view[row_index_genvar] 		<= 'd0;
				mat_overall[row_index_genvar]	<= 'd0;
			end else begin
				if (matrix_index_sys_reg[row_index_genvar] == 'd6) begin
					case (tag_arr_reg[row_index_genvar])
						'd0: mat_view[row_index_genvar] <= mat_view[row_index_genvar] | (mat_out[row_index_genvar][0][29 -: FIXED_WIDTH] <<  (3 * 16));
						'd1: mat_view[row_index_genvar] <= mat_view[row_index_genvar] | (mat_out[row_index_genvar][1][29 -: FIXED_WIDTH] <<  (2 * 16));
						'd2: mat_view[row_index_genvar] <= mat_view[row_index_genvar] | (mat_out[row_index_genvar][2][29 -: FIXED_WIDTH] <<  (1 * 16));
						'd3: mat_view[row_index_genvar] <= mat_view[row_index_genvar] | (mat_out[row_index_genvar][3][29 -: FIXED_WIDTH] <<  (0 * 16));
					endcase
				end else if (matrix_index_sys_reg[row_index_genvar] == 'd7) begin
					case (tag_arr_reg[row_index_genvar])
						'd0: mat_overall[row_index_genvar] <= mat_overall[row_index_genvar] | (mat_out[row_index_genvar][0][27 -: FIXED_WIDTH] <<  (3 * 16));
						'd1: mat_overall[row_index_genvar] <= mat_overall[row_index_genvar] | (mat_out[row_index_genvar][1][27 -: FIXED_WIDTH] <<  (2 * 16));
						'd2: mat_overall[row_index_genvar] <= mat_overall[row_index_genvar] | (mat_out[row_index_genvar][2][27 -: FIXED_WIDTH] <<  (1 * 16));
						'd3: mat_overall[row_index_genvar] <= mat_overall[row_index_genvar] | (mat_out[row_index_genvar][3][27 -: FIXED_WIDTH] <<  (0 * 16));
					endcase
				end else if (curr_state == S_IDLE) begin
					mat_overall[row_index_genvar] <= 'd0;
					mat_view[row_index_genvar] <= 'd0;
				end
			end
		end
	end
	endgenerate

	wire [3:0] out_valid;

	assign out_valid[0] = (tag_dat_reg[0] == 'd4);
	assign out_valid[1] = (tag_dat_reg[1] == 'd4);
	assign out_valid[2] = (tag_dat_reg[2] == 'd4);
	assign out_valid[3] = (tag_dat_reg[3] == 'd4);
	
	sys_arr sys_arr_inst (
		.clk(clk),
		.reset(reset),
		
		.A0(mat_in_a_reg[0]),
		.A1(mat_in_a_reg[1]),
		.A2(mat_in_a_reg[2]),
		.A3(mat_in_a_reg[3]),
		.B0(mat_in_b_reg[0]),
		.B1(mat_in_b_reg[1]),
		.B2(mat_in_b_reg[2]),
		.B3(mat_in_b_reg[3]),
		.C00(mat_out[0][0]),
		.C01(mat_out[0][1]),
		.C02(mat_out[0][2]),
		.C03(mat_out[0][3]),
		.C10(mat_out[1][0]),
		.C11(mat_out[1][1]),
		.C12(mat_out[1][2]),
		.C13(mat_out[1][3]),
		.C20(mat_out[2][0]),
		.C21(mat_out[2][1]),
		.C22(mat_out[2][2]),
		.C23(mat_out[2][3]),
		.C30(mat_out[3][0]),
		.C31(mat_out[3][1]),
		.C32(mat_out[3][2]),
		.C33(mat_out[3][3]),

		.tag_0(tag_dat_reg[0]),
		.tag_1(tag_dat_reg[1]),
		.tag_2(tag_dat_reg[2]),
		.tag_3(tag_dat_reg[3])
	);

	reg 	[FIXED_WIDTH * 4 - 1:0] matrix_dot_in   [3:0];
	wire 	[FIXED_WIDTH * 2 - 1:0]	matrix_dot_out	[3:0];

	wire signed 	[FIXED_WIDTH - 1:0] screen_scale_x = {14'd320, 2'b00};
	wire signed 	[FIXED_WIDTH - 1:0] screen_trans_x = {14'd319, 2'b10};
	wire signed 	[FIXED_WIDTH - 1:0] screen_scale_y = {-14'd240, 2'b00};
	wire signed 	[FIXED_WIDTH - 1:0] screen_trans_y = {14'd239, 2'b10};

	wire signed		[FIXED_WIDTH * 2 - 1:0] norm_mul_x;
	wire signed		[FIXED_WIDTH * 2 - 1:0] norm_mul_y;

	assign norm_mul_x = $signed(normed_overall_x[23 -: FIXED_WIDTH]) * screen_scale_x;
	assign norm_mul_y = $signed(normed_overall_y[23 -: FIXED_WIDTH]) * screen_scale_y;

	always @(posedge clk) begin
		if (reset) begin
			result_2d_x <= 'd0;
			result_2d_y <= 'd0;
			overall_x	<= 'd0;
			overall_z	<= 'd0;
			overall_w	<= 'd0;
			view_x		<= 'd0;
			view_y		<= 'd0;
			view_z		<= 'd0;
		end else begin
			case (curr_state) 
				S_DOT_PROD_OVERALL: begin
					overall_x <= matrix_dot_out[0];
					overall_y <= matrix_dot_out[1];
					overall_z <= matrix_dot_out[2];
					overall_w <= matrix_dot_out[3];
				end

				S_DOT_PROD_VIEW_AND_NORM: begin
					view_x <= matrix_dot_out[0];
					view_y <= matrix_dot_out[1];
					view_z <= matrix_dot_out[2];
				end

				S_DOT_PROD_VIEWPOINT: begin
					result_2d_x <= $signed(norm_mul_x[8 +: FIXED_WIDTH]) + screen_trans_x;
					result_2d_y <= $signed(norm_mul_y[8 +: FIXED_WIDTH]) + screen_trans_y; 
				end
			endcase
		end
	end

	always @(*) begin
		if (curr_state == S_DOT_PROD_OVERALL) begin
			matrix_dot_in[0] = mat_overall[0];
			matrix_dot_in[1] = mat_overall[1];
			matrix_dot_in[2] = mat_overall[2];
			matrix_dot_in[3] = mat_overall[3];
		end
		else if (curr_state == S_DOT_PROD_VIEW_AND_NORM) begin
			matrix_dot_in[0] = mat_view[0];
			matrix_dot_in[1] = mat_view[1];
			matrix_dot_in[2] = mat_view[2];
			matrix_dot_in[3] = 'd0;
		end
		else begin
			matrix_dot_in[0] = 'd0;
			matrix_dot_in[1] = 'd0;
			matrix_dot_in[2] = 'd0;
		end
	end

	reg [FIXED_WIDTH - 1:0] vertex_x;
	reg [FIXED_WIDTH - 1:0] vertex_y;
	reg [FIXED_WIDTH - 1:0] vertex_z;
	
	always @(posedge clk) begin
		if (reset) begin
			vertex_x <= 'd0;
			vertex_y <= 'd0;
			vertex_z <= 'd0;
		end
		else begin
			if (curr_state == S_GET_VERTEX) begin
				vertex_x <= vertex_buffer_vs_data[3 * FIXED_WIDTH - 1-:FIXED_WIDTH];
				vertex_y <= vertex_buffer_vs_data[2 * FIXED_WIDTH - 1-:FIXED_WIDTH];
				vertex_z <= vertex_buffer_vs_data[1 * FIXED_WIDTH - 1-:FIXED_WIDTH];
			end
		end
	end

	assign vs_vertex_buffer_index = curr_vertex_index_reg;
	
	matrix_dot_vec matrix_dot_vec_inst (
		.A0(matrix_dot_in[0]),
		.A1(matrix_dot_in[1]),
		.A2(matrix_dot_in[2]),
		.A3(matrix_dot_in[3]),
		.X0(vertex_x),
		.X1(vertex_y),
		.X2(vertex_z),
		.X3({8'd1, 8'd0}),
		.Y0(matrix_dot_out[0]),
		.Y1(matrix_dot_out[1]),
		.Y2(matrix_dot_out[2]),
		.Y3(matrix_dot_out[3])
	);

	genvar div_inst_genvar;
	generate
	for (div_inst_genvar = 0; div_inst_genvar < 2; div_inst_genvar = div_inst_genvar + 1) begin : loop_div
		div div_inst (
			.clk(clk),
			.rst(reset),
			.start(div_start[div_inst_genvar]),
			.done(div_done[div_inst_genvar]),
			.valid(div_valid[div_inst_genvar]),
			.a(div_in[div_inst_genvar]),
			.b(overall_w),
			.ovf(div_ovf[div_inst_genvar]),
			.val(div_out[div_inst_genvar])
		);

		always @(posedge clk) begin
			if (reset) begin
				div_start[div_inst_genvar] <= 0;
			end else begin
				if (curr_state == S_DOT_PROD_OVERALL) begin
					div_start[div_inst_genvar] <= 1;
				end else begin
					div_start[div_inst_genvar] <= 0;
				end
			end
		end
	end
	endgenerate

	always @(*) begin
		if (reset) begin
			div_in[0] = 'd0;
			div_in[1] = 'd0;
		end else begin
			if (curr_state == S_DOT_PROD_VIEW_AND_NORM) begin
				div_in[0] = overall_x;
				div_in[1] = overall_y;
			end else begin
				div_in[0] = 'd0;
				div_in[1] = 'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			normed_overall_x <= 'd0;
			normed_overall_y <= 'd0;
		end else begin
			if (curr_state == S_DOT_PROD_VIEW_AND_NORM) begin
				if (div_done[0]) normed_overall_x <= div_out[0];
				if (div_done[1]) normed_overall_y <= div_out[1];
			end
		end
	end

	always @(*) begin
		if (reset) begin
			vs_2d_vertex_index 	= 'd0;
			vs_2d_vertex_data 	= 'd0;
			vs_2d_vertex_wr 	= 0;
			vs_vs_vertex_index 	= 'd0;
			vs_vs_vertex_data	= 'd0;
			vs_vs_vertex_wr		= 0;
		end else begin
			if (curr_state == S_WRITE_OUT) begin
				vs_2d_vertex_index 	= curr_vertex_index_reg;
				vs_2d_vertex_data	= {result_2d_x[2 +: FIXED_WIDTH], result_2d_y[2 +: FIXED_WIDTH]};
				vs_2d_vertex_wr		= 1;
				vs_vs_vertex_index 	= curr_vertex_index_reg;
				vs_vs_vertex_data	= {view_x[23 -: FIXED_WIDTH], view_y[23 -: FIXED_WIDTH], view_z[23 -: FIXED_WIDTH]};
				vs_vs_vertex_wr		= 1;
			end else begin
				vs_2d_vertex_index 	= 'd0;
				vs_2d_vertex_data	= 'd0;
				vs_2d_vertex_wr		= 0;
				vs_vs_vertex_index 	= 'd0;
				vs_vs_vertex_data	= 'd0;
				vs_vs_vertex_wr		= 0;
			end
		end
	end


endmodule
