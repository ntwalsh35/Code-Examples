/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    Inverter 16-bit
*/
`default_nettype none
module neg_1s_16b_bench;
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
    neg_1s_16b UUT (.out(out), .in(in), .negBit(negBit));

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
        if ((negBit==1'b0 && out==in) || (negBit==1'b1 && out==~in))
            $write("PASSED: ");
        else
            $write("FAILED: ");

        $display("in: 0x%x, invBit: 0x%x, out: 0x%x", in, negBit, out);
    end
endmodule
`default_nettype wire