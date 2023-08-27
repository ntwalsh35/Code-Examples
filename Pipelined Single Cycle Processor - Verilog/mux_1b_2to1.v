/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Mux 2:1 1-bit

    sel=0, out=in1
    sel=1, out=in2
*/
`default_nettype none
module mux_1b_2to1 (out, in1, in2, sel);
    // inputs
    input wire in1, in2;
    input wire sel;

    // outputs
    output reg out;

    always @* begin
        case(sel)
            1'b0: out=in1;
            1'b1: out=in2; 
            default: out=in1;
        endcase
    end
endmodule
`default_nettype wire