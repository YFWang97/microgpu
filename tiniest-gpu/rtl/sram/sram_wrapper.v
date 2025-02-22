`timescale 1ns/1ps
`define DELAY #0

module sram_wrapper # (
    parameter DW = 8, //bit
    parameter AW = 11 //words
) (
    input clk,
    input sram_sel,
    input cen, wen,
    input [AW-1:0] addr,
    input [DW-1:0] din,
    output [2*DW-1:0] dout
);

    wire cen_delayed;
    wire [AW-1:0] addr_delayed;
    wire [DW-1:0] din_delayed;

    assign `DELAY cen_delayed = cen;

    assign `DELAY addr_delayed = addr;
    assign `DELAY din_delayed = din;

    wire [2*DW-1:0] w_dout;

    assign dout = w_dout;

    sram_gpu sram00_inst1 (
        .CLK(clk),
        .CEN(cen_delayed),
        .WEN(wen || sram_sel),
        .A(addr_delayed),
        //.D({24'b0, din_delayed}),
	.D(din_delayed),
        .EMA(3'b000), //?
        .RETN(1'b1), //?
        .Q(w_dout[DW-1:0])
    );

    sram_gpu sram00_inst2 (
        .CLK(clk),
        .CEN(cen_delayed),
        .WEN(wen || (~sram_sel)),
        .A(addr_delayed),
        //.D({24'b0, din_delayed}),
	.D(din_delayed),
        .EMA(3'b000), //?
        .RETN(1'b1), //?
        .Q(w_dout[2*DW-1:DW])
    );
//sram_gpu (Q, CLK, CEN, WEN, A, D, EMA, RETN)
endmodule

