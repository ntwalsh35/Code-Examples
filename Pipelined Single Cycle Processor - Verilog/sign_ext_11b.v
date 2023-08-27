/*
    CS522 Project 

    Will Martin
    Neil Walsh

    sign extend 11b to 16b
*/
`default_nettype none
module sign_ext_11b (out, in);
    // inputs
    input wire [10:0] in;

    // outputs
    output wire [15:0] out;

    assign out = {{5{in[10]}}, in[10:0]};

endmodule
`default_nettype wire