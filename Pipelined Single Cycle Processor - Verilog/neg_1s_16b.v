/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Inverter 16-bit

    If invBit=1 then out=inverse of in
*/
`default_nettype none
module neg_1s_16b(out, in, negBit);
    // inputs
    input wire [15:0] in;
    input wire negBit;

    // ouputs
    output wire [15:0] out;

    // inversion
    assign out = {16{negBit}} ^ in;

endmodule
`default_nettype wire