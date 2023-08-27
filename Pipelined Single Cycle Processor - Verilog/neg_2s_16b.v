/*
    CS522 Project 

    Will Martin
    Neil Walsh

    2's complement negation of 16bit number
*/
`default_nettype none
module neg_2s_16b (out, in, negBit);
    // inputs
    input wire [15:0] in;
    input wire negBit;

    // outputs
    output wire [15:0] out;

    // invert all bits
    wire [15:0] w_inv;
    assign w_inv = ~in;

    // add one
    // sequency of half adders
    wire [15:0] temp_out;
    wire [15:0] carry;

    assign temp_out[0] = w_inv[0] ^ 1'b1;
    assign carry[0] = w_inv[0] & 1'b1;

    assign temp_out[1] = w_inv[1] ^ carry[0];
    assign carry[1] = w_inv[1] & carry[0];

    assign temp_out[2] = w_inv[2] ^ carry[1];
    assign carry[2] = w_inv[2] & carry[1];

    assign temp_out[3] = w_inv[3] ^ carry[2];
    assign carry[3] = w_inv[3] & carry[2];

    assign temp_out[4] = w_inv[4] ^ carry[3];
    assign carry[4] = w_inv[4] & carry[3];

    assign temp_out[5] = w_inv[5] ^ carry[4];
    assign carry[5] = w_inv[5] & carry[4];

    assign temp_out[6] = w_inv[6] ^ carry[5];
    assign carry[6] = w_inv[6] & carry[5];

    assign temp_out[7] = w_inv[7] ^ carry[6];
    assign carry[7] = w_inv[7] & carry[6];

    assign temp_out[8] = w_inv[8] ^ carry[7];
    assign carry[8] = w_inv[8] & carry[7];

    assign temp_out[9] = w_inv[9] ^ carry[8];
    assign carry[9] = w_inv[9] & carry[8];

    assign temp_out[10] = w_inv[10] ^ carry[9];
    assign carry[10] = w_inv[10] & carry[9];

    assign temp_out[11] = w_inv[11] ^ carry[10];
    assign carry[11] = w_inv[11] & carry[10];

    assign temp_out[12] = w_inv[12] ^ carry[11];
    assign carry[12] = w_inv[12] & carry[11];

    assign temp_out[13] = w_inv[13] ^ carry[12];
    assign carry[13] = w_inv[13] & carry[12];

    assign temp_out[14] = w_inv[14] ^ carry[13];
    assign carry[14] = w_inv[14] & carry[13];

    assign temp_out[15] = w_inv[15] ^ carry[14];

    mux_16b_2to1  mux_16b_2to1_1(.out(out), .in1(in), .in2(temp_out), .sel(negBit));

endmodule
`default_nettype wire