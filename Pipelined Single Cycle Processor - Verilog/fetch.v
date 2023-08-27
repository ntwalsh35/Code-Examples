/*
   CS/ECE 552 Spring '22


   Authors         : Neil Walsh
                     Will Martin
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
`default_nettype none
module fetch (
   // output 
   incPC, inst15_0, err,
   // input
   hazardBitWB, jumpBranchAdd, jumpAddr, clk, rst, halt, createDump
   );
   
   // output signals
   output wire [15:0] inst15_0, incPC;
   output wire err;

   // input signals
   input wire hazardBitWB, jumpBranchAdd;
   input wire [15:0] jumpAddr; 
   input wire clk, rst;
   
   wire [15:0] jumpAddr_regStored;
   // control signals
   input wire halt, createDump;
   wire done, stall, rd, wr, hit, mem_err, cOut_err, branchFF_out;
   assign rd = 1'b1;
   assign wr = 1'b0;

   assign err = cOut_err | mem_err;

   // definitions
   wire [15:0] PC, PC_in, writeBackPC, inst15_0_in;
   parameter DATA_WIDTH = 16;

   assign inst15_0 = rst | ~hit | branchFF_out ? 16'b0000100000000000 : inst15_0_in;

   // modules
   //dff branchJumpFF(.q(branchFF_out), .d(~done & jumpBranchAdd), .clk(clk), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) jmpBranchReg(.d(jumpAddr), .q(jumpAddr_regStored), .clk(clk), .en(jumpBranchAdd), .rst(rst));
   assign PC_in = (branchFF_out) ? jumpAddr_regStored : writeBackPC;
   dff_param #(.DATA_WIDTH(1)) branchJmpFF(.d(jumpBranchAdd), .q(branchFF_out), .clk(clk), .en(jumpBranchAdd), .rst(rst | hit));

   dff_param #(.DATA_WIDTH(DATA_WIDTH)) iPC(.d(PC_in), .q(PC), .clk(clk), .en((~halt & hit)), .rst(rst));
   //inst_mem    iInstMem(.inst(inst15_0_in), .addr(PC), .clk(clk), .rst(rst));
   mem_system    mem_system(.DataOut(inst15_0_in), .Done(done), .Stall(stall), .CacheHit(hit), .err(mem_err), .Addr(PC), .DataIn(16'b0), .Rd(rd), .Wr(wr), .createdump(createDump), .clk(clk), .rst(rst));
   cla_16b     iAdder(.out(incPC), .cOut(cOut_err), .in1(PC), .in2({14'b0, 2'b10}), .cIn(1'b0));
   mux_16b_4to1 PCmux(.out(writeBackPC), .in1(incPC), .in2(PC), .in3(jumpAddr), .in4(jumpAddr), .sel({jumpBranchAdd, hazardBitWB}));
   
endmodule
`default_nettype wire
