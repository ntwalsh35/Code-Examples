`default_nettype none
module and5 (out, in1, in2, in3, in4, in5);
    output wire out;
    input wire in1, in2, in3, in4, in5;

    wire w1;

    and4 and4_1(.out(w1), .in1(in1), .in2(in2), .in3(in3), .in4(in4));
    and2 and2_1(.out(out), .in1(w1), .in2(in5));
endmodule
`default_nettype wire
