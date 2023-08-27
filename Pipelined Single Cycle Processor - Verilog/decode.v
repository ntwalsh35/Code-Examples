/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (
   // output
   inst7_0SignExt, inst10_0SignExt, inst15_11, rReadData1, rReadData2, inst4_0ZeroExt, inst4_0SignExt, inst7_0ZeroExt, createDump, immExt5, immExt8, jumpBranchExt, jumpBranchPC, halt, memRead, memWrite, ALUsrc, writeBackOp, ALUop, err, ALUneg1, ALUneg2, rWriteReg, jumpBranchBool, regWriteEn,
   // input
   controlMuxSig, writeBackData, regWriteEnWB, writeRegWB, incPC, inst15_0_in, clk, rst
   );

   // output signals
   output wire [15:0] inst7_0SignExt, inst7_0ZeroExt, inst10_0SignExt, inst4_0SignExt, inst4_0ZeroExt, rReadData1, rReadData2;
   output wire [4:0] inst15_11;
   output wire err;

   // input signals
   input wire [15:0] incPC, inst15_0_in, writeBackData;
   input wire clk, rst, regWriteEnWB, controlMuxSig;
   input wire [2:0] writeRegWB;

   // control signals
   output wire createDump, immExt5, immExt8, jumpBranchExt, jumpBranchPC, halt, memRead, memWrite, ALUneg1, ALUneg2, jumpBranchBool, regWriteEn; 
   output wire [1:0] ALUsrc;
   output wire [2:0] writeBackOp, rWriteReg; 
   output wire [3:0] ALUop;

   // modules
   // fix reset/halt issue
   wire [15:0] inst15_0;
   //assign inst15_0 = rst ? 16'b0000100000000000:inst15_0_in;
   assign inst15_0 = inst15_0_in;
   // controller
   wire [1:0] regDst;
   control control_(.controlMuxSig(controlMuxSig), .instruction(inst15_0), .immExt5(immExt5), .immExt8(immExt8), .halt(halt), .jumpBranchExt(jumpBranchExt), .regWrite(regWriteEn), .memRead(memRead), .memWrite(memWrite), .jumpBranchPC(jumpBranchPC), .createDump(createDump), .regDst(regDst), .ALUsrc(ALUsrc), .writeBackOp(writeBackOp), .ALUop(ALUop), .ALUneg1(ALUneg1), .ALUneg2(ALUneg2), .rst(rst), .jumpBranchBool(jumpBranchBool));

   // write reg mux
   mux_3b_4to1 mux_3b_4to1_(.out(rWriteReg), .in1(inst15_0[10:8]), .in2(inst15_0[7:5]), .in3(inst15_0[4:2]), .in4(3'b111), .sel(regDst));

   // register file
   rf_bypass rf_ (.read1OutData(rReadData1), .read2OutData(rReadData2), .err(err), .clk(clk), .rst(rst), .read1RegSel(inst15_0[10:8]), .read2RegSel(inst15_0[7:5]), .writeRegSel(writeRegWB), .writeInData(writeBackData), .writeEn(regWriteEnWB));

   // sign/zero extended outputs
   sign_ext_5b sign_ext_5b_(.out(inst4_0SignExt), .in(inst15_0[4:0]));
   zero_ext_5b zero_ext_5b_(.out(inst4_0ZeroExt), .in(inst15_0[4:0]));

   sign_ext_8b sign_ext_8b_(.out(inst7_0SignExt), .in(inst15_0[7:0]));
   zero_ext_8b zero_ext_8b_(.out(inst7_0ZeroExt), .in(inst15_0[7:0]));

   sign_ext_11b sign_ext_11b_(.out(inst10_0SignExt), .in(inst15_0[10:0]));

   assign inst15_11 = controlMuxSig ? 5'b00001 : inst15_0[15:11];

endmodule
`default_nettype wire
