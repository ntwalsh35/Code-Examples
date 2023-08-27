/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    Inverter 16-bit
*/
`default_nettype none
module reverse_16b_bench;
    // inputs
    reg [15:0] in;
    reg revBit;
    
    // outputs
    wire [15:0] out;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    reverse_16b UUT (.out(out), .in(in), .revBit(revBit));

    // test
    initial begin
        in = 16'b0;
        revBit = 1'b0;
        #3200 $finish;
    end

    always@(posedge clk) begin
        in = $random;
        revBit = $random;
    end

    always@(negedge clk) begin
        $display("in: %b, invBit: 0x%x, out: %b", in, revBit, out);
    end
endmodule
`default_nettype wire