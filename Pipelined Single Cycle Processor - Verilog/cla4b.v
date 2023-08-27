/*
    CS/ECE 552 Spring '23
    Homework #1, Problem 2
    
    a 4-bit CLA module

        Will Martin
*/
`default_nettype none
module cla4b(sum, cOut, inA, inB, cIn);
    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    // outputs
    output wire [N-1:0] sum;
    output wire cOut;

    // inpus
    input wire [N-1: 0] inA, inB;
    input wire cIn;

    // propogate and generate
    wire [N-1:0] p;
    wire [N-1:0] g;

    // carry
    wire [N-1:0] c;

    // dummy carryouts for adders
    wire [N-1:0] c_dummy;

    // propogates
    or2 or2_1(.out(p[0]), .in1(inA[0]), .in2(inB[0]));
    or2 or2_2(.out(p[1]), .in1(inA[1]), .in2(inB[1]));
    or2 or2_3(.out(p[2]), .in1(inA[2]), .in2(inB[2]));
    or2 or2_4(.out(p[3]), .in1(inA[3]), .in2(inB[3]));
    
    // generates
    and2 and2_1(.out(g[0]), .in1(inA[0]), .in2(inB[0]));
    and2 and2_2(.out(g[1]), .in1(inA[1]), .in2(inB[1]));
    and2 and2_3(.out(g[2]), .in1(inA[2]), .in2(inB[2]));
    and2 and2_4(.out(g[3]), .in1(inA[3]), .in2(inB[3]));

    // carry 1
    wire c1;
    and2 and2_5(.out(c1), .in1(p[0]), .in2(cIn));
    or2 or2_5(.out(c[0]), .in1(c1), .in2(g[0]));

    // carry 2
    wire c2_1, c2_2;
    and3 and3_1(.out(c2_1), .in1(p[1]), .in2(p[0]), .in3(cIn));
    and2 and2_6(.out(c2_2), .in1(p[1]), .in2(g[0]));
    or3 or3_1(.out(c[1]), .in1(g[1]), .in2(c2_2), .in3(c2_1));

    //carry 3
    wire c3_1, c3_2, c3_3;
    and4 and4_1(.out(c3_1), .in1(p[2]), .in2(p[1]), .in3(p[0]), .in4(cIn));
    and3 and3_3(.out(c3_2), .in1(p[2]), .in2(p[1]), .in3(g[0]));
    and2 and2_8(.out(c3_3), .in1(p[2]), .in2(g[1]));
    or4 or4_1(.out(c[2]), .in1(g[2]), .in2(c3_3), .in3(c3_2), .in4(c3_1));

    // carry 4
    wire c4_1, c4_2, c4_3, c4_4;
    and5 and5_1(.out(c4_1), .in1(p[3]), .in2(p[2]), .in3(p[1]), .in4(p[0]), .in5(cIn));
    and4 and4_2(.out(c4_2), .in1(p[3]), .in2(p[2]), .in3(p[1]), .in4(g[0]));
    and3 and3_4(.out(c4_3), .in1(p[3]), .in2(p[2]), .in3(g[1]));
    and2 and2_9(.out(c4_4), .in1(p[3]), .in2(g[2]));
    or5 or5_1(.out(c[3]), .in1(g[3]), .in2(c4_4), .in3(c4_3), .in4(c4_2), .in5(c4_1));

    // adders
    fullAdder1b fullAdder1b_0(.s(sum[0]), .cOut(c_dummy[0]), .inA(inA[0]), .inB(inB[0]), .cIn(cIn));
    fullAdder1b fullAdder1b_1(.s(sum[1]), .cOut(c_dummy[1]), .inA(inA[1]), .inB(inB[1]), .cIn(c[0]));
    fullAdder1b fullAdder1b_2(.s(sum[2]), .cOut(c_dummy[2]), .inA(inA[2]), .inB(inB[2]), .cIn(c[1]));
    fullAdder1b fullAdder1b_3(.s(sum[3]), .cOut(c_dummy[3]), .inA(inA[3]), .inB(inB[3]), .cIn(c[2]));

    // carry out
    assign cOut = c[3];
endmodule
`default_nettype wire
