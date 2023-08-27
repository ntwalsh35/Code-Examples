`default_nettype none
module or4 (out, in1, in2, in3, in4);
    output wire out;
    input wire in1, in2, in3, in4;

    wire w1;

    or3 or3_1(.out(w1), .in1(in1), .in2(in2), .in3(in3));
    or2 or2_1(.out(out), .in1(w1), .in2(in4));
endmodule
`default_nettype wire
