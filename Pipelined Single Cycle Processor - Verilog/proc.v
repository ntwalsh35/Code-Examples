/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
`default_nettype none
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output wire err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines

   // register widths for each register
   parameter FD_WIDTH = 32;   // [31:16] incPC
                              // [15:0] instruction

   parameter DE_WIDTH = 173;  // [189:173] inst15_0
                              // [155:136] Control signals
                                 // [155] immExt5
                                 // [154] immExt8
                                 // [153] jumpBranchExt
                                 // [152] jumpBranchPC
                                 // [151] ALUneg1
                                 // [150] ALUneg2
                                 // [146:149] ALUop
                                 // [144:145] ALUsrc
                                 // [143] createDump
                                 // [142] memRead
                                 // [141] memWrite
                                 // [140] jumpBranchBool
                                 // [139] regWriteEn
                                 // [136:138] writeBackOp
                              // [135:133] rWriteReg
                              // [132:128] inst15_11
                              // [127:112] rReadData1
                              // [111:96] rReadData2
                              // [95:80] inst4_0ZeroExt
                              // [79:64] inst4_0SignExt
                              // [63:48] inst7_0ZeroExt
                              // [47:32] inst7_0SignExt
                              // [31:16] inst10_0SignExt
                              // [15:0] incPC

   parameter EM_WIDTH = 109;   // [90:75] aluControl
                              // [74:72] rWriteReg
                              // [71:64] Control signals
                              //    [71] createDump
                              //    [70] memRead
                              //    [69] memWrite
                              //    [68] jumpBranchBool
                              //    [67] regWriteEn
                              //    [66:64] writeBackOp
                              // [63:48] aluResult
                              // [47:32] inst7_0Ext
                              // [31:16] writeData
                              // [15:0] incPC

   parameter MW_WIDTH = 105;   // [86:84] rWriteReg
                              // [83:80] Control signals
                                 // [83] regWriteEn
                                 // [82:80] writeBackOp
                              // [79:64] inst7_0Ext
                              // [63:48] aluControl
                              // [47:32] incPC
                              // [31:16] aluResult
                              // [15:0] dReadData

   
   // defintions
   // error
   wire fErr, dErr, eErr, mErr, wErr, W_mErr;

   // fetch signals
   wire [15:0] F_inst15_0, F_incPC;
   wire F_halt;

   // decode signals
   wire D_halt;
   wire D_immExt5;
   wire D_immExt8;
   wire D_jumpBranchExt;
   wire D_jumpBranchPC;
   wire D_ALUneg1;
   wire D_ALUneg2;
   wire [3:0] D_ALUop;
   wire [1:0] D_ALUsrc;
   wire D_createDump;
   wire D_memRead;
   wire D_memWrite;
   wire D_jumpBranchBool;
   wire D_regWriteEn;
   wire [2:0] D_writeBackOp;
   wire [2:0] D_rWriteReg;
   wire [4:0] D_inst15_11;
   wire [15:0] D_rReadData1;
   wire [15:0] D_rReadData2;
   wire [15:0] D_inst4_0ZeroExt;
   wire [15:0] D_inst4_0SignExt;
   wire [15:0] D_inst7_0ZeroExt;
   wire [15:0] D_inst7_0SignExt;
   wire [15:0] D_inst10_0SignExt;
   wire [15:0] D_incPC;
   wire [15:0] D_inst15_0;

   // execute signals
   wire E_halt;
   wire E_immExt5;
   wire E_immExt8;
   wire E_jumpBranchExt;
   wire E_jumpBranchPC;
   wire E_ALUneg1;
   wire E_ALUneg2;
   wire [3:0] E_ALUop;
   wire [1:0] E_ALUsrc;
   wire E_createDump;
   wire E_memRead;
   wire E_memWrite;
   wire E_jumpBranchBool;
   wire E_regWriteEn;
   wire [2:0] E_writeBackOp;
   wire [2:0] E_rWriteReg;
   wire [4:0] E_inst15_11;
   wire [15:0] E_aluControl;
   wire [15:0] E_rReadData1;
   wire [15:0] E_rReadData2;
   wire [15:0] E_inst4_0ZeroExt;
   wire [15:0] E_inst4_0SignExt;
   wire [15:0] E_inst7_0ZeroExt;
   wire [15:0] E_inst7_0SignExt;
   wire [15:0] E_inst10_0SignExt;
   wire [15:0] E_inst7_0Ext;
   wire [15:0] E_aluResult;
   wire [15:0] E_incPC;
   wire [15:0] E_inst15_0;
 
   // mem signals
   wire M_jumpBranchAdd;
   wire M_halt;
   wire M_createDump;
   wire M_memRead;
   wire M_memWrite;
   wire M_jumpBranchBool;
   wire M_regWriteEn;
   wire M_halt_anded;
   wire M_regWriteEn_anded;
   wire M_dCache_hit;
   wire [2:0] M_writeBackOp;
   wire [2:0] M_rWriteReg;
   wire [15:0] M_aluControl;
   wire [15:0] M_aluResult;
   wire [15:0] M_inst7_0Ext;
   wire [15:0] M_writeData;
   wire [15:0] M_dReadData;
   wire [15:0]  M_incPC;
   wire [15:0] M_inst15_0;

   // WB signals
   wire W_halt;
   wire [2:0] W_rWriteReg;
   wire W_regWriteEn;
   wire [2:0] W_writeBackOp;
   wire [15:0] W_inst7_0Ext;
   wire [15:0] W_aluControl;
   wire [15:0] W_incPC;
   wire [15:0] W_aluResult;
   wire [15:0]  W_dReadData;
   wire [15:0] writeBackData;
   wire [15:0] W_inst15_0;

   // forwarding and Branch prediction signals
   wire [2:0] rReadData1MuxSel, rReadData2MuxSel;
   wire [15:0] E_rReadData1_postMux, E_rReadData2_postMux;

   // Pipeline/hazard control bits
   wire PCMuxBit0Sig, E_jumpBranchAdd, writeFD;
   wire controlMuxSig;
   wire [15:0] jumpAddr;



   assign F_halt = D_halt | ~(M_dCache_hit | (~M_memRead & ~M_memWrite));
   // modules
   fetch fetch0 (
      .incPC(F_incPC), .inst15_0(F_inst15_0), .err(fErr), .hazardBitWB(PCMuxBit0Sig), .jumpBranchAdd(E_jumpBranchAdd), .jumpAddr(jumpAddr), .clk(clk), .rst(rst), .halt(F_halt), .createDump(D_createDump)
      );
   dff_param #(.DATA_WIDTH(FD_WIDTH)) FDreg  (.q({D_incPC, D_inst15_0}), .d({F_incPC, F_inst15_0}), .clk(clk), .rst(1'b0), .en(writeFD & ( M_dCache_hit | (~M_memRead & ~M_memWrite)))); // rst was hardcoded to 0

      // hazard detection control
   hazardDetection hazardDetect_ (// output
      .writeFD(writeFD),
      .PCMuxBit0Sig(PCMuxBit0Sig),
      .controlMuxSig(controlMuxSig),
    // input
      .inst15_0(D_inst15_0),
      .E_rWriteReg(E_rWriteReg),
      .M_rWriteReg(M_rWriteReg),
      .E_regWriteEn(E_regWriteEn),
      .E_jumpBranchBool(E_jumpBranchBool),
      .M_regWriteEn(M_regWriteEn),
      .M_jumpBranchBool(M_jumpBranchBool),
      .M_jumpBranchAdd(M_jumpBranchAdd),
      .E_jumpBranchAdd(E_jumpBranchAdd),
      .E_memRead(E_memRead), 
      .E_readReg2(E_inst15_0[7:5]), 
      .D_readReg1(D_inst15_0[10:8]),
      .D_readReg2(D_inst15_0[7:5])
      );

   decode decode0 (
      .inst7_0SignExt(D_inst7_0SignExt), 
      .inst10_0SignExt(D_inst10_0SignExt), 
      .inst15_11(D_inst15_11), 
      .rReadData1(D_rReadData1), 
      .rReadData2(D_rReadData2), 
      .inst4_0ZeroExt(D_inst4_0ZeroExt), 
      .inst4_0SignExt(D_inst4_0SignExt), 
      .inst7_0ZeroExt(D_inst7_0ZeroExt), 
      .createDump(D_createDump), 
      .immExt5(D_immExt5), 
      .immExt8(D_immExt8), 
      .jumpBranchExt(D_jumpBranchExt), 
      .jumpBranchPC(D_jumpBranchPC), 
      .halt(D_halt),
      .rWriteReg(D_rWriteReg),
      .jumpBranchBool(D_jumpBranchBool),
      .regWriteEn(D_regWriteEn), 
      .memRead(D_memRead), 
      .memWrite(D_memWrite), 
      .ALUsrc(D_ALUsrc), 
      .writeBackOp(D_writeBackOp), 
      .ALUop(D_ALUop), 
      .err(dErr),
      .ALUneg1(D_ALUneg1), 
      .ALUneg2(D_ALUneg2),  
      .controlMuxSig(controlMuxSig),
      .writeBackData(writeBackData),
      .incPC(D_incPC), 
      .inst15_0_in(D_inst15_0), 
      .clk(clk), 
      .rst(rst), 
      .writeRegWB(W_rWriteReg),
      .regWriteEnWB(W_regWriteEn)
      );
   dff_param #(.DATA_WIDTH(DE_WIDTH)) DEreg  (
   .q({E_halt, E_immExt5, E_immExt8, E_jumpBranchExt, E_jumpBranchPC, E_ALUneg1,
       E_ALUneg2, E_ALUop, E_ALUsrc, E_createDump, E_memRead, E_memWrite, 
       E_jumpBranchBool, E_regWriteEn, E_writeBackOp, E_rWriteReg, E_inst15_11, 
       E_rReadData1, E_rReadData2, E_inst4_0ZeroExt, E_inst4_0SignExt, E_inst7_0ZeroExt,
       E_inst7_0SignExt, E_inst10_0SignExt, E_incPC, E_inst15_0}), 
   .d({D_halt, D_immExt5, D_immExt8, D_jumpBranchExt, D_jumpBranchPC, D_ALUneg1,
    D_ALUneg2, D_ALUop, D_ALUsrc, D_createDump, D_memRead, D_memWrite,
     D_jumpBranchBool, D_regWriteEn, D_writeBackOp, D_rWriteReg,
      D_inst15_11, D_rReadData1, D_rReadData2, D_inst4_0ZeroExt,
       D_inst4_0SignExt, D_inst7_0ZeroExt, D_inst7_0SignExt, 
       D_inst10_0SignExt, D_incPC, D_inst15_0}), 
   .clk(clk), 
   .rst(rst), 
   .en(M_dCache_hit | (~M_memRead & ~M_memWrite)));


   execute execute0 (
      .aluResult(E_aluResult), 
      .inst7_0Ext(E_inst7_0Ext), 
      .jumpAdd(jumpAddr), 
      .jumpBranchAdd(E_jumpBranchAdd),
      .aluControl(E_aluControl), 
      .err(eErr), 
      .inst7_0SignExt(E_inst7_0SignExt), 
      .inst10_0SignExt(E_inst10_0SignExt), 
      .incPC(E_incPC), 
      .inst15_11(E_inst15_11), 
      .rReadData1(E_rReadData1_postMux), 
      .rReadData2(E_rReadData2_postMux), 
      .inst4_0ZeroExt(E_inst4_0ZeroExt), 
      .inst4_0SignExt(E_inst4_0SignExt), 
      .inst7_0ZeroExt(E_inst7_0ZeroExt), 
      .jumpBranchExt(E_jumpBranchExt), 
      .jumpBranchPC(E_jumpBranchPC), 
      .ALUsrc(E_ALUsrc), 
      .ALUop(E_ALUop), 
      .immExt5(E_immExt5), 
      .immExt8(E_immExt8), 
      .ALUneg1(E_ALUneg1), 
      .ALUneg2(E_ALUneg2)
      );

   // muxes for forwarding
   mux_16b_8to1 rData1mux(
      .out(E_rReadData1_postMux), 
      .in1(E_rReadData1),
      .in2(M_inst7_0Ext),
      .in3(writeBackData),
      .in4(M_aluResult),
      .in5(M_aluControl),
      .in6(16'b0),
      .in7(16'b0),
      .in8(16'b0),
      .sel(rReadData1MuxSel));
   mux_16b_8to1 rData2mux(
      .out(E_rReadData2_postMux), 
      .in1(E_rReadData2),
      .in2(M_inst7_0Ext),
      .in3(writeBackData),
      .in4(M_aluResult),
      .in5(M_aluControl),
      .in6(16'b0),
      .in7(16'b0),
      .in8(16'b0),
      .sel(rReadData2MuxSel));

   // forwarding logic unit
   forwardingUnit fwdUnit(
    .rReadData1MuxSel(rReadData1MuxSel), 
    .rReadData2MuxSel(rReadData2MuxSel), 
    .rReadReg1(E_inst15_0[10:8]), 
    .rReadReg2(E_inst15_0[7:5]), 
    .EM_rWriteReg(M_rWriteReg), 
    .MW_rWriteReg(W_rWriteReg), 
    .EM_regWriteEn(M_regWriteEn), 
    .MW_regWriteEn(W_regWriteEn),
    .M_writeBackOp(M_writeBackOp));


   dff_param #(.DATA_WIDTH(EM_WIDTH)) EMreg  (.q({M_jumpBranchAdd, M_halt, M_aluControl, M_rWriteReg, M_createDump, M_memRead, M_memWrite, M_jumpBranchBool, M_regWriteEn, M_writeBackOp, M_aluResult, M_inst7_0Ext, M_writeData, M_incPC, M_inst15_0}), .d({E_jumpBranchAdd, E_halt, E_aluControl, E_rWriteReg, E_createDump, E_memRead, E_memWrite, E_jumpBranchBool, E_regWriteEn, E_writeBackOp, E_aluResult, E_inst7_0Ext, E_rReadData2_postMux, E_incPC, E_inst15_0}), .clk(clk), .rst(rst), .en(M_dCache_hit | (~M_memRead & ~M_memWrite)));

   memory memory0 (
      .dReadData(M_dReadData), 
      .err(mErr), 
      .aluResult(M_aluResult), 
      .writeData(M_writeData), 
      .createDump(M_createDump), 
      .memRead(M_memRead), 
      .memWrite(M_memWrite), 
      .clk(clk), 
      .rst(rst),
      .hit(M_dCache_hit)
      );

   //assign M_jumpBranchAdd_anded = M_jumpBranchAdd & ~M_dCache_hit;
   assign M_halt_anded = M_halt & (M_dCache_hit | (~M_memRead & ~M_memWrite));
   assign M_regWriteEn_anded = M_regWriteEn & (M_dCache_hit | (~M_memRead & ~M_memWrite));

   dff_param #(.DATA_WIDTH(MW_WIDTH)) MWreg  (.q({W_mErr, W_halt, W_rWriteReg, W_regWriteEn, W_writeBackOp, W_inst7_0Ext, W_aluControl, W_incPC, W_aluResult, W_dReadData, W_inst15_0}), 
   .d({mErr, M_halt_anded, M_rWriteReg, M_regWriteEn_anded, M_writeBackOp, M_inst7_0Ext, M_aluControl, M_incPC, M_aluResult, M_dReadData, M_inst15_0}), .clk(clk), .rst(rst), .en(1'b1));

   wb wb0 (
      .writeBackData(writeBackData), 
      .err(wErr),
      .incPC(W_incPC), 
      .dReadData(W_dReadData), 
      .aluResult(W_aluResult), 
      .aluControl(W_aluControl), 
      .inst7_0Ext(W_inst7_0Ext), 
      .writeBackOp(W_writeBackOp)
      );

   // error
   assign err = fErr | dErr | eErr | W_mErr | wErr;
   
endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:
