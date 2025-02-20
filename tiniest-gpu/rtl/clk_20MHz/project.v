/*
 * Copyright (c) 2024 Matt Pongsagon Vichitvejpaisal
 * SPDX-License-Identifier: Apache-2.0
 */
//`timescale 1ns / 1ps


module tt_um_pongsagon_tiniest_gpu (
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk_40,
    input  wire       clk_20,
    input  wire       rst_n,    // reset_n - low to reset
    input  wire       rx,       // RX Bus for UART
    input  wire       vga_ready_in,
    output reg        vga_data_valid_out,
    output reg [5:0]  vga_data_out
);

	wire reset = !rst_n;


	// internal reg, between IA, VS
	reg pc_data_ready;					// true for 1 clk	 
	reg signed [15:0] x_world_v0;			// Q8.8
	reg signed [15:0] y_world_v0;
	reg signed [15:0] z_world_v0;
	reg signed [15:0] x_world_v1;
	reg signed [15:0] y_world_v1;
	reg signed [15:0] z_world_v1;
	reg signed [15:0] x_world_v2;
	reg signed [15:0] y_world_v2;
	reg signed [15:0] z_world_v2;
	reg signed [15:0] x_world_v3;
	reg signed [15:0] y_world_v3;
	reg signed [15:0] z_world_v3;
	reg signed [15:0] nx;					// Q2.14
	reg signed [15:0] ny;
	reg signed [15:0] nz;
	reg signed [15:0] light_x;			// Q2.14
	reg signed [15:0] light_y;
	reg signed [15:0] light_z;
	reg signed [15:0] vp_00;				// Q8.8
	reg signed [15:0] vp_01;
	reg signed [15:0] vp_02;
	reg signed [15:0] vp_03;
	reg signed [15:0] vp_10;				
	reg signed [15:0] vp_11;
	reg signed [15:0] vp_12;
	reg signed [15:0] vp_13;
	reg signed [15:0] vp_30;				
	reg signed [15:0] vp_31;
	reg signed [15:0] vp_32;
	reg signed [15:0] vp_33;
	reg [7:0] render_mode;				// [7:6] notuse, [5:4] tri 0 color, [3:2] tri 1 color, [1:0] render mode (uv, color, mask)


	wire [7:0] read_data;
	wire update_reg;		
	wire pc_ready;
	wire [6:0] idx;		// 0-60
	
	ia ia1(.clk(clk_40),.reset(reset),.rx(rx),.read_data(read_data),
			.idx(idx),.update_reg(update_reg),.pc_ready(pc_ready));


	//! verilator, assign something to wire has no driver warning
	//assign update_reg = 1'b0;
	//assign pc_ready = 1'b0;
	//assign idx = 6'b11_1111;


	// update internal reg from IA
	always @(posedge clk_40) begin
		if(reset) begin
			pc_data_ready <= 0;			
			x_world_v0 <= 0;			
			y_world_v0 <= 0;
			z_world_v0 <= 0;
			x_world_v1 <= 0;
			y_world_v1 <= 0;
			z_world_v1 <= 0;
			x_world_v2 <= 0;
			y_world_v2 <= 0;
			z_world_v2 <= 0;
			x_world_v3 <= 0;
			y_world_v3 <= 0;
			z_world_v3 <= 0;
			nx <= 0;				
			ny <= 0;
			nz <= 0;
			light_x <= 0;			
			light_y <= 0;
			light_z <= 0;
			vp_00 <= 0;				
			vp_01 <= 0;
			vp_02 <= 0;
			vp_03 <= 0;
			vp_10 <= 0;				
			vp_11 <= 0;
			vp_12 <= 0;
			vp_13 <= 0;
			vp_30 <= 0;				
			vp_31 <= 0;
			vp_32 <= 0;
			vp_33 <= 0;
			render_mode <= 0;
		end
        else begin
            x_world_v0  <= {8'hfe, 8'h58};
            y_world_v0  <= {8'h1, 8'h0};
            z_world_v0  <= {8'h0, 8'h0};
            x_world_v1  <= {8'hfe, 8'h58};
            y_world_v1  <= {8'hff, 8'h0};
            z_world_v1  <= {{'d15-'d0}, 8'h0};
            x_world_v2  <= {8'h1, 8'ha8};
            y_world_v2  <= {8'hff, 8'h0};
            z_world_v2  <= {{'d15-'d0}, 8'h0};
            nx          <= {8'h0, 8'h0};
            ny          <= {8'h0, 8'h0};
            nz          <= {8'h0, 8'hff};
            light_x     <= {8'h0, 8'h0};
            light_y     <= {8'h0, 8'h0};
            light_z     <= {8'd18, 8'hff};
            vp_00       <= {8'h1, 8'h3a};
            vp_01       <= {8'h0, 8'h0};
            vp_02       <= {8'h0, 8'h0};
            vp_03       <= {8'h0, 8'h0};
            vp_10       <= {8'h0, 8'h0};
            vp_11       <= {8'h2, 8'hc0};
            vp_12       <= {8'h0, 8'h0};
            vp_13       <= {8'h0, 8'h0};
            vp_30       <= {8'h0, 8'h0};
            vp_31       <= {8'h0, 8'h0};
            vp_32       <= {8'hff, 8'h1};
            vp_33       <= {8'h1d, 8'he2};
            x_world_v3  <= {8'h1, 8'ha8};
            y_world_v3  <= {8'h1, 8'h0};
            z_world_v3  <= {8'h0, 8'h0};
            render_mode <= 8'h38;

            pc_data_ready <= 1;
        end
        /*
		else begin
			if (update_reg) begin
				case(idx)
					0: begin
						x_world_v0[7:0] <= read_data;		
					end
					1: begin
						x_world_v0[15:8] <= read_data;	
					end
					2: begin
						y_world_v0[7:0] <= read_data;		
					end
					3: begin
						y_world_v0[15:8] <= read_data;		
					end
					4: begin
						z_world_v0[7:0] <= read_data;		
					end
					5: begin
						z_world_v0[15:8] <= read_data;		
					end
					6: begin
						x_world_v1[7:0] <= read_data;		
					end
					7: begin
						x_world_v1[15:8] <= read_data;	
					end
					8: begin
						y_world_v1[7:0] <= read_data;		
					end
					9: begin
						y_world_v1[15:8] <= read_data;		
					end
					10: begin
						z_world_v1[7:0] <= read_data;		
					end
					11: begin
						z_world_v1[15:8] <= read_data;		
					end
					12: begin
						x_world_v2[7:0] <= read_data;		
					end
					13: begin
						x_world_v2[15:8] <= read_data;	
					end
					14: begin
						y_world_v2[7:0] <= read_data;		
					end
					15: begin
						y_world_v2[15:8] <= read_data;		
					end
					16: begin
						z_world_v2[7:0] <= read_data;		
					end
					17: begin
						z_world_v2[15:8] <= read_data;		
					end
					18: begin
						nx[7:0] <= read_data;		
					end
					19: begin
						nx[15:8] <= read_data;		
					end
					20: begin
						ny[7:0] <= read_data;		
					end
					21: begin
						ny[15:8] <= read_data;		
					end
					22: begin
						nz[7:0] <= read_data;		
					end
					23: begin
						nz[15:8] <= read_data;		
					end
					24: begin
						light_x[7:0] <= read_data;		
					end
					25: begin
						light_x[15:8] <= read_data;		
					end
					26: begin
						light_y[7:0] <= read_data;		
					end
					27: begin
						light_y[15:8] <= read_data;		
					end
					28: begin
						light_z[7:0] <= read_data;		
					end
					29: begin
						light_z[15:8] <= read_data;		
					end
					30: begin
						vp_00[7:0] <= read_data;		
					end
					31: begin
						vp_00[15:8] <= read_data;		
					end
					32: begin
						vp_01[7:0] <= read_data;		
					end
					33: begin
						vp_01[15:8] <= read_data;		
					end
					34: begin
						vp_02[7:0] <= read_data;		
					end
					35: begin
						vp_02[15:8] <= read_data;		
					end
					36: begin
						vp_03[7:0] <= read_data;		
					end
					37: begin
						vp_03[15:8] <= read_data;		
					end
					38: begin
						vp_10[7:0] <= read_data;		
					end
					39: begin
						vp_10[15:8] <= read_data;		
					end
					40: begin
						vp_11[7:0] <= read_data;		
					end
					41: begin
						vp_11[15:8] <= read_data;		
					end
					42: begin
						vp_12[7:0] <= read_data;		
					end
					43: begin
						vp_12[15:8] <= read_data;		
					end
					44: begin
						vp_13[7:0] <= read_data;		
					end
					45: begin
						vp_13[15:8] <= read_data;		
					end
					46: begin
						vp_30[7:0] <= read_data;		
					end
					47: begin
						vp_30[15:8] <= read_data;		
					end
					48: begin
						vp_31[7:0] <= read_data;		
					end
					49: begin
						vp_31[15:8] <= read_data;		
					end
					50: begin
						vp_32[7:0] <= read_data;		
					end
					51: begin
						vp_32[15:8] <= read_data;		
					end
					52: begin
						vp_33[7:0] <= read_data;		
					end
					53: begin
						vp_33[15:8] <= read_data;		
					end
					54: begin
						x_world_v3[7:0] <= read_data;		
					end
					55: begin
						x_world_v3[15:8] <= read_data;	
					end
					56: begin
						y_world_v3[7:0] <= read_data;		
					end
					57: begin
						y_world_v3[15:8] <= read_data;		
					end
					58: begin
						z_world_v3[7:0] <= read_data;	
						z_world_v3[15:8] <= 8'b0000_0000;	// v3.z hi must be 0, no room to send 61st byte
					end
					59: begin
						//z_world_v3[15:8] <= read_data;	
						render_mode <= read_data;	
					end	
					// cant send 61 bytes, dont know why, may be too much for UART @115200, data is weirdly corrupted
					// 60 bytes still work, 
					60: begin
						//render_mode <= 8'b0100_0000;//read_data;	
					end	
					default: begin
						
					end
				endcase
			end
		end

		//! comment out for verilator
		pc_data_ready <= pc_ready;
        */
	end

	
	wire [5:0] rgb;
	wire [1:0] intensity;
	wire signed [19:0] y_screen_v0;		
	wire signed [19:0] y_screen_v1;	
	wire signed [19:0] y_screen_v2;
	wire signed [19:0] y_screen_v3;
	wire signed [19:0] e0_init_t1;
	wire signed [19:0] e1_init_t1;
	wire signed [19:0] e2_init_t1;
	wire signed [21:0] bar_iy;
    wire signed [21:0] bar_iy_dx;
    wire signed [21:0] bar_iz;		
    wire signed [21:0] bar_iz_dx;
    wire signed [21:0] bar2_iy;
    wire signed [21:0] bar2_iy_dx;
    wire signed [21:0] bar2_iz;		
    wire signed [21:0] bar2_iz_dx;
    wire signed [19:0] e0_init_t2;
	wire signed [19:0] e1_init_t2;
	wire signed [19:0] e2_init_t2;

    reg [9:0] x, y; 

	vs vs1(.clk(clk_40),.reset(reset),.x(x),.y(y),.pc_data_ready(pc_data_ready),
					.x_world_v0(x_world_v0),.y_world_v0(y_world_v0),.z_world_v0(z_world_v0),
					.x_world_v1(x_world_v1),.y_world_v1(y_world_v1),.z_world_v1(z_world_v1),
					.x_world_v2(x_world_v2),.y_world_v2(y_world_v2),.z_world_v2(z_world_v2),
					.x_world_v3(x_world_v3),.y_world_v3(y_world_v3),.z_world_v3(z_world_v3),
					.nx(nx),.ny(ny),.nz(nz),
					.light_x(light_x),.light_y(light_y),.light_z(light_z),
					.vp_00(vp_00),.vp_01(vp_01),.vp_02(vp_02),.vp_03(vp_03),
					.vp_10(vp_10),.vp_11(vp_11),.vp_12(vp_12),.vp_13(vp_13),
					.vp_30(vp_30),.vp_31(vp_31),.vp_32(vp_32),.vp_33(vp_33),.intensity(intensity),
					.y_screen_v0(y_screen_v0),.y_screen_v1(y_screen_v1),.y_screen_v2(y_screen_v2),.y_screen_v3(y_screen_v3),
					.e0_init_t1(e0_init_t1),.e1_init_t1(e1_init_t1),.e2_init_t1(e2_init_t1),
					.e0_init_t2(e0_init_t2),.e1_init_t2(e1_init_t2),.e2_init_t2(e2_init_t2),
					.bar_iy(bar_iy),.bar_iy_dx(bar_iy_dx),.bar_iz(bar_iz),.bar_iz_dx(bar_iz_dx),
					.bar2_iy(bar2_iy),.bar2_iy_dx(bar2_iy_dx),.bar2_iz(bar2_iz),.bar2_iz_dx(bar2_iz_dx));

	raster raster1(.clk(clk_40),.reset(reset),.x(x),.y(y),.intensity(intensity),.render_mode(render_mode),
					.y_screen_v0(y_screen_v0),.y_screen_v1(y_screen_v1),.y_screen_v2(y_screen_v2),.y_screen_v3(y_screen_v3),
					.e0_init_t1(e0_init_t1),.e1_init_t1(e1_init_t1),.e2_init_t1(e2_init_t1),
					.e0_init_t2(e0_init_t2),.e1_init_t2(e1_init_t2),.e2_init_t2(e2_init_t2),
					.bar_iy(bar_iy),.bar_iy_dx(bar_iy_dx),.bar_iz(bar_iz),.bar_iz_dx(bar_iz_dx),
					.bar2_iy(bar2_iy),.bar2_iy_dx(bar2_iy_dx),.bar2_iz(bar2_iz),.bar2_iz_dx(bar2_iz_dx),
					.rgb(rgb));

	//wire hsync;
	//wire vsync;
	//wire [9:0] x, y;
	//wire blank;
	//vga v(.clk (clk_40),.reset(reset), .HS (hsync),.VS (vsync), .x (x), .y (y), .blank (blank));

    always @(posedge clk_20) begin
        if (reset) begin
            x <= 'd0;
            y <= 'd0;
            vga_data_valid_out <= 0;
        end
        else begin
            if (vga_ready_in && ~vga_data_valid_out) begin
                vga_data_valid_out <= 1;
                x <= 'd0;
                y <= 'd0;
            end
            else begin
                if (x == 'd639 && y == 'd479) begin
                    vga_data_valid_out <= 0;
                end
                x <= (x == 'd650) ? 'd0 : (x + 'd1);
                y <= (x == 'd650) ? ((y == 'd480) ? 'd0 : (y + 'd1)) : y;
            end

        end
    end

    always @(*) begin
        if (reset) begin
            vga_data_out = 'd0;
        end
        else begin
            if (vga_data_valid_out) begin
                vga_data_out[0] = rgb[1];
                vga_data_out[1] = rgb[3];
                vga_data_out[2] = rgb[5];
                vga_data_out[3] = rgb[0];
                vga_data_out[4] = rgb[2];
                vga_data_out[5] = rgb[4];
            end
            else begin
                vga_data_out = 'd55;
            end
        end
    end

	//assign RGB = (blank)? 6'b000000: rgb;



	// All output pins must be assigned. If not used, assign to 0.
	
	// Output PMOD - Tiny VGA
    //assign uio_out[0] = RGB[1];
    //assign uio_out[1] = RGB[3];
    //assign uio_out[2] = RGB[5];
    //assign uio_out[3] = vsync;
    //assign uio_out[4] = RGB[0];
    //assign uio_out[5] = RGB[2];
    //assign uio_out[6] = RGB[4];
    //assign uio_out[7] = hsync;
	//
	//assign uio_oe[7:0] = 8'b1111_1111;
	//assign uo_out[7:0] = 0;


	//////////////////////////////
	//! verilator
	//////////////////////////////

	// always @(posedge clk) begin
	// 	pc_data_ready <= SIM_pc_data_ready;				
	// 	x_world_v0 <= SIM_x_world_v0;	
	// 	y_world_v0 <= SIM_y_world_v0;
	// 	z_world_v0 <= SIM_z_world_v0;
	// 	x_world_v1 <= SIM_x_world_v1;
	// 	y_world_v1 <= SIM_y_world_v1;
	// 	z_world_v1 <= SIM_z_world_v1;
	// 	x_world_v2 <= SIM_x_world_v2;
	// 	y_world_v2 <= SIM_y_world_v2;
	// 	z_world_v2 <= SIM_z_world_v2;
	// 	x_world_v3 <= SIM_x_world_v3;
	// 	y_world_v3 <= SIM_y_world_v3;
	// 	z_world_v3 <= SIM_z_world_v3;
	// 	nx <= SIM_nx;					
	// 	ny <= SIM_ny;
	// 	nz <= SIM_nz;
	// 	light_x <= SIM_light_x;			
	// 	light_y <= SIM_light_y;
	// 	light_z <= SIM_light_z;
	// 	vp_00 <= SIM_vp_00;				
	// 	vp_01 <= SIM_vp_01;
	// 	vp_02 <= SIM_vp_02;
	// 	vp_03 <= SIM_vp_03;
	// 	vp_10 <= SIM_vp_10;				
	// 	vp_11 <= SIM_vp_11;
	// 	vp_12 <= SIM_vp_12;
	// 	vp_13 <= SIM_vp_13;
	// 	vp_30 <= SIM_vp_30;				
	// 	vp_31 <= SIM_vp_31;
	// 	vp_32 <= SIM_vp_32;
	// 	vp_33 <= SIM_vp_33;
	// 	render_mode <= SIM_render_mode;
	// 	SIM_sx <= x;
    //     SIM_sy <= y;
    //     SIM_de <= ~blank;
    //     SIM_r <= {4{RGB[1:0]}};
    //     SIM_g <= {4{RGB[3:2]}};
    //     SIM_b <= {4{RGB[5:4]}};
	// end


	//////////////////////////////
	// fpga code to reduce clk from 100Mhz to 50Mhz
	//! commment this block in ASIC, verilator
	//////////////////////////////
	
	/*reg[27:0] counter=28'd0;
	parameter DIVISOR = 28'd2;
	reg clk;
	always @(posedge clk100)
	begin
		counter <= counter + 28'd1;
		if(counter>=(DIVISOR-1))
			counter <= 28'd0;

		clk <= (counter<DIVISOR/2)?1'b1:1'b0;
	end*/


endmodule

