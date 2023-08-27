/*
   CS/ECE 552, Spring '23
   Homework #3, Problem #2
  
   This module creates a wrapper around the 8x16b register file, to do
   do the bypassing logic for RF bypassing.
*/
`default_nettype none
module rf_bypass (
                  // Outputs
                  read1OutData, read2OutData, err,
                  // Inputs
                  clk, rst, read1RegSel, read2RegSel, writeRegSel, writeInData, writeEn
                  );

   input wire       clk, rst;
   input wire [2:0] read1RegSel;
   input wire [2:0] read2RegSel;
   input wire [2:0] writeRegSel;
   input wire [15:0] writeInData;
   input wire        writeEn;

   output wire [15:0] read1OutData;
   output wire [15:0] read2OutData;
   output wire        err;

   wire [15:0] read1OutData_bp;
   wire [15:0] read2OutData_bp;


   rf register0(// Outputs
           .read1OutData(read1OutData_bp), 
           .read2OutData(read2OutData_bp), 
           .err(err),
           // Inputs
           .clk(clk), 
           .rst(rst), 
           .read1RegSel(read1RegSel), 
           .read2RegSel(read2RegSel), 
           .writeRegSel(writeRegSel), 
           .writeInData(writeInData), 
           .writeEn(writeEn)
           );

   assign read1OutData = (read1RegSel == writeRegSel) & writeEn ? writeInData : read1OutData_bp;
   assign read2OutData = (read2RegSel == writeRegSel) & writeEn ? writeInData : read2OutData_bp;
   

endmodule
`default_nettype wire
