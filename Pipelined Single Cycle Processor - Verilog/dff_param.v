/*
   CS/ECE 552, Spring '23
   Homework #3, Problem #1
  
   This module creates a 16-bit register file.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
`default_nettype none
module dff_param #(parameter DATA_WIDTH = 16)
            (
           // Outputs
           q,
           // Inputs
           d, clk, rst, en
           );

   //parameter DATA_WIDTH;

   input wire       rst, en, clk;
   input wire [DATA_WIDTH - 1:0] d;
   output wire [DATA_WIDTH - 1:0] q;
   wire [DATA_WIDTH - 1:0] data;
   assign data = en ? d : q;

   dff register[DATA_WIDTH-1:0](.q(q), .d(data), .clk(clk), .rst(rst));


endmodule
`default_nettype wire
