/*
   CS/ECE 552 Spring '22


   Authors         : Neil Walsh
                     Will Martin
   Filename        : fetch.v
   Description     : This is the module for the hazard detection in decode stage of the   processor.
*/



`default_nettype none
module hazardDetection (
    // output
    writeFD, PCMuxBit0Sig, controlMuxSig, 
    // input
    inst15_0, E_rWriteReg, M_rWriteReg, E_regWriteEn, E_jumpBranchBool, M_regWriteEn, M_jumpBranchBool, M_jumpBranchAdd, E_jumpBranchAdd, E_memRead, E_readReg2, D_readReg1, D_readReg2
);
    input wire [15:0]   inst15_0;
    input wire [2:0]    E_rWriteReg, 
                        M_rWriteReg, E_readReg2, D_readReg1, D_readReg2;
    input wire          E_regWriteEn, 
                        E_jumpBranchBool, 
                        M_regWriteEn, E_memRead, 
                        M_jumpBranchBool, M_jumpBranchAdd, E_jumpBranchAdd;

    output reg          writeFD, 
                        PCMuxBit0Sig, 
                        controlMuxSig;

    // internal signals


    always @* 
            case (E_jumpBranchAdd) // was bool
                1'b1: begin
                    writeFD = 1'b0;
                    controlMuxSig = 1'b1;
                    PCMuxBit0Sig = 1'b1; // technically x - changed this line first from 0 to 1
                    end
                1'b0: begin
                        case (M_jumpBranchAdd) // was bool
                        1'b1:   begin
                                writeFD = 1'b1;
                                controlMuxSig = 1'b1;
                                PCMuxBit0Sig = 1'b0; // changed this line 2nd from 0 to 1
                                end
                        1'b0:   begin
                            case(((E_memRead) & ((E_readReg2 == D_readReg1) | (E_readReg2 == D_readReg2))))
                            1'b1: begin
                                writeFD = 1'b0;
                                controlMuxSig = 1'b1;
                                PCMuxBit0Sig = 1'b1;
                                end
                            1'b0: begin
                                writeFD = 1'b1;
                                controlMuxSig = 1'b0;
                                PCMuxBit0Sig = 1'b0;
                            end
                            default: begin 
                                writeFD = 1'b1;
                                controlMuxSig = 1'b0;
                                PCMuxBit0Sig = 1'b0;
                                end

                            endcase 
                            end
                        default: begin
                            writeFD = 1'b1;
                            controlMuxSig = 1'b0;
                            PCMuxBit0Sig = 1'b0;
                            end
                        endcase
                    end
                    default: begin
                            writeFD = 1'b1;
                            controlMuxSig = 1'b0;
                            PCMuxBit0Sig = 1'b0;
                            end
            endcase


    


endmodule
`default_nettype wire
