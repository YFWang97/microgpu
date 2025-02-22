//Scan chain module
module scan_chain(din, addr, sram_sel, x, y, phi, phib, scan_i0o1, load, scan_in, scan_out, phi_out, phib_out, scan_i0o1_out, load_out, VDD, VSS );
output [7:0] din;
output [10:0] addr;
output sram_sel;
input [9:0] x;
input [9:0] y;
wire [39:0] phi_int, phib_int, scan_i0o1_int, load_int, scan_int;
input phi, phib, scan_i0o1, load, scan_in;
output phi_out, phib_out, scan_i0o1_out, load_out;
output scan_out;
inout VDD, VSS;

si_bit scan_cell_0_0(.VDD(VDD),.VSS(VSS),.phi(phi),.phib(phib),
.scan_i0o1(scan_i0o1),.load(load),.scan_in(scan_in),
.phi_out(phi_int[0]),.phib_out(phib_int[0]),.scan_i0o1_out(scan_i0o1_int[0]),
.load_out(load_int[0]),.scan_out(scan_int[0]),.chip_in(din[0]));


si_bit scan_cell_0_1(.VDD(VDD),.VSS(VSS),.phi(phi_int[0]),.phib(phib_int[0]),
.scan_i0o1(scan_i0o1_int[0]),.load(load_int[0]),.scan_in(scan_int[0]),
.phi_out(phi_int[1]),.phib_out(phib_int[1]),.scan_i0o1_out(scan_i0o1_int[1]),
.load_out(load_int[1]),.scan_out(scan_int[1]),.chip_in(din[1]));


si_bit scan_cell_0_2(.VDD(VDD),.VSS(VSS),.phi(phi_int[1]),.phib(phib_int[1]),
.scan_i0o1(scan_i0o1_int[1]),.load(load_int[1]),.scan_in(scan_int[1]),
.phi_out(phi_int[2]),.phib_out(phib_int[2]),.scan_i0o1_out(scan_i0o1_int[2]),
.load_out(load_int[2]),.scan_out(scan_int[2]),.chip_in(din[2]));


si_bit scan_cell_0_3(.VDD(VDD),.VSS(VSS),.phi(phi_int[2]),.phib(phib_int[2]),
.scan_i0o1(scan_i0o1_int[2]),.load(load_int[2]),.scan_in(scan_int[2]),
.phi_out(phi_int[3]),.phib_out(phib_int[3]),.scan_i0o1_out(scan_i0o1_int[3]),
.load_out(load_int[3]),.scan_out(scan_int[3]),.chip_in(din[3]));


si_bit scan_cell_0_4(.VDD(VDD),.VSS(VSS),.phi(phi_int[3]),.phib(phib_int[3]),
.scan_i0o1(scan_i0o1_int[3]),.load(load_int[3]),.scan_in(scan_int[3]),
.phi_out(phi_int[4]),.phib_out(phib_int[4]),.scan_i0o1_out(scan_i0o1_int[4]),
.load_out(load_int[4]),.scan_out(scan_int[4]),.chip_in(din[4]));


si_bit scan_cell_0_5(.VDD(VDD),.VSS(VSS),.phi(phi_int[4]),.phib(phib_int[4]),
.scan_i0o1(scan_i0o1_int[4]),.load(load_int[4]),.scan_in(scan_int[4]),
.phi_out(phi_int[5]),.phib_out(phib_int[5]),.scan_i0o1_out(scan_i0o1_int[5]),
.load_out(load_int[5]),.scan_out(scan_int[5]),.chip_in(din[5]));


si_bit scan_cell_0_6(.VDD(VDD),.VSS(VSS),.phi(phi_int[5]),.phib(phib_int[5]),
.scan_i0o1(scan_i0o1_int[5]),.load(load_int[5]),.scan_in(scan_int[5]),
.phi_out(phi_int[6]),.phib_out(phib_int[6]),.scan_i0o1_out(scan_i0o1_int[6]),
.load_out(load_int[6]),.scan_out(scan_int[6]),.chip_in(din[6]));


si_bit scan_cell_0_7(.VDD(VDD),.VSS(VSS),.phi(phi_int[6]),.phib(phib_int[6]),
.scan_i0o1(scan_i0o1_int[6]),.load(load_int[6]),.scan_in(scan_int[6]),
.phi_out(phi_int[7]),.phib_out(phib_int[7]),.scan_i0o1_out(scan_i0o1_int[7]),
.load_out(load_int[7]),.scan_out(scan_int[7]),.chip_in(din[7]));


si_bit scan_cell_1_0(.VDD(VDD),.VSS(VSS),.phi(phi_int[7]),.phib(phib_int[7]),
.scan_i0o1(scan_i0o1_int[7]),.load(load_int[7]),.scan_in(scan_int[7]),
.phi_out(phi_int[8]),.phib_out(phib_int[8]),.scan_i0o1_out(scan_i0o1_int[8]),
.load_out(load_int[8]),.scan_out(scan_int[8]),.chip_in(addr[0]));


si_bit scan_cell_1_1(.VDD(VDD),.VSS(VSS),.phi(phi_int[8]),.phib(phib_int[8]),
.scan_i0o1(scan_i0o1_int[8]),.load(load_int[8]),.scan_in(scan_int[8]),
.phi_out(phi_int[9]),.phib_out(phib_int[9]),.scan_i0o1_out(scan_i0o1_int[9]),
.load_out(load_int[9]),.scan_out(scan_int[9]),.chip_in(addr[1]));


si_bit scan_cell_1_2(.VDD(VDD),.VSS(VSS),.phi(phi_int[9]),.phib(phib_int[9]),
.scan_i0o1(scan_i0o1_int[9]),.load(load_int[9]),.scan_in(scan_int[9]),
.phi_out(phi_int[10]),.phib_out(phib_int[10]),.scan_i0o1_out(scan_i0o1_int[10]),
.load_out(load_int[10]),.scan_out(scan_int[10]),.chip_in(addr[2]));


si_bit scan_cell_1_3(.VDD(VDD),.VSS(VSS),.phi(phi_int[10]),.phib(phib_int[10]),
.scan_i0o1(scan_i0o1_int[10]),.load(load_int[10]),.scan_in(scan_int[10]),
.phi_out(phi_int[11]),.phib_out(phib_int[11]),.scan_i0o1_out(scan_i0o1_int[11]),
.load_out(load_int[11]),.scan_out(scan_int[11]),.chip_in(addr[3]));


si_bit scan_cell_1_4(.VDD(VDD),.VSS(VSS),.phi(phi_int[11]),.phib(phib_int[11]),
.scan_i0o1(scan_i0o1_int[11]),.load(load_int[11]),.scan_in(scan_int[11]),
.phi_out(phi_int[12]),.phib_out(phib_int[12]),.scan_i0o1_out(scan_i0o1_int[12]),
.load_out(load_int[12]),.scan_out(scan_int[12]),.chip_in(addr[4]));


si_bit scan_cell_1_5(.VDD(VDD),.VSS(VSS),.phi(phi_int[12]),.phib(phib_int[12]),
.scan_i0o1(scan_i0o1_int[12]),.load(load_int[12]),.scan_in(scan_int[12]),
.phi_out(phi_int[13]),.phib_out(phib_int[13]),.scan_i0o1_out(scan_i0o1_int[13]),
.load_out(load_int[13]),.scan_out(scan_int[13]),.chip_in(addr[5]));


si_bit scan_cell_1_6(.VDD(VDD),.VSS(VSS),.phi(phi_int[13]),.phib(phib_int[13]),
.scan_i0o1(scan_i0o1_int[13]),.load(load_int[13]),.scan_in(scan_int[13]),
.phi_out(phi_int[14]),.phib_out(phib_int[14]),.scan_i0o1_out(scan_i0o1_int[14]),
.load_out(load_int[14]),.scan_out(scan_int[14]),.chip_in(addr[6]));


si_bit scan_cell_1_7(.VDD(VDD),.VSS(VSS),.phi(phi_int[14]),.phib(phib_int[14]),
.scan_i0o1(scan_i0o1_int[14]),.load(load_int[14]),.scan_in(scan_int[14]),
.phi_out(phi_int[15]),.phib_out(phib_int[15]),.scan_i0o1_out(scan_i0o1_int[15]),
.load_out(load_int[15]),.scan_out(scan_int[15]),.chip_in(addr[7]));


si_bit scan_cell_1_8(.VDD(VDD),.VSS(VSS),.phi(phi_int[15]),.phib(phib_int[15]),
.scan_i0o1(scan_i0o1_int[15]),.load(load_int[15]),.scan_in(scan_int[15]),
.phi_out(phi_int[16]),.phib_out(phib_int[16]),.scan_i0o1_out(scan_i0o1_int[16]),
.load_out(load_int[16]),.scan_out(scan_int[16]),.chip_in(addr[8]));


si_bit scan_cell_1_9(.VDD(VDD),.VSS(VSS),.phi(phi_int[16]),.phib(phib_int[16]),
.scan_i0o1(scan_i0o1_int[16]),.load(load_int[16]),.scan_in(scan_int[16]),
.phi_out(phi_int[17]),.phib_out(phib_int[17]),.scan_i0o1_out(scan_i0o1_int[17]),
.load_out(load_int[17]),.scan_out(scan_int[17]),.chip_in(addr[9]));


si_bit scan_cell_1_10(.VDD(VDD),.VSS(VSS),.phi(phi_int[17]),.phib(phib_int[17]),
.scan_i0o1(scan_i0o1_int[17]),.load(load_int[17]),.scan_in(scan_int[17]),
.phi_out(phi_int[18]),.phib_out(phib_int[18]),.scan_i0o1_out(scan_i0o1_int[18]),
.load_out(load_int[18]),.scan_out(scan_int[18]),.chip_in(addr[10]));


si_bit scan_cell_2_0(.VDD(VDD),.VSS(VSS),.phi(phi_int[18]),.phib(phib_int[18]),
.scan_i0o1(scan_i0o1_int[18]),.load(load_int[18]),.scan_in(scan_int[18]),
.phi_out(phi_int[19]),.phib_out(phib_int[19]),.scan_i0o1_out(scan_i0o1_int[19]),
.load_out(load_int[19]),.scan_out(scan_int[19]),.chip_in(sram_sel));


so_bit scan_cell_3_0(.VDD(VDD),.VSS(VSS),.phi(phi_int[19]),.phib(phib_int[19]),
.scan_i0o1(scan_i0o1_int[19]),.load(load_int[19]),.scan_in(scan_int[19]),
.chip_out(x[0]),
.phi_out(phi_int[20]),.phib_out(phib_int[20]),.scan_i0o1_out(scan_i0o1_int[20]),
.load_out(load_int[20]),.scan_out(scan_int[20]));


so_bit scan_cell_3_1(.VDD(VDD),.VSS(VSS),.phi(phi_int[20]),.phib(phib_int[20]),
.scan_i0o1(scan_i0o1_int[20]),.load(load_int[20]),.scan_in(scan_int[20]),
.chip_out(x[1]),
.phi_out(phi_int[21]),.phib_out(phib_int[21]),.scan_i0o1_out(scan_i0o1_int[21]),
.load_out(load_int[21]),.scan_out(scan_int[21]));


so_bit scan_cell_3_2(.VDD(VDD),.VSS(VSS),.phi(phi_int[21]),.phib(phib_int[21]),
.scan_i0o1(scan_i0o1_int[21]),.load(load_int[21]),.scan_in(scan_int[21]),
.chip_out(x[2]),
.phi_out(phi_int[22]),.phib_out(phib_int[22]),.scan_i0o1_out(scan_i0o1_int[22]),
.load_out(load_int[22]),.scan_out(scan_int[22]));


so_bit scan_cell_3_3(.VDD(VDD),.VSS(VSS),.phi(phi_int[22]),.phib(phib_int[22]),
.scan_i0o1(scan_i0o1_int[22]),.load(load_int[22]),.scan_in(scan_int[22]),
.chip_out(x[3]),
.phi_out(phi_int[23]),.phib_out(phib_int[23]),.scan_i0o1_out(scan_i0o1_int[23]),
.load_out(load_int[23]),.scan_out(scan_int[23]));


so_bit scan_cell_3_4(.VDD(VDD),.VSS(VSS),.phi(phi_int[23]),.phib(phib_int[23]),
.scan_i0o1(scan_i0o1_int[23]),.load(load_int[23]),.scan_in(scan_int[23]),
.chip_out(x[4]),
.phi_out(phi_int[24]),.phib_out(phib_int[24]),.scan_i0o1_out(scan_i0o1_int[24]),
.load_out(load_int[24]),.scan_out(scan_int[24]));


so_bit scan_cell_3_5(.VDD(VDD),.VSS(VSS),.phi(phi_int[24]),.phib(phib_int[24]),
.scan_i0o1(scan_i0o1_int[24]),.load(load_int[24]),.scan_in(scan_int[24]),
.chip_out(x[5]),
.phi_out(phi_int[25]),.phib_out(phib_int[25]),.scan_i0o1_out(scan_i0o1_int[25]),
.load_out(load_int[25]),.scan_out(scan_int[25]));


so_bit scan_cell_3_6(.VDD(VDD),.VSS(VSS),.phi(phi_int[25]),.phib(phib_int[25]),
.scan_i0o1(scan_i0o1_int[25]),.load(load_int[25]),.scan_in(scan_int[25]),
.chip_out(x[6]),
.phi_out(phi_int[26]),.phib_out(phib_int[26]),.scan_i0o1_out(scan_i0o1_int[26]),
.load_out(load_int[26]),.scan_out(scan_int[26]));


so_bit scan_cell_3_7(.VDD(VDD),.VSS(VSS),.phi(phi_int[26]),.phib(phib_int[26]),
.scan_i0o1(scan_i0o1_int[26]),.load(load_int[26]),.scan_in(scan_int[26]),
.chip_out(x[7]),
.phi_out(phi_int[27]),.phib_out(phib_int[27]),.scan_i0o1_out(scan_i0o1_int[27]),
.load_out(load_int[27]),.scan_out(scan_int[27]));


so_bit scan_cell_3_8(.VDD(VDD),.VSS(VSS),.phi(phi_int[27]),.phib(phib_int[27]),
.scan_i0o1(scan_i0o1_int[27]),.load(load_int[27]),.scan_in(scan_int[27]),
.chip_out(x[8]),
.phi_out(phi_int[28]),.phib_out(phib_int[28]),.scan_i0o1_out(scan_i0o1_int[28]),
.load_out(load_int[28]),.scan_out(scan_int[28]));


so_bit scan_cell_3_9(.VDD(VDD),.VSS(VSS),.phi(phi_int[28]),.phib(phib_int[28]),
.scan_i0o1(scan_i0o1_int[28]),.load(load_int[28]),.scan_in(scan_int[28]),
.chip_out(x[9]),
.phi_out(phi_int[29]),.phib_out(phib_int[29]),.scan_i0o1_out(scan_i0o1_int[29]),
.load_out(load_int[29]),.scan_out(scan_int[29]));


so_bit scan_cell_4_0(.VDD(VDD),.VSS(VSS),.phi(phi_int[29]),.phib(phib_int[29]),
.scan_i0o1(scan_i0o1_int[29]),.load(load_int[29]),.scan_in(scan_int[29]),
.chip_out(y[0]),
.phi_out(phi_int[30]),.phib_out(phib_int[30]),.scan_i0o1_out(scan_i0o1_int[30]),
.load_out(load_int[30]),.scan_out(scan_int[30]));


so_bit scan_cell_4_1(.VDD(VDD),.VSS(VSS),.phi(phi_int[30]),.phib(phib_int[30]),
.scan_i0o1(scan_i0o1_int[30]),.load(load_int[30]),.scan_in(scan_int[30]),
.chip_out(y[1]),
.phi_out(phi_int[31]),.phib_out(phib_int[31]),.scan_i0o1_out(scan_i0o1_int[31]),
.load_out(load_int[31]),.scan_out(scan_int[31]));


so_bit scan_cell_4_2(.VDD(VDD),.VSS(VSS),.phi(phi_int[31]),.phib(phib_int[31]),
.scan_i0o1(scan_i0o1_int[31]),.load(load_int[31]),.scan_in(scan_int[31]),
.chip_out(y[2]),
.phi_out(phi_int[32]),.phib_out(phib_int[32]),.scan_i0o1_out(scan_i0o1_int[32]),
.load_out(load_int[32]),.scan_out(scan_int[32]));


so_bit scan_cell_4_3(.VDD(VDD),.VSS(VSS),.phi(phi_int[32]),.phib(phib_int[32]),
.scan_i0o1(scan_i0o1_int[32]),.load(load_int[32]),.scan_in(scan_int[32]),
.chip_out(y[3]),
.phi_out(phi_int[33]),.phib_out(phib_int[33]),.scan_i0o1_out(scan_i0o1_int[33]),
.load_out(load_int[33]),.scan_out(scan_int[33]));


so_bit scan_cell_4_4(.VDD(VDD),.VSS(VSS),.phi(phi_int[33]),.phib(phib_int[33]),
.scan_i0o1(scan_i0o1_int[33]),.load(load_int[33]),.scan_in(scan_int[33]),
.chip_out(y[4]),
.phi_out(phi_int[34]),.phib_out(phib_int[34]),.scan_i0o1_out(scan_i0o1_int[34]),
.load_out(load_int[34]),.scan_out(scan_int[34]));


so_bit scan_cell_4_5(.VDD(VDD),.VSS(VSS),.phi(phi_int[34]),.phib(phib_int[34]),
.scan_i0o1(scan_i0o1_int[34]),.load(load_int[34]),.scan_in(scan_int[34]),
.chip_out(y[5]),
.phi_out(phi_int[35]),.phib_out(phib_int[35]),.scan_i0o1_out(scan_i0o1_int[35]),
.load_out(load_int[35]),.scan_out(scan_int[35]));


so_bit scan_cell_4_6(.VDD(VDD),.VSS(VSS),.phi(phi_int[35]),.phib(phib_int[35]),
.scan_i0o1(scan_i0o1_int[35]),.load(load_int[35]),.scan_in(scan_int[35]),
.chip_out(y[6]),
.phi_out(phi_int[36]),.phib_out(phib_int[36]),.scan_i0o1_out(scan_i0o1_int[36]),
.load_out(load_int[36]),.scan_out(scan_int[36]));


so_bit scan_cell_4_7(.VDD(VDD),.VSS(VSS),.phi(phi_int[36]),.phib(phib_int[36]),
.scan_i0o1(scan_i0o1_int[36]),.load(load_int[36]),.scan_in(scan_int[36]),
.chip_out(y[7]),
.phi_out(phi_int[37]),.phib_out(phib_int[37]),.scan_i0o1_out(scan_i0o1_int[37]),
.load_out(load_int[37]),.scan_out(scan_int[37]));


so_bit scan_cell_4_8(.VDD(VDD),.VSS(VSS),.phi(phi_int[37]),.phib(phib_int[37]),
.scan_i0o1(scan_i0o1_int[37]),.load(load_int[37]),.scan_in(scan_int[37]),
.chip_out(y[8]),
.phi_out(phi_int[38]),.phib_out(phib_int[38]),.scan_i0o1_out(scan_i0o1_int[38]),
.load_out(load_int[38]),.scan_out(scan_int[38]));


so_bit scan_cell_4_9(.VDD(VDD),.VSS(VSS),.phi(phi_int[38]),.phib(phib_int[38]),
.scan_i0o1(scan_i0o1_int[38]),.load(load_int[38]),.scan_in(scan_int[38]),
.chip_out(y[9]),
.phi_out(phi_out),.phib_out(phib_out),.scan_i0o1_out(scan_i0o1_out),.load_out(load_out),.scan_out(scan_out));

endmodule
