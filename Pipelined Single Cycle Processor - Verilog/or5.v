`default_nettype none
module or5 (out, in1, in2, in3, in4, in5);
    output wire out;
    input wire in1, in2, in3, in4, in5;

    wire w1;

    or4 or4_1(.out(w1), .in1(in1), .in2(in2), .in3(in3), .in4(in4));
    or2 or2_1(.out(out), .in1(w1), .in2(in5));
endmodule
`default_nettype wire
