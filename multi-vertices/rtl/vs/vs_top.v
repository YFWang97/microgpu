module vs_top 
#(
    parameter FIXED_WIDTH = 16,
    parameter INDEX_BIT   = 4
)
(
    input           clk,
    input           reset,
    
    input           ia_vs_valid,
    
    input   [FIXED_WIDTH - 1:0] vertex_buffer_vs_data,
    output  [INDEX_BIT - 1:0]   vs_vertex_buffer_index,

    output  [FIXED_WIDTH - 1:0] vs_vs_vertex_data,
    output  [INDEX_BIT - 1:0]   vs_vs_vertex_index,
    output                      vs_vs_vertex_wr,

    output  [FIXED_WIDTH - 1:0] vs_2d_vertex_data,
    output  [INDEX_BIT - 1:0]   vs_2d_vertex_index,
    output  [INDEX_BIT - 1:0]   vs_2d_vertex_wr,
    
    input   [INDEX_BIT - 1:0]   num_vertex_in,

    input   [FIXED_WIDTH * 3 - 1:0]     camera_coord_in,
    input   [FIXED_WIDTH * 3 - 1:0]     camera_g_in,
    input   [FIXED_WIDTH * 3 - 1:0]     camera_t_in,
    
    input   [FIXED_WIDTH - 1:0]         rot_x_in,
    input   [FIXED_WIDTH - 1:0]         rot_y_in,
    input   [FIXED_WIDTH - 1:0]         rot_z_in   
);

    reg [INDEX_BIT - 1:0]   vs_vertex_buffer_index_reg;
    reg [FIXED_WIDTH - 1:0] vs_vs_vertex_data_reg;
    reg [INDEX_BIT - 1:0]   vs_vs_vertex_wr_reg;

    reg [FIXED_WIDTH - 1:0] vs_2d_vertex_data_reg;
    reg [INDEX_BIT - 1:0]   vs_2d_vertex_index_reg;
    reg [INDEX_BIT - 1:0]   vs_2d_vertex_wr_reg;

    reg [FIXED_WIDTH - 1:0] vs_inter_vertex [INDEX_BIT - 1:0];
    
    reg [INDEX_BIT - 1:0]   curr_state;
    reg [INDEX_BIT - 1:0]   next_state;

    reg [INDEX_BIT - 1:0]   num_vertex_reg;
    reg [INDEX_BIT - 1:0]   curr_vertex_index_reg;
    reg [FIXED_WIDTH * 3 - 1:0] camera_coord_reg;
    reg [FIXED_WIDTH * 3 - 1:0] camera_g_reg;
    reg [FIXED_WIDTH * 3 - 1:0] camera_t_reg;

    wire [FIXED_WIDTH - 1:0] camera_coord_x;
    wire [FIXED_WIDTH - 1:0] camera_coord_y;
    wire [FIXED_WIDTH - 1:0] camera_coord_z;
    wire [FIXED_WIDTH - 1:0] camera_g_x;
    wire [FIXED_WIDTH - 1:0] camera_g_y;
    wire [FIXED_WIDTH - 1:0] camera_g_z;
    wire [FIXED_WIDTH - 1:0] camera_t_x;
    wire [FIXED_WIDTH - 1:0] camera_t_y;
    wire [FIXED_WIDTH - 1:0] camera_t_z;

    assign camera_coord_x = camera_coord_reg [FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH];
    assign camera_coord_y = camera_coord_reg [FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH];
    assign camera_coord_z = camera_coord_reg [FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH];
    assign camera_g_x = camera_g_reg [FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH];
    assign camera_g_y = camera_g_reg [FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH];
    assign camera_g_z = camera_g_reg [FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH];
    assign camera_t_x = camera_t_reg [FIXED_WIDTH * 3 - 1 -: FIXED_WIDTH];
    assign camera_t_y = camera_t_reg [FIXED_WIDTH * 2 - 1 -: FIXED_WIDTH];
    assign camera_t_z = camera_t_reg [FIXED_WIDTH * 1 - 1 -: FIXED_WIDTH];

    reg [FIXED_WIDTH - 1:0]     rot_x_reg;
    reg [FIXED_WIDTH - 1:0]     rot_y_reg;
    reg [FIXED_WIDTH - 1:0]     rot_z_reg;

    localparam  S_IDLE          = 'd0;
    localparam  S_GET_PARAM     = 'd1;
    localparam  S_CONSTURCT_MAT = 'd2;
    localparam  S_GET_VERTEX    = 'd3;
    localparam  S_DOT_PROD_ROTAT_X    = 'd4;
    localparam  S_DOT_PROD_ROTAT_Y    = 'd5;
    localparam  S_DOT_PROD_ROTAT_Z    = 'd6;
    localparam  S_DOT_PROD_TRANS_WORLD  = 'd7;
    localparam  S_DOT_PROD_TRANS_VIEW   = 'd8;
    localparam  S_DOT_PROD_ROTAT_VIEW   = 'd9;
    localparam  S_WRITE_TO_VS           = 'd10;
    localparam  S_DOT_PROD_PERSP        = 'd11;
    localparam  S_NORM_TO_Z             = 'd12;
    localparam  S_DOT_PROD_VIEWPOINT    = 'd13;
    localparam  S_WRITE_TO_2D           = 'd14;

    wire    div_done;
    reg     div_start;

    reg [FIXED_WIDTH - 1:0] mat[3:0]][3:0];

    always @(posedge clk) begin
        if (reset) begin
            curr_state <= S_IDLE;
        end else begin
            curr_state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = S_IDLE;
        case (curr_state)
            S_IDLE:                 next_state = (ia_vs_valid) ? S_CONSTURCT_MAT : S_IDLE;
            S_CONSTURCT_MAT:        next_state = S_GET_VERTEX;
            S_GET_VERTEX:           next_state = S_DOT_PROD_ROTAT_X;
            S_DOT_PROD_ROTAT_X:     next_state = S_DOT_PROD_ROTAT_Y;
            S_DOT_PROD_ROTAT_Y:     next_state = S_DOT_PROD_ROTAT_Z;
            S_DOT_PROD_ROTAT_Z:     next_state = S_DOT_PROD_TRANS_WORLD;
            S_DOT_PROD_TRANS_WORLD: next_state = S_DOT_PROD_TRANS_VIEW;
            S_DOT_PROD_TRANS_VIEW:  next_state = S_DOT_PROD_ROTAT_VIEW;
            S_DOT_PROD_ROTAT_VIEW:  next_state = S_WRITE_TO_VS;
            S_WRITE_TO_VS:          next_state = S_DOT_PROD_PERSP;
            S_DOT_PROD_PERSP:       next_state = S_NORM_TO_Z;
            S_NORM_TO_Z:            next_state = (div_done) ? S_DOT_PROD_VIEWPOINT : S_NORM_TO_Z;
            S_DOT_PROD_VIEWPOINT:   next_state = S_WRITE_TO_2D;
            S_WRITE_TO_2D:          next_state = (curr_vertex_index_reg == num_vertex_reg) ? S_IDLE : S_GET_VERTEX;
            default:                next_state = S_IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            curr_vertex_index_reg <= 'd0;
        end else begin
            case (curr_state)
                S_IDLE: curr_vertex_index_reg <= 'd0;
                S_GET_VERTEX: curr_vertex_index_reg <= curr_vertex_index_reg + 'd1;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            num_vertex_reg <= 'd0;
        end else begin
            case (curr_state)
                S_GET_PARAM: num_vertex_reg <= num_vertex_in;
            endcase
        end
    end

    genvar row, col
    generate 
    for (row = 0; row < 4; row = row + 1) begin
        for (col = 0; col < 4; col = col + 1) begin
            always @(posedge clk) begin
                if (reset) begin
                    mat[row][col]<= 'd0;
                end else begin
                    case (curr_state) begin
                        



                end
            end
        end
    end
    endgenerate




    






endmodule
