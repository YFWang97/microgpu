/*
 * Copyright (c) 2024 Matt Pongsagon Vichitvejpaisal
 * SPDX-License-Identifier: Apache-2.0
 */
//`timescale 1ns / 1ps


module top_gpu (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n    // reset_n - low to reset
);

    wire clk_50, clk_40, clk_20, clk_25;
    wire vga_ready;
    wire vga_data_valid;
    wire [5:0] vga_data;
    wire [5:0] rgb;
    wire vsync, hsync, blank;

	clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_50(clk_50),
    .clk_40(clk_40),
    .clk_25(clk_25),
    .clk_20(clk_20),
    // Status and control signals
    .reset(!rst_n), // input reset
   // Clock in ports
    .clk_100(clk));      // input clk_100
	
    tt_um_pongsagon_tiniest_gpu gpu (
        .ena(1),
        .clk_40(clk_40),
        .clk_20(clk_20),
        .rst_n(rst_n),
        .rx(ui_in[3]),
        .vga_ready_in(vga_ready),
        .vga_data_valid_out(vga_data_valid),
        .vga_data_out(vga_data)
    );

    vga_controller vga_contoller_inst (
        .reset(!rst_n),
        .clk_20(clk_20),
        .clk_25(clk_25),
        .vga_data_valid_in(vga_data_valid),
        .vga_data_in(vga_data),
        .vga_ready_out(vga_ready),
        .vsync(uio_out[6]),
        .hsync(uio_out[7]),
        .rgb(rgb)
    );

    //vga v (
    //    .clk(clk_25),
    //    .reset(~rst_n),
    //    .HS(hsync),
    //    .VS(vsync),
    //    .blank(blank)
    //);

    //assign rgb = blank ? 6'd0 : 6'b010101;

    //assign uio_out[7] = hsync;
    //assign uio_out[3] = vsync;

    assign uio_out[0] = rgb[0];
    assign uio_out[1] = rgb[1];
    assign uio_out[2] = rgb[2];
    assign uio_out[3] = rgb[3];
    assign uio_out[4] = rgb[4];
    assign uio_out[5] = rgb[5];
    
    //assign {uio_out[6], uio_out[5], uio_out[4], uio_out[2], uio_out[1], uio_out[0]} = rgb;

    reg debug_vga_data_valid;
    reg debug_vga_ready;
    reg [5:0] debug_vga_data;

    assign uio_oe = 8'b11000011;
    assign uo_out[0] = debug_vga_data_valid;
    assign uo_out[1] = debug_vga_ready;
    assign uo_out[2+:6] = debug_vga_data;
    
    always @(posedge clk) begin
        if (vga_data_valid) debug_vga_data_valid <= 1;
        if (vga_ready) debug_vga_ready <= 1;
        if (vga_data != 0) debug_vga_data <= 6'b110011;
    end
    

endmodule

