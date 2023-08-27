/*
    CS522 Project 

    Will Martin
    Neil Walsh

    shift load byte
    shift in1 by 8, replace lower 8 bits by in2
*/
`default_nettype none
module slbi (out, in1, in2);
    // inputs
    input wire [15:0] in1, in2;

    // outputs
    output wire [15:0] out;

    assign out = {in1[7:0], in2[7:0]};
    
endmodule
`default_nettype wire