/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    16-bit barrel shifter
*/

`default_nettype none
module shifter_16b_bench;
    // inputs
    reg [15:0] in;
    reg [1:0] op;
    reg [3:0] shift;
    
    // outputs
    wire [15:0] out;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    shifter_16b UUT (out, in, op, shift);

    // test
    initial begin
        in = 16'b0;
        op = 2'b0;
        shift = 4'b0;
        #3200 $finish;
    end

    always@(posedge clk) begin
        in = $random;
        op = $random;
        shift = $random;
    end

    always@(negedge clk) begin
        $display("in: %b, op: %b, shift: 0x%x, out: %b", in, op, shift, out);
    end
endmodule
`default_nettype wire