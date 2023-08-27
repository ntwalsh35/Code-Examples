/*
    CS522 Project 

    Will Martin
    Neil Walsh

    Instruction memory
*/
`default_nettype none
module inst_mem (inst, addr, clk, rst);
    // inputs
    input wire [15:0] addr;
    input wire clk, rst;

    // outputs
    output wire [15:0] inst;
    
    // memory
    // set contant enabled and read (is this correct?)
    memory2c memory2c_1 (.data_out(inst), .addr(addr), .enable(1'b1), .wr(1'b0), .clk(clk), .rst(rst), .data_in(16'b0), .createdump(1'b0));
    // TODO: set en to ~halt
endmodule
`default_nettype wire