/*
   CS/ECE 552 Spring '22
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
`default_nettype none
module wb (
   // output
   writeBackData, err,
   // input
   incPC, dReadData, aluResult, aluControl, inst7_0Ext, writeBackOp
   );

   // output signals
   output wire [15:0] writeBackData;
   output wire err;

   // input signals
   input wire [15:0] dReadData, aluResult, inst7_0Ext, incPC;
   input wire [15:0] aluControl;

   // control signals
   input wire [2:0] writeBackOp;

   // definitons

   // modules

   assign err = (writeBackOp == 3'b101) | (writeBackOp == 3'b110) | (writeBackOp == 3'b111);

   // 1 mux needed
   mux_16b_8to1 writeBackMux (.out(writeBackData), .in1(incPC), .in2(dReadData), .in3(aluResult), .in4(inst7_0Ext), .in5(aluControl), .in6(16'b0), .in7(16'b0), .in8(16'b0), .sel(writeBackOp));
   
endmodule
`default_nettype wire
