/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    sign extend 11b to 16b
*/
`default_nettype none
module sign_ext_11b_bench;
    // inputs
    reg [10:0] in;
    
    // outputs
    wire [15:0] out;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    sign_ext_11b UUT (out, in);

    // test
    initial begin
        in = 11'b0;
        #3200 $finish;
    end

    always@(posedge clk) begin
        in = $random;
    end

    always@(negedge clk) begin
        $display("in: %b, out: %b", in, out);
    end
endmodule
`default_nettype wire