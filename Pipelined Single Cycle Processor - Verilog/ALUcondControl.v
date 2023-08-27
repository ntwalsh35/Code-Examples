/*
   CS/ECE 552 Spring '22
  
   Filename        : ALUcondControl.v
   Description     : This is the module determining operations based on ALU condition codes
*/
`default_nettype none
module ALUcondControl (instruction, cOut, zero, gzero, jumpBranchAdd, aluControl);

    input wire [4:0] instruction;
    input wire cOut, zero, gzero;
    output reg jumpBranchAdd;
    output wire [15:0] aluControl;
    reg writeBack;

    assign aluControl = {15'b0, writeBack};

    always @* case (instruction)
        // sets
        5'b11100: // SEQ
        begin
            writeBack = zero;
            jumpBranchAdd = 1'b0;
        end
        5'b11101: // SLT
        begin
            writeBack = gzero;
            jumpBranchAdd = 1'b0;
        end
        5'b11110: // SLE
        begin
            writeBack = gzero | zero;
            jumpBranchAdd = 1'b0;
        end
        5'b11111: // SCO
        begin
            writeBack = cOut;
            jumpBranchAdd = 1'b0;
        end
        // branches
        5'b01100: // BEQZ
        begin
            writeBack = 1'b0;
            jumpBranchAdd = zero;
        end
        5'b01101: // BNEZ
        begin
            writeBack = 1'b0;
            jumpBranchAdd = ~zero;
        end
        5'b01110: // BLTZ
        begin
            writeBack = 1'b0;
            jumpBranchAdd = gzero;
        end
        5'b01111: // BGEZ
        begin
            writeBack = 1'b0;
            jumpBranchAdd = ~gzero;
        end
        5'b00100: // J
        begin
            writeBack = 1'b0;
            jumpBranchAdd = 1'b1;
        end
        5'b00101: // JR
        begin
            writeBack = 1'b0;
            jumpBranchAdd = 1'b1;
        end
        5'b00110: // JAL
        begin
            writeBack = 1'b0;
            jumpBranchAdd = 1'b1;
        end
        5'b00111: // JALR
        begin
            writeBack = 1'b0;
            jumpBranchAdd = 1'b1;
        end
        default: 
        begin
            jumpBranchAdd = 1'b0;
            writeBack = 1'b0;
        end
    endcase
   
endmodule
`default_nettype wire