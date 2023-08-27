/*
    CS522 Project 

    Will Martin
    Neil Walsh

    sign extend 8b to 16b
*/
`default_nettype none
module sign_ext_8b (out, in);
    // inputs
    input wire [7:0] in;

    // outputs
    output wire [15:0] out;

    assign out = {{8{in[7]}}, in[7:0]};

endmodule
`default_nettype wire