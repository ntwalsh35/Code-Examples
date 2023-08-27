/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Mux 4:1 16-bit
*/
`default_nettype none
module mux_16b_8to1 (out, in1, in2, in3, in4, in5, in6, in7, in8, sel);
    // inputs
    input wire [15:0] in1, in2, in3, in4, in5, in6, in7, in8;
    input wire [2:0] sel;

    // outputs
    output reg [15:0] out;

    always @* begin
        case(sel)
            3'b000: out=in1;
            3'b001: out=in2;
            3'b010: out=in3;
            3'b011: out=in4;
            3'b100: out=in5;
            3'b101: out=in6;
            3'b110: out=in7;
            3'b111: out=in8;
            default: out=in1;
        endcase
    end
endmodule
`default_nettype wire