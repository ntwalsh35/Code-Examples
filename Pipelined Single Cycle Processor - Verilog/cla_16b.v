/*
    CS/ECE 552 Spring '23
    Homework #1, Problem 2
    
    a 16-bit CLA module

    Will Martin
*/
`default_nettype none
module cla_16b(out, cOut, in1, in2, cIn);
    parameter N = 16; // size of input
    parameter N_sub = 4; // size of sub adder

    // outputs
    output wire [N-1:0] out;
    output wire cOut;

    // inputs
    input wire [N-1:0] in1, in2;
    input wire cIn;

    // propogates and generates
    wire [N-1:0] p;
    wire [N-1:0] g;

    // super propogates and generates
    wire [N_sub-1:0] P;
    wire [N_sub-1:0] G;

    // super carry
    wire [N_sub-1:0] C;

    // dummy carryouts for adders
    wire [N_sub-1:0] c_dummy;

    // calculate propogates and generates
    or2 or2_1(.out(p[0]), .in1(in1[0]), .in2(in2[0]));
    or2 or2_2(.out(p[1]), .in1(in1[1]), .in2(in2[1]));
    or2 or2_3(.out(p[2]), .in1(in1[2]), .in2(in2[2]));
    or2 or2_4(.out(p[3]), .in1(in1[3]), .in2(in2[3]));
    or2 or2_5(.out(p[4]), .in1(in1[4]), .in2(in2[4]));
    or2 or2_6(.out(p[5]), .in1(in1[5]), .in2(in2[5]));
    or2 or2_7(.out(p[6]), .in1(in1[6]), .in2(in2[6]));
    or2 or2_8(.out(p[7]), .in1(in1[7]), .in2(in2[7]));
    or2 or2_9(.out(p[8]), .in1(in1[8]), .in2(in2[8]));
    or2 or2_10(.out(p[9]), .in1(in1[9]), .in2(in2[9]));
    or2 or2_11(.out(p[10]), .in1(in1[10]), .in2(in2[10]));
    or2 or2_12(.out(p[11]), .in1(in1[11]), .in2(in2[11]));
    or2 or2_13(.out(p[12]), .in1(in1[12]), .in2(in2[12]));
    or2 or2_14(.out(p[13]), .in1(in1[13]), .in2(in2[13]));
    or2 or2_15(.out(p[14]), .in1(in1[14]), .in2(in2[14]));
    or2 or2_16(.out(p[15]), .in1(in1[15]), .in2(in2[15]));

    and2 and2_1(.out(g[0]), .in1(in1[0]), .in2(in2[0]));
    and2 and2_2(.out(g[1]), .in1(in1[1]), .in2(in2[1]));
    and2 and2_3(.out(g[2]), .in1(in1[2]), .in2(in2[2]));
    and2 and2_4(.out(g[3]), .in1(in1[3]), .in2(in2[3]));
    and2 and2_5(.out(g[4]), .in1(in1[4]), .in2(in2[4]));
    and2 and2_6(.out(g[5]), .in1(in1[5]), .in2(in2[5]));
    and2 and2_7(.out(g[6]), .in1(in1[6]), .in2(in2[6]));
    and2 and2_8(.out(g[7]), .in1(in1[7]), .in2(in2[7]));
    and2 and2_9(.out(g[8]), .in1(in1[8]), .in2(in2[8]));
    and2 and2_10(.out(g[9]), .in1(in1[9]), .in2(in2[9]));
    and2 and2_11(.out(g[10]), .in1(in1[10]), .in2(in2[10]));
    and2 and2_12(.out(g[11]), .in1(in1[11]), .in2(in2[11]));
    and2 and2_13(.out(g[12]), .in1(in1[12]), .in2(in2[12]));
    and2 and2_14(.out(g[13]), .in1(in1[13]), .in2(in2[13]));
    and2 and2_15(.out(g[14]), .in1(in1[14]), .in2(in2[14]));
    and2 and2_16(.out(g[15]), .in1(in1[15]), .in2(in2[15]));

    // calculate super propogates and generates

    // G1
    wire g1_1, g1_2, g1_3;
    and4 and4_1(.out(g1_1), .in1(p[3]), .in2(p[2]), .in3(p[1]), .in4(g[0]));
    and3 and3_1(.out(g1_2), .in1(p[3]), .in2(p[2]), .in3(g[1]));
    and2 and2_17(.out(g1_3), .in1(p[3]), .in2(g[2]));
    or4 or4_1(.out(G[0]), .in1(g[3]), .in2(g1_3), .in3(g1_2), .in4(g1_1));
    // P1
    and4 and4_2(.out(P[0]), .in1(p[3]), .in2(p[2]), .in3(p[1]), .in4(p[0]));

    // G2
    wire g2_1, g2_2, g2_3;
    and4 and4_3(.out(g2_1), .in1(p[7]), .in2(p[6]), .in3(p[5]), .in4(g[4]));
    and3 and3_2(.out(g2_2), .in1(p[7]), .in2(p[6]), .in3(g[5]));
    and2 and2_18(.out(g2_3), .in1(p[7]), .in2(g[6]));
    or4 or4_2(.out(G[1]), .in1(g[7]), .in2(g2_3), .in3(g2_2), .in4(g2_1));
    // P2
    and4 and4_4(.out(P[1]), .in1(p[7]), .in2(p[6]), .in3(p[5]), .in4(p[4]));

    // G3
    wire g3_1, g3_2, g3_3;
    and4 and4_5(.out(g3_1), .in1(p[11]), .in2(p[10]), .in3(p[9]), .in4(g[8]));
    and3 and3_3(.out(g3_2), .in1(p[11]), .in2(p[10]), .in3(g[9]));
    and2 and2_19(.out(g3_3), .in1(p[11]), .in2(g[10]));
    or4 or4_3(.out(G[2]), .in1(g[11]), .in2(g3_3), .in3(g3_2), .in4(g3_1));
    // P3
    and4 and4_6(.out(P[2]), .in1(p[11]), .in2(p[10]), .in3(p[9]), .in4(p[8]));

    // G4
    wire g4_1, g4_2, g4_3;
    and4 and4_7(.out(g4_1), .in1(p[15]), .in2(p[14]), .in3(p[13]), .in4(g[12]));
    and3 and3_4(.out(g4_2), .in1(p[15]), .in2(p[14]), .in3(g[13]));
    and2 and2_20(.out(g4_3), .in1(p[15]), .in2(g[14]));
    or4 or4_4(.out(G[3]), .in1(g[15]), .in2(g4_3), .in3(g4_2), .in4(g4_1));
    // P4
    and4 and4_8(.out(P[3]), .in1(p[15]), .in2(p[14]), .in3(p[13]), .in4(p[12]));

    // calculate super carrys

    // carry 1
    wire c1;
    and2 and2_21(.out(c1), .in1(P[0]), .in2(cIn));
    or2 or2_17(.out(C[0]), .in1(c1), .in2(G[0]));

    // carry 2
    wire c2_1, c2_2;
    and3 and3_5(.out(c2_1), .in1(P[1]), .in2(P[0]), .in3(cIn));
    and2 and2_22(.out(c2_2), .in1(P[1]), .in2(G[0]));
    or3 or3_1(.out(C[1]), .in1(G[1]), .in2(c2_2), .in3(c2_1));

    //carry 3
    wire c3_1, c3_2, c3_3;
    and4 and4_9(.out(c3_1), .in1(P[2]), .in2(P[1]), .in3(P[0]), .in4(cIn));
    and3 and3_6(.out(c3_2), .in1(P[2]), .in2(P[1]), .in3(G[0]));
    and2 and2_23(.out(c3_3), .in1(P[2]), .in2(G[1]));
    or4 or4_5(.out(C[2]), .in1(G[2]), .in2(c3_3), .in3(c3_2), .in4(c3_1));

    // carry 4
    wire c4_1, c4_2, c4_3, c4_4;
    and5 and5_1(.out(c4_1), .in1(P[3]), .in2(P[2]), .in3(P[1]), .in4(P[0]), .in5(cIn));
    and4 and4_10(.out(c4_2), .in1(P[3]), .in2(P[2]), .in3(P[1]), .in4(G[0]));
    and3 and3_7(.out(c4_3), .in1(P[3]), .in2(P[2]), .in3(G[1]));
    and2 and2_24(.out(c4_4), .in1(P[3]), .in2(G[2]));
    or5 or5_1(.out(C[3]), .in1(G[3]), .in2(c4_4), .in3(c4_3), .in4(c4_2), .in5(c4_1));

    // adders
    cla4b clas4b_0(.sum(out[3:0]), .cOut(c_dummy[0]), .inA(in1[3:0]), .inB(in2[3:0]), .cIn(cIn));
    cla4b clas4b_1(.sum(out[7:4]), .cOut(c_dummy[1]), .inA(in1[7:4]), .inB(in2[7:4]), .cIn(C[0]));
    cla4b clas4b_2(.sum(out[11:8]), .cOut(c_dummy[2]), .inA(in1[11:8]), .inB(in2[11:8]), .cIn(C[1]));
    cla4b clas4b_3(.sum(out[15:12]), .cOut(c_dummy[3]), .inA(in1[15:12]), .inB(in2[15:12]), .cIn(C[2]));

    // carry out
    assign cOut = C[3];
endmodule
`default_nettype wire
