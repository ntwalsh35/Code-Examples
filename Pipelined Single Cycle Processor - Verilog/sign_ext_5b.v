/*
    CS522 Project 

    Will Martin
    Neil Walsh

    sign extend 5b to 16b
*/
`default_nettype none
module sign_ext_5b (out, in);
    // inputs
    input wire [4:0] in;

    // outputs
    output wire [15:0] out;

    assign out = {{11{in[4]}}, in[4:0]};

endmodule
`default_nettype wire