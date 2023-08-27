
`default_nettype none
module forwardingUnit (
    // outputs
    rReadData1MuxSel, rReadData2MuxSel, 
    // inputs
    rReadReg1, rReadReg2, EM_rWriteReg, MW_rWriteReg, EM_regWriteEn, MW_regWriteEn, M_writeBackOp);

    // outputs
    output wire [2:0] rReadData1MuxSel, rReadData2MuxSel;
    // inputs
    input wire [2:0] rReadReg1, rReadReg2, EM_rWriteReg, MW_rWriteReg, M_writeBackOp;
    input wire EM_regWriteEn, MW_regWriteEn;

    assign rReadData1MuxSel = ((rReadReg1 == EM_rWriteReg) & EM_regWriteEn) ? 
                        (M_writeBackOp == 3'b011 ? 3'b001 : (M_writeBackOp == 3'b100 ? 3'b100 : 3'b011)) :
                        ((rReadReg1 == MW_rWriteReg) & MW_regWriteEn ? 3'b010 : 3'b000);
    assign rReadData2MuxSel = (rReadReg2 == EM_rWriteReg) & EM_regWriteEn ? 
                        (M_writeBackOp == 3'b011 ? 3'b001 : (M_writeBackOp == 3'b100 ? 3'b100 : 3'b011)) :
                        ((rReadReg2 == MW_rWriteReg) & MW_regWriteEn ? 3'b010 : 3'b000);

endmodule
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:
