`default_nettype none
module and4 (out, in1, in2, in3, in4);
    output wire out;
    input wire in1, in2, in3, in4;

    wire w1;

    and3 and3_1(.out(w1), .in1(in1), .in2(in2), .in3(in3));
    and2 and2_1(.out(out), .in1(w1), .in2(in4));
endmodule
`default_nettype wire
