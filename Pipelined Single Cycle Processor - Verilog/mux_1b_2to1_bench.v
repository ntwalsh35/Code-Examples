/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    Mux 2:1 1-bit
*/
`default_nettype none
module mux_1b_2to1_bench;
    // inputs
    reg in1, in2;
    reg sel;
    
    // outputs
    wire out;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    mux_1b_2to1 UUT (out, in1, in2, sel);

    // test
    initial begin
        in1 = 1'b0;
        in2 = 1'b0;
        sel = 1'b0;
        #3200 $finish;
    end

    always@(posedge clk) begin
        in1 = $random;
        in2 = $random;
        sel = $random;
    end

    always@(negedge clk) begin
        if ((sel==1'b0 && out==in1) || (sel==1'b1 && out==in2))
            $write("PASSED: ");
        else
            $write("FAILED: ");

        $display("in1: 0x%x, in2: 0x%x, sel: 0x%x, out: 0x%x", in1, in2, sel, out);
    end
endmodule
`default_nettype wire