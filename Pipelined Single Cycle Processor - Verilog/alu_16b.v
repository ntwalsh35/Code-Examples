/*
    CS522 Project 

    Will Martin
    Neil Walsh

    alu 16b
*/
`default_nettype none
module alu_16b (out, cOut, zero, gZero, in1, in2, op, neg1, neg2);
    // inputs
    input wire [15:0] in1, in2;
    input wire [3:0] op;
    input wire neg1, neg2;

    // outputs
    output wire [15:0] out;
    output wire cOut, zero, gZero;

    // negations
    wire [15:0] w_in1_neg, w_in2_neg;
    neg_2s_16b neg_2s_16b_1 (.out(w_in1_neg), .in(in1), .negBit(neg1));
    neg_1s_16b neg_1s_16b_1 (.out(w_in2_neg), .in(in2), .negBit(neg2));

    // always @* case (in1)
    //     16'h8000: begin w_in1_neg = 16'h7fff; end
    //     default: begin w_in1_neg = w_in1_neg; end
    // endcase

    // assign w_in1_neg = (w_in1_neg == 16'h8000) ? 16'h7fff : w_in1_neg;

    // shifter
    wire [15:0] w_shift;
    shifter_16b shifter_16b_1 (.out(w_shift), .in(w_in1_neg), .op(op[1:0]), .shift(w_in2_neg[3:0]));

    // and 
    wire [15:0] w_and;
    assign w_and = w_in1_neg & w_in2_neg;

    // xor 
    wire [15:0] w_xor;
    assign w_xor = w_in1_neg ^ w_in2_neg;

    // addition
    wire [15:0] w_add;
    cla_16b cla_16b_1 (.out(w_add), .cOut(cOut), .in1(w_in1_neg), .in2(w_in2_neg), .cIn(1'b0));

    // 4 to 1 mux: op[1:0]
    // 00 - add
    // 01 - and
    // 10 - xor
    // 11 - 
    wire [15:0] w_arithmetic;
    mux_16b_4to1 mux_16b_4to1_1 (.out(w_arithmetic), .in1(w_add), .in2(w_and), .in3(w_xor), .in4(16'b0), .sel(op[1:0]));

    // reverse
    wire [15:0] w_reverse;
    reverse_16b reverse_16b_1 (.out(w_reverse), .in(w_in1_neg), .revBit(1'b1));

    // sbi
    wire [15:0] w_sbi;
    slbi slbi_1 (.out(w_sbi), .in1(w_in1_neg), .in2(w_in2_neg));

    // 4 to 1 mux: op[3:2]
    // 00 - shift
    // 01 - arithmetic
    // 10 - reverse
    // 11 - sbi
    mux_16b_4to1 mux_16b_4to1_2 (.out(out), .in1(w_shift), .in2(w_arithmetic), .in3(w_reverse), .in4(w_sbi), .sel(op[3:2]));

    // zero
    assign zero = ~(|out); // | ((in1 == 16'h8000) & (in2 == 16'b0));



    // overflow from adder
    wire ofl;
    assign ofl = (out[15] & ~w_in1_neg[15] & ~w_in2_neg[15]) | (~out[15] & w_in1_neg[15] & w_in2_neg[15]);

    // greater than (not equal to) zero
    assign gZero = ((in1==16'h8000) | ((~out[15]^ofl) & ~zero)) & ~(in1==16'h8000 & in2==16'h8000);

    
endmodule
`default_nettype wire