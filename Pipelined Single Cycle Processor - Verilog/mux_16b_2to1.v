/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Mux 2:1 16-bit

    sel=0, out=in1
    sel=1, out=in2
*/
`default_nettype none
module mux_16b_2to1 (out, in1, in2, sel);
    // inputs
    input wire [15:0] in1, in2;
    input wire sel;

    // outputs
    output reg [15:0] out;

    always @* begin
        case(sel)
            1'b0: out=in1;
            1'b1: out=in2; 
            default: out=in1;
        endcase
    end
endmodule
`default_nettype wire