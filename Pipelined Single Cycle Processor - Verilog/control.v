/*
   CS/ECE 552 Spring '22
   Authors         : Neil Walsh
                     Will Martin

   Filename        : control.v
   Description     : This is the module that parses the instruction and sets the control signals.
*/
`default_nettype none
module control ( controlMuxSig, instruction, immExt5, immExt8, halt, jumpBranchExt, regWrite, memRead, memWrite,
                  jumpBranchPC, createDump, regDst, ALUsrc, writeBackOp, ALUop, ALUneg1, ALUneg2, rst, jumpBranchBool);

    input wire [15:0]instruction;
    input wire rst, controlMuxSig;
    // input wire ALUgzero, ALUzero;
    output reg immExt5, immExt8, halt, jumpBranchExt, jumpBranchPC, memRead, memWrite, regWrite, createDump, ALUneg1, ALUneg2, jumpBranchBool; // jumpBranchAdd
    output reg [1:0] regDst, ALUsrc;
    output reg [2:0] writeBackOp;
    output reg [3:0] ALUop;

    always @* case (rst)
      1'b0: begin end
      1'b1: begin 
         halt =         1'b0;
      end
      default: begin end
    endcase
    
    // TODO: implement jumpBranchBool
    always @* case (controlMuxSig)
      1'b1: begin 
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool =1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp = 3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
      end
     1'b0: begin
     case (instruction[15:11])
      5'b00000: begin // halt
         createDump =   1'b1;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool =1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b1;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp = 3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000; 
         end 
      5'b00001: begin // nop
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp = 3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
         end 
      5'b01000: begin // addi
         createDump =   1'b0;
         immExt5 =      1'b1;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0100;
         end 
      5'b01001: begin // subi
         createDump =   1'b0;
         immExt5 =      1'b1;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU 
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0100;
         end // subi
      5'b01010: begin // xori
         createDump =   1'b0;
         immExt5 =      1'b0; // zero extend
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0110;
         end // xori
      5'b01011: begin // andni
         createDump =   1'b0;
         immExt5 =      1'b0; // zero extend
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b1;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0101;
         end // andni
      5'b10100: begin // roli
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0010;
         end // roli
      5'b10101: begin // slli
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0000;
         end // slli
      5'b10110: begin // rori
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0011;
         end // rori
      5'b10111: begin // srli
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0001;
         end // srli
      5'b10000: begin // st
         createDump =   1'b0;
         immExt5 =      1'b1; // sign extend
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b1;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b000; // nothing is written back
         regDst =       2'b00;
         ALUop =        4'b0100;
         end // st
      5'b10001: begin // ld
         createDump =   1'b0;
         immExt5 =      1'b1; // sign extend
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b1;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b001; // writeback read data from memory 
         regDst =       2'b01; // destination Rd, bits[7:5]
         ALUop =        4'b0100;
         end // ld
      5'b10011: begin // stu
         createDump =   1'b0;
         immExt5 =      1'b1; // sign extend
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b1;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b01;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b00; // destinaiton Rs inst[10:8]
         ALUop =        4'b0100;
         end // stu
      5'b11001: begin // btr
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b10; // destination Rd, bits[4:2]
         ALUop =        4'b1000;
         end // btr
      5'b11011: begin // add, sub, xor, andn
         case (instruction[1:0])
            2'b00: // add
            begin 
               createDump =   1'b0;
               immExt5 =      1'b0;
               immExt8 =      1'b0;
               jumpBranchBool=1'b0;
               jumpBranchExt =1'b0;
               jumpBranchPC = 1'b0;
               halt =         1'b0;
               regWrite =     1'b1;
               memRead =      1'b0;
               memWrite =     1'b0;
               ALUneg1 =      1'b0;
               ALUneg2 =      1'b0;
               ALUsrc =       2'b00;
               writeBackOp =  3'b010; // writeback straight from ALU
               regDst =       2'b10; // destination Rd, bits[4:2]
               ALUop =        4'b0100;
            end
            2'b01: // sub
            begin 
               createDump =   1'b0;
               immExt5 =      1'b0;
               immExt8 =      1'b0;
               jumpBranchBool=1'b0;
               jumpBranchExt =1'b0;
               jumpBranchPC = 1'b0;
               halt =         1'b0;
               regWrite =     1'b1;
               memRead =      1'b0;
               memWrite =     1'b0;
               ALUneg1 =      1'b1;
               ALUneg2 =      1'b0;
               ALUsrc =       2'b00;
               writeBackOp =  3'b010; // writeback straight from ALU
               regDst =       2'b10; // destination Rd, bits[4:2]
               ALUop =        4'b0100;
            end
            2'b10: // xor
            begin 
               createDump =   1'b0;
               immExt5 =      1'b0;
               immExt8 =      1'b0;
               jumpBranchBool=1'b0;
               jumpBranchExt =1'b0;
               jumpBranchPC = 1'b0;
               halt =         1'b0;
               regWrite =     1'b1;
               memRead =      1'b0;
               memWrite =     1'b0;
               ALUneg1 =      1'b0;
               ALUneg2 =      1'b0;
               ALUsrc =       2'b00;
               writeBackOp =  3'b010; // writeback straight from ALU
               regDst =       2'b10; // destination Rd, bits[4:2]
               ALUop =        4'b0110;
            end
            2'b11: // andn
            begin 
               createDump =   1'b0;
               immExt5 =      1'b0;
               immExt8 =      1'b0;
               jumpBranchBool=1'b0;
               jumpBranchExt =1'b0;
               jumpBranchPC = 1'b0;
               halt =         1'b0;
               regWrite =     1'b1;
               memRead =      1'b0;
               memWrite =     1'b0;
               ALUneg1 =      1'b0;
               ALUneg2 =      1'b1;
               ALUsrc =       2'b00;
               writeBackOp =  3'b010; // writeback straight from ALU
               regDst =       2'b10; // destination Rd, bits[4:2]
               ALUop =        4'b0101;
            end
            default: begin 
               createDump =   1'b0;
               immExt5 =      1'b0;
               immExt8 =      1'b0;
               jumpBranchBool=1'b0;
               jumpBranchExt =1'b0;
               jumpBranchPC = 1'b0;
               halt =         1'b0;
               regWrite =     1'b1;
               memRead =      1'b0;
               memWrite =     1'b0;
               ALUneg1 =      1'b0;
               ALUneg2 =      1'b0;
               ALUsrc =       2'b00;
               writeBackOp =  3'b010; // writeback straight from ALU
               regDst =       2'b10; // destination Rd, bits[4:2]
               ALUop =        4'b0101;
            end
         endcase 
         end 
      5'b11010: begin // sll, srl, rol, ror
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b010; // writeback straight from ALU
         regDst =       2'b10; // destination Rd, bits[4:2]
         ALUop =        {2'b00, instruction[1:0]};
         end //sll, srl, rol, ror
      5'b11100: begin // seq
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b100; // writeback straight from ALU condition outputs
         regDst =       2'b10; // destination Rd, bits[4:2]
         ALUop =        4'b0100;
         end // seq
      5'b11101: begin // slt
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b100; // writeback straight from ALU condition outputs
         regDst =       2'b10; // destination Rd, bits[4:2]
         ALUop =        4'b0100;
         end // slt
      5'b11110: begin // sle
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b100; // writeback straight from ALU condition outputs
         regDst =       2'b10; // destination Rd, bits[4:2]
         ALUop =        4'b0100;
         end // sle
      5'b11111: begin // sco
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b100; // writeback straight from ALU condition outputs
         regDst =       2'b10; // destination Rd, bits[4:2]
         ALUop =        4'b0100;
         end // sco
      5'b01100: begin // beqz
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b0; // branch to 8bit imm
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b11; // input 0 to ALU
         writeBackOp =  3'b000; // no writeback
         regDst =       2'b00;
         ALUop =        4'b0100;
         end // beqz
      5'b01101: begin // bnez
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b0; // branch to 8bit imm
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b11; // input 0 to ALU
         writeBackOp =  3'b000; // no writeback
         regDst =       2'b00;
         ALUop =        4'b0100;
         end // bnez
      5'b01110: begin // bltz
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b0; // branch to 8bit imm
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b11; // input 0 to ALU
         writeBackOp =  3'b000; // no writeback
         regDst =       2'b00;
         ALUop =        4'b0100;
         end // bltz
      5'b01111: begin // bgez
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b0; // branch to 8bit imm
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b1;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b11; // input 0 to ALU
         writeBackOp =  3'b000; // no writeback
         regDst =       2'b00;
         ALUop =        4'b0100;
         end // bgez
      5'b11000: begin // lbi
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b1; // sign extend
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b10;
         writeBackOp =  3'b011; // writeback directly from immediate
         regDst =       2'b00; // destinaiton Rs inst[10:8]
         ALUop =        4'b0000;
         end // lbi
      5'b10010: begin // slbi
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0; // zero extend
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b10;
         writeBackOp =  3'b010; // writeback straight from ALU 
         regDst =       2'b00; // destinaiton Rs inst[10:8]
         ALUop =        4'b1100;
         end // slbi
      5'b00100: begin // j
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b1; // jump to 11 bit imm
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
         end // j
      5'b00101: begin // jr
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b0; // use 8bit imm
         jumpBranchPC = 1'b1; // jump to reg value + 8bit imm 
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
         end // jr
      5'b00110: begin // jal
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b1; // use 11bit imm
         jumpBranchPC = 1'b0; 
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b000; // writeback PC +2 to r7
         regDst =       2'b11; // destination R7
         ALUop =        4'b0000;
         end // jal
      5'b00111: begin // jalr
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b1;
         jumpBranchExt =1'b0; // use 8bit imm
         jumpBranchPC = 1'b1; // add Reg val
         halt =         1'b0;
         regWrite =     1'b1;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b10;
         writeBackOp =  3'b000; // writeback PC + 2 to R7
         regDst =       2'b11; // destination R7
         ALUop =        4'b0000;
         end // jalr
      5'b00010: begin // siic
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
         end // siic (EC)
      5'b00011: begin // nop/rti
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp =  3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
         end // NOP/RTI (EC)
      default: begin 
         // nop
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp = 3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
      end
    endcase
     end
     default: begin 
         // nop
         createDump =   1'b0;
         immExt5 =      1'b0;
         immExt8 =      1'b0;
         jumpBranchBool=1'b0;
         jumpBranchExt =1'b0;
         jumpBranchPC = 1'b0;
         halt =         1'b0;
         regWrite =     1'b0;
         memRead =      1'b0;
         memWrite =     1'b0;
         ALUneg1 =      1'b0;
         ALUneg2 =      1'b0;
         ALUsrc =       2'b00;
         writeBackOp = 3'b000; 
         regDst =       2'b00;
         ALUop =        4'b0000;
     end
    endcase
endmodule
`default_nettype wire