// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_40, clk_20, clk_25, reset, locked, clk_100);
  output clk_40 /* synthesis syn_isclock = 1 */;
  output clk_20 /* synthesis syn_isclock = 1 */;
  output clk_25 /* synthesis syn_isclock = 1 */;
  input reset;
  output locked;
  input clk_100;
endmodule
