/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    slbi
*/
`default_nettype none
module slbi_bench;
    // inputs
    reg [15:0] in1, in2;
    
    // outputs
    wire [15:0] out;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    slbi UUT (out, in1, in2);

    // test
    initial begin
        in1 = 16'b0;
        in2 = 16'b0;
        #3200 $finish;
    end

    always@(posedge clk) begin
        in1 = $random;
        in2 = $random;
    end

    always@(negedge clk) begin
        $display("in1: %b, in2: %b, out: %b", in1, in2, out);
    end
endmodule
`default_nettype wire