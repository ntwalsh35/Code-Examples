/*
   CS/ECE 552 Spring '22
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute (
   //output
   aluResult, inst7_0Ext, jumpAdd, aluControl, err, jumpBranchAdd,
   //input
   inst7_0SignExt, inst10_0SignExt, incPC, inst15_11, rReadData1, 
   rReadData2, inst4_0ZeroExt, inst4_0SignExt, inst7_0ZeroExt, jumpBranchExt, 
   jumpBranchPC, ALUsrc, ALUop, immExt5, immExt8, ALUneg1, ALUneg2
   );

   // output signals
   output wire [15:0] aluResult, inst7_0Ext, jumpAdd;
   output wire err;

   // input signals
   input wire [15:0] inst7_0SignExt, inst10_0SignExt, incPC, rReadData1, rReadData2, inst4_0ZeroExt, inst4_0SignExt, inst7_0ZeroExt;
   input wire [4:0] inst15_11;

   // control signals
   input wire jumpBranchExt, jumpBranchPC,  immExt5, immExt8, ALUneg1, ALUneg2;
   input wire [1:0] ALUsrc;
   input wire [3:0] ALUop;
   output wire [15:0] aluControl;
   output wire jumpBranchAdd;

   // internal signals
   wire [15:0] jumpImm, jumpPC, ALUsrcOut, inst4_0Ext;
   wire  cOut, cOutJB, zero, gzero;
   
   // definitions
   assign err = 1'b0; //cOutJB & jumpBranchAdd;

   // sign/zero extend immediate logic
   mux_16b_2to1   imm4_0ExtMux    (.out(inst4_0Ext), .in1(inst4_0ZeroExt), .in2(inst4_0SignExt), .sel(immExt5));
   mux_16b_2to1   imm7_0ExtMux    (.out(inst7_0Ext), .in1(inst7_0ZeroExt), .in2(inst7_0SignExt), .sel(immExt8));

   // ALU logic 
   mux_16b_4to1   ALUsrcMux       (.out(ALUsrcOut), .in1(rReadData2), .in2(inst4_0Ext), .in3(inst7_0Ext), .in4(16'b0), .sel(ALUsrc));
   alu_16b        ALU             (.out(aluResult), .cOut(cOut), .zero(zero), .gZero(gzero), .in1(rReadData1), .in2(ALUsrcOut), .op(ALUop), .neg1(ALUneg1), .neg2(ALUneg2));
   ALUcondControl ALUcondition    (.instruction(inst15_11), .cOut(cOut), .zero(zero), .gzero(gzero), .jumpBranchAdd(jumpBranchAdd), .aluControl(aluControl));

   // jump/branch PC logic
   mux_16b_2to1   branchImmMux    (.out(jumpImm), .in1(inst7_0SignExt), .in2(inst10_0SignExt), .sel(jumpBranchExt));
   cla_16b        jumpBranchAdder (.out(jumpAdd), .cOut(), .in1(jumpImm), .in2(jumpPC), .cIn(1'b0));
   mux_16b_2to1   branchRegMux    (.out(jumpPC), .in1(incPC), .in2(rReadData1), .sel(jumpBranchPC));
endmodule
`default_nettype wire
