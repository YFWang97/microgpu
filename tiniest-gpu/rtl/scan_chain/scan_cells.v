//SCAN CELLS FOR ST 65

module so_bit( phi, phib, scan_i0o1, load, scan_in, chip_out, phi_out, phib_out, scan_i0o1_out, load_out, scan_out, VDD, VSS);

   inout VDD, VSS;
   input   phi;              // Latch positive phase
   input   phib;             // latch negative phase
   input   scan_i0o1;        // Select scan_in/chip_out 0:scan_in, 1:scan_out
   input   load;             // Load chip_in latch
   input   scan_in;          // Serial scan in
   input   chip_out;         // Data from chip to scan out
   
   output  phi_out;          // verification signal
   output  phib_out;         // verification signal
   output  scan_i0o1_out;    // verification signal
   output  load_out;         // verification signal
   output  scan_out;         // Serial scan out  
   
   wire    latch_in;
   wire    latch_out;
   wire    scan_out_int;
   
   BUFFD12  buf_phi  (.Z(phi_out),       .I(phi), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_phib (.Z(phib_out),      .I(phib), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_mode (.Z(scan_i0o1_out), .I(scan_i0o1), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_load (.Z(load_out),      .I(load), .VDD(VDD), .VSS(VSS) );
   MUX2D1   mx       (.Z(latch_in),      .I0(scan_in),     .I1(chip_out),      .S(scan_i0o1), .VDD(VDD), .VSS(VSS) );
   LHQD1    flip     (.Q(latch_out),     .D(latch_in),     .E(phi), .VDD(VDD), .VSS(VSS) );
   LHQD1    flop     (.Q(scan_out_int),  .D(latch_out),    .E(phib), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_sout (.Z(scan_out),      .I(scan_out_int), .VDD(VDD), .VSS(VSS) );
   
endmodule // scan_out_bit

// Scan in with output latch
module si_bit( phi, phib, scan_i0o1, load, scan_in, phi_out, phib_out, scan_i0o1_out, load_out, scan_out, chip_in, VDD, VSS);
   
   inout VDD, VSS;
   input   phi;              // Latch positive phase
   input   phib;             // latch negative phase
   input   scan_i0o1;        // Select scan in/out
   input   load;             // Load chip_in latch
   input   scan_in;          // Serial scan in

   output  phi_out;          // verification signal
   output  phib_out;         // verification signal
   output  scan_i0o1_out;    // verification signal
   output  load_out;         // verification signal
   output  scan_out;         // Serial scan out  
   output  chip_in;          // Input to the chip
   
   wire    latch_in;
   wire    latch_out;
   wire    scan_out_int;
   wire    chip_in_int;
   
   BUFFD12  buf_phi     (.Z(phi_out),       .I(phi), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_phib    (.Z(phib_out),      .I(phib), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_mode    (.Z(scan_i0o1_out), .I(scan_i0o1), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_load    (.Z(load_out),      .I(load), .VDD(VDD), .VSS(VSS) );
   MUX2D1   mx          (.Z(latch_in),      .I0(scan_in),       .I1(chip_in_int), .S(scan_i0o1), .VDD(VDD), .VSS(VSS) );
   LHQD1    flip        (.Q(latch_out),     .D(latch_in),       .E(phi), .VDD(VDD), .VSS(VSS) );
   LHQD1    flop        (.Q(scan_out_int),  .D(latch_out),      .E(phib), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_sout    (.Z(scan_out),      .I(scan_out_int), .VDD(VDD), .VSS(VSS) );
   LHQD1    latch_chip  (.Q(chip_in_int),   .D(scan_out_int),   .E(load), .VDD(VDD), .VSS(VSS) );
   BUFFD12  buf_chip_in (.Z(chip_in),       .I(chip_in_int), .VDD(VDD), .VSS(VSS) );
   
endmodule
