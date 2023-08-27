/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    2's complement negation of 16bit number
*/
`default_nettype none
module neg_2s_16b_bench;
    // inputs
    reg [15:0] in;
    reg negBit;
    
    // outputs
    wire [15:0] out;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    neg_2s_16b UUT (out, in, negBit);

    // test
    initial begin
        in = 16'b0;
        negBit = 1'b0;
        #3200 $finish;
    end

    always@(posedge clk) begin
        in = $random;
        negBit = $random;
    end

    always@(negedge clk) begin
        if (((out == -in) && (negBit == 1'b1)) || ((out == in) && (negBit == 1'b0)))
            $write("PASSED: ");
        else
            $write("FAILED: ");

        $display("in: %b, out: %b, neg: %b", in, out, negBit);
    end
endmodule
`default_nettype wire