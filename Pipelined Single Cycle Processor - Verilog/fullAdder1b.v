/*
    CS/ECE 552 Spring '23
    Homework #1, Problem 2
    
    a 1-bit full adder

    Will Martin
*/
`default_nettype none
module fullAdder1b(s, cOut, inA, inB, cIn);
    output wire s;
    output wire cOut;
    input wire inA, inB;
    input wire cIn;

    wire w1, w2, w3;

    and2 and2_inst_1(.out(w1), .in1(inA), .in2(inB));
    and2 and2_inst_2(.out(w2), .in1(inA), .in2(cIn));
    and2 and2_inst_3(.out(w3), .in1(inB), .in2(cIn));

    or3 or3_inst(.out(cOut), .in1(w1), .in2(w2), .in3(w3));

    xor3 xor3_inst(.out(s), .in1(inA), .in2(inB), .in3(cIn));
endmodule
`default_nettype wire
