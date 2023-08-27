/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Mux 4:1 16-bit
*/
`default_nettype none
module mux_16b_4to1 (out, in1, in2, in3, in4, sel);
    // inputs
    input wire [15:0] in1, in2, in3, in4;
    input wire [1:0] sel;

    // outputs
    output reg [15:0] out;

    always @* begin
        case(sel)
            2'b00: out=in1;
            2'b01: out=in2;
            2'b10: out=in3;
            2'b11: out=in4;
            default: out=in1;
        endcase
    end
endmodule
`default_nettype wire