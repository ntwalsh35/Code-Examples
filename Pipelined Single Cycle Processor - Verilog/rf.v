/*
   CS/ECE 552, Spring '23
   Homework #3, Problem #1
  
   This module creates a 16-bit register file.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
`default_nettype none
module rf (
           // Outputs
           read1OutData, read2OutData, err,
           // Inputs
           clk, rst, read1RegSel, read2RegSel, writeRegSel, writeInData, writeEn
           );

   // params for entire register
   parameter DATA_WIDTH = 16;
   parameter REG_WIDTH = 8;
   parameter SEL_BITS = 3;

   input wire       clk, rst;
   input wire [SEL_BITS - 1:0] read1RegSel;
   input wire [SEL_BITS - 1:0] read2RegSel;
   input wire [SEL_BITS - 1:0] writeRegSel;
   input wire [DATA_WIDTH - 1:0] writeInData;
   input wire        writeEn;

   output reg [DATA_WIDTH - 1:0] read1OutData;
   output reg [DATA_WIDTH - 1:0] read2OutData;
   wire [DATA_WIDTH - 1:0] registerOut0,
                           registerOut1,
                           registerOut2,
                           registerOut3,
                           registerOut4,
                           registerOut5,
                           registerOut6,
                           registerOut7;
   reg [DATA_WIDTH - 1:0] registersClk;
   output reg       err;

	
// read output muxes
   always @* case (writeRegSel)
         3'b000: begin  registersClk = 8'b0; registersClk[0] = writeEn; err = 1'b0; end
         3'b001: begin  registersClk = 8'b0; registersClk[1] = writeEn; err = 1'b0; end
         3'b010: begin  registersClk = 8'b0; registersClk[2] = writeEn; err = 1'b0; end
         3'b011: begin  registersClk = 8'b0; registersClk[3] = writeEn; err = 1'b0; end
         3'b100: begin  registersClk = 8'b0; registersClk[4] = writeEn; err = 1'b0; end
         3'b101: begin  registersClk = 8'b0; registersClk[5] = writeEn; err = 1'b0; end
         3'b110: begin  registersClk = 8'b0; registersClk[6] = writeEn; err = 1'b0; end
         3'b111: begin  registersClk = 8'b0; registersClk[7] = writeEn; err = 1'b0; end
         default: begin registersClk = 8'b0; registersClk = 8'b0; err = 1'b1; end
   endcase

   // parameterized flip flop registers
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register0(.d(writeInData), .q(registerOut0), .clk(clk), .en(registersClk[0]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register1(.d(writeInData), .q(registerOut1), .clk(clk), .en(registersClk[1]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register2(.d(writeInData), .q(registerOut2), .clk(clk), .en(registersClk[2]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register3(.d(writeInData), .q(registerOut3), .clk(clk), .en(registersClk[3]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register4(.d(writeInData), .q(registerOut4), .clk(clk), .en(registersClk[4]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register5(.d(writeInData), .q(registerOut5), .clk(clk), .en(registersClk[5]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register6(.d(writeInData), .q(registerOut6), .clk(clk), .en(registersClk[6]), .rst(rst));
   dff_param #(.DATA_WIDTH(DATA_WIDTH)) register7(.d(writeInData), .q(registerOut7), .clk(clk), .en(registersClk[7]), .rst(rst));

   // read output muxes
   always @* case (read1RegSel)
         3'b000: begin  read1OutData = registerOut0; err = 1'b0; end
         3'b001: begin  read1OutData = registerOut1; err = 1'b0; end
         3'b010: begin  read1OutData = registerOut2; err = 1'b0; end
         3'b011: begin  read1OutData = registerOut3; err = 1'b0; end
         3'b100: begin  read1OutData = registerOut4; err = 1'b0; end
         3'b101: begin  read1OutData = registerOut5; err = 1'b0; end
         3'b110: begin  read1OutData = registerOut6; err = 1'b0; end
         3'b111: begin  read1OutData = registerOut7; err = 1'b0; end
         default: begin read1OutData = 16'b1; err = 1'b1; end
   endcase

   // read output muxes
   always @* case (read2RegSel)
         3'b000: begin  read2OutData = registerOut0; err = 1'b0; end
         3'b001: begin  read2OutData = registerOut1; err = 1'b0; end
         3'b010: begin  read2OutData = registerOut2; err = 1'b0; end
         3'b011: begin  read2OutData = registerOut3; err = 1'b0; end
         3'b100: begin  read2OutData = registerOut4; err = 1'b0; end
         3'b101: begin  read2OutData = registerOut5; err = 1'b0; end
         3'b110: begin  read2OutData = registerOut6; err = 1'b0; end
         3'b111: begin  read2OutData = registerOut7; err = 1'b0; end
         default: begin read2OutData = 16'b1; err = 1'b1; end
   endcase

endmodule
`default_nettype wire
