module top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n,    // reset_n - low to reset
    inout             VDD,
    inout             VSS
);

    wire [7:0] sram_data_in;
    wire [15:0] sram_data_out;
    wire [10:0] sram_addr;
    wire sram_sel;
    wire [10:0] addr_read;

    tt_um_pongsagon_tiniest_gpu gpu (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n),
        .addr_read(addr_read),
        .sram_data_out(sram_data_out)
    );

    wire phi, phib, scan_i0o1, load, scan_in;

    assign phi = uio_in[0];
    assign phib = uio_in[1];
    assign scan_i0o1 = uio_in[2];
    assign load = uio_in[3];
    assign scan_in = uio_in[4];

    wire [10:0] scan_chain_addr;

    scan_chain scan_chain_inst (
        .din(sram_data_in),
        .addr(scan_chain_addr),
        .sram_sel(sram_sel),
        .phi(phi),
        .phib(phib),
        .scan_i0o1(scan_i0o1),
        .load(load),
        .scan_in(scan_in),
        .VDD(VDD),
        .VSS(VSS)
    );

    assign sram_addr = (load) ? scan_chain_addr : addr_read;

    sram_wrapper sram_wrapper_inst (
        .clk(clk),
        .sram_sel(sram_sel),
        .cen(1'b0),
        .wen(~load),
        .addr(sram_addr),
	//.addr_read(addr_read),
        .din(sram_data_in),
        .dout(sram_data_out)
    );
endmodule
