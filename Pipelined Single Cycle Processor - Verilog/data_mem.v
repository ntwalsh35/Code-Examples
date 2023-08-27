/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Data memory
*/
`default_nettype none
module data_mem (out, addr, in, memRead, memWrite, createDump, clk, rst);
    // inputs
    input wire [15:0] addr, in;
    input wire memRead, memWrite, createDump, clk, rst;

    // outputs
    output wire [15:0] out;

    // memory
    wire w_enabled, w_wr;
    assign w_enabled = memRead ^ memWrite;
    assign w_wr = memWrite ? 1'b1 : 1'b0;
    memory2c memory2c_1 (.data_out(out), .data_in(in), .addr(addr), .enable(w_enabled), .wr(w_wr), .createdump(createDump), .clk(clk), .rst(rst));

endmodule
`default_nettype wire