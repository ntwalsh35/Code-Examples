/*
    CS522 Project 
    
    Will Martin
    Neil Walsh

    Testbench:
    alu 16b bench
*/
`default_nettype none
module alu_16b_bench;
    // inputs
    reg [15:0] in1, in2;
    reg [3:0] op;
    reg neg1, neg2;

    // outputs
    wire [15:0] out;
    wire cOut, zero, gZero;

    // testing variables
    reg [15:0] in1_neg, in2_neg, rotated_val;
    reg passing;
    integer i;

    // clock
    wire clk;
    wire rst;
    wire err;
    clkrst my_clkrst (.clk(clk), .rst(rst), .err(err));

    // module (unit under test)
    alu_16b UUT (out, cOut, zero, gZero, in1, in2, op, neg1, neg2);

    // test
    initial begin
        in1 = 16'b0;
        in2 = 16'b0;
        op = 4'b0;
        neg1 = 1'b0;
        neg2 = 1'b0;
        passing = 1'b0;
        #128000 $finish;
    end

    always@(posedge clk) begin
        in1 = $random;
        in2 = $random;
        op = $random;
        neg1 = $random;
        neg2 = $random;
    end

    always@(negedge clk) begin
        // if ((sel==1'b0 && out==in1) || (sel==1'b1 && out==in2))
        //     $write("PASSED: ");
        // else
        //     $write("FAILED: ");

        in1_neg = neg1 ? -in1 : in1;
        in2_neg = neg2 ? ~in2 : in2;

        // shift left
        passing = 0;
        if (op == 4'b0000) begin
            if (out == (in1_neg << in2_neg[3:0]))
                passing = 1;
        end

        // shift right
        else if (op == 4'b0001) begin
            if (out == (in1_neg >> in2_neg[3:0]))
                passing = 1;
        end

        // rotate left
        else if (op == 4'b0010) begin
            for (i = 0; i < 16; i = i + 1) begin
                if (i < in2_neg[3:0]) begin
                    rotated_val[i] = in1_neg[15 - in2_neg[3:0] + i + 1];
                end else begin
                    rotated_val[i] = in1_neg[i - in2_neg[3:0]];
                end
            end

            if (out == rotated_val)
                passing = 1;
        end

        // rotate right
        else if (op == 4'b0011) begin
            for (i = 0; i < 16; i = i + 1) begin
                if ((in2_neg[3:0] != 0) && (i <= (in2_neg[3:0]-1))) begin
                    rotated_val[16 - in2_neg[3:0] + i] = in1_neg[i];
                end else begin
                    rotated_val[i - in2_neg[3:0]] = in1_neg[i];
                end
            end

            if (out == rotated_val)
                passing = 1;
        end

        // in1 + in 2
        else if (op == 4'b0100) begin
            if (out == (in1_neg + in2_neg))
                passing = 1;
        end

        // in1 & in 2
        else if (op == 4'b0101) begin
            if (out == (in1_neg & in2_neg))
                passing = 1;
        end

        // in1 ^ in 2
        else if (op == 4'b0110) begin
            if (out == (in1_neg ^ in2_neg))
                passing = 1;
        end

        // extra
        else if (op == 4'b0111) begin
            passing = 1;
        end

        // reverse in1
        else if ((op == 4'b1000)|(op == 4'b1001)|(op == 4'b1010)|(op == 4'b1011)) begin
            for (i = 0; i < 16; i = i + 1) begin
                rotated_val[16-i-1] = in1_neg[i];
            end
            if (out == rotated_val)
                passing = 1;
        end

        // shift in1 by 8 and replace lower 8 bits by in2
        else if ((op == 4'b1100)|(op == 4'b1101)|(op == 4'b1110)|(op == 4'b1111)) begin
            if (out == {in1_neg[7:0], in2_neg[7:0]})
                passing = 1;
        end

        // zero
        if (((out == 0) && !zero) || ((out != 0) && zero))
            passing = 0;

        // > zero
        // untested

        // cOut
        // untested

        if (passing)
            $write("    PASSED: ");
        else
            $write("NOT PASSED: ");

        $display(
            "in1: 0x%x, in2: 0x%x, op: %b, neg1: %b, neg2: %b, out: 0x%x, cOut: %b, zero: %b, gZero: %b, golden: 0x%x",
            in1, in2, op, neg1, neg2, out, cOut, zero, gZero, rotated_val
        );
    end
endmodule
`default_nettype wire