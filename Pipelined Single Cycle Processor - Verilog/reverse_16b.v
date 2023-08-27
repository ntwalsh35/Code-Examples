/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Reverse 16-bit

    If revBit=1 then out=reverse in
*/
`default_nettype none
module reverse_16b(out, in, revBit);
    // inputs
    input wire [15:0] in;
    input wire revBit;

    // ouputs
    output wire [15:0] out;

    // reversal
    assign out[0] = revBit ? in[15] : in[0];
    assign out[1] = revBit ? in[14] : in[1];
    assign out[2] = revBit ? in[13] : in[2];
    assign out[3] = revBit ? in[12] : in[3];
    assign out[4] = revBit ? in[11] : in[4];
    assign out[5] = revBit ? in[10] : in[5];
    assign out[6] = revBit ? in[9] : in[6];
    assign out[7] = revBit ? in[8] : in[7];
    assign out[8] = revBit ? in[7] : in[8];
    assign out[9] = revBit ? in[6] : in[9];
    assign out[10] = revBit ? in[5] : in[10];
    assign out[11] = revBit ? in[4] : in[11];
    assign out[12] = revBit ? in[3] : in[12];
    assign out[13] = revBit ? in[2] : in[13];
    assign out[14] = revBit ? in[1] : in[14];
    assign out[15] = revBit ? in[0] : in[15];
endmodule
`default_nettype wire