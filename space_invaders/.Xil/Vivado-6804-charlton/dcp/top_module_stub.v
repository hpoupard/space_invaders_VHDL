// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module top_module(clk, reset, h_sync, v_sync, red, green, blue);
  input clk;
  input reset;
  output h_sync;
  output v_sync;
  output [3:0]red;
  output [3:0]green;
  output [3:0]blue;
endmodule
