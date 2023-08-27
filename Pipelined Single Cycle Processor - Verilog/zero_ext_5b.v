/*
    CS522 Project 

    Will Martin
    Neil Walsh

    zero extend 5b to 16b
*/
`default_nettype none
module zero_ext_5b (out, in);
    // inputs
    input wire [4:0] in;

    // outputs
    output wire [15:0] out;

    assign out = {1'b0, in[4:0]};

endmodule
`default_nettype wire