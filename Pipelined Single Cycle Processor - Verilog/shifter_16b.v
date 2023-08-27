/*
    CS522 Project 

    Will Martin
    Neil Walsh

    16-bit barrel shifter
*/
`default_nettype none
module shifter_16b (out, in, op, shift);
    // inputs
    input wire [15:0] in;
    input wire [1:0] op;
    input wire [3:0] shift;

    // outputs
    output wire [15:0] out;

    // zero
    wire zero;
    assign zero = 0;

    // reverse
    wire [15:0] w_r1;
    reverse_16b reverse_16b_1 (.out(w_r1), .in(in), .revBit(op[0]));


    ////////////////////////////
    // shift module 1 (amount=1)
    ////////////////////////////

    // wrap around 1
    wire w_wa1_1;
    mux_1b_2to1 mux_1b_2to1_1 (.out(w_wa1_1), .in1(zero), .in2(w_r1[15]), .sel(op[1]));

    // construct shift values
    wire [15:0] w_shift1;
    assign w_shift1[15:1] = w_r1[14:0];
    assign w_shift1[0] = w_wa1_1;

    // shift
    wire [15:0] w_s1;
    mux_16b_2to1 mux_16b_2to1_1 (.out(w_s1), .in1(w_r1), .in2(w_shift1), .sel(shift[0]));


    ////////////////////////////
    // shift module 2 (amount=2)
    ////////////////////////////

    // wrap around module 2_1
    wire w_wa2_1;
    mux_1b_2to1 mux_1b_2to1_2 (.out(w_wa2_1), .in1(zero), .in2(w_s1[15]), .sel(op[1]));
    // wrap around module 2_2
    wire w_wa2_2;
    mux_1b_2to1 mux_1b_2to1_3 (.out(w_wa2_2), .in1(zero), .in2(w_s1[14]), .sel(op[1]));

    // construct shift values
    wire [15:0] w_shift2;
    assign w_shift2[15:2] = w_s1[13:0];
    assign w_shift2[1] = w_wa2_1;
    assign w_shift2[0] = w_wa2_2;

    // shift
    wire [15:0] w_s2;
    mux_16b_2to1 mux_16b_2to1_2 (.out(w_s2), .in1(w_s1), .in2(w_shift2), .sel(shift[1]));


    ////////////////////////////
    // shift module 3 (amount=4)
    ////////////////////////////

    // wrap around module 3_1
    wire w_wa3_1;
    mux_1b_2to1 mux_1b_2to1_4 (.out(w_wa3_1), .in1(zero), .in2(w_s2[15]), .sel(op[1]));
    // wrap around module 3_2
    wire w_wa3_2;
    mux_1b_2to1 mux_1b_2to1_5 (.out(w_wa3_2), .in1(zero), .in2(w_s2[14]), .sel(op[1]));
    // wrap around module 3_3
    wire w_wa3_3;
    mux_1b_2to1 mux_1b_2to1_6 (.out(w_wa3_3), .in1(zero), .in2(w_s2[13]), .sel(op[1]));
    // wrap around module 3_4
    wire w_wa3_4;
    mux_1b_2to1 mux_1b_2to1_7 (.out(w_wa3_4), .in1(zero), .in2(w_s2[12]), .sel(op[1]));

    // construct shift values
    wire [15:0] w_shift3;
    assign w_shift3[15:4] = w_s2[11:0];
    assign w_shift3[3] = w_wa3_1;
    assign w_shift3[2] = w_wa3_2;
    assign w_shift3[1] = w_wa3_3;
    assign w_shift3[0] = w_wa3_4;

    // shift
    wire [15:0] w_s3;
    mux_16b_2to1 mux_16b_2to1_3 (.out(w_s3), .in1(w_s2), .in2(w_shift3), .sel(shift[2]));


    ////////////////////////////
    // shift module 4 (amount=8)
    ////////////////////////////
    
    // wrap around module 4_1
    wire w_wa4_1;
    mux_1b_2to1 mux_1b_2to1_8 (.out(w_wa4_1), .in1(zero), .in2(w_s3[15]), .sel(op[1]));
    // wrap around module 4_2
    wire w_wa4_2;
    mux_1b_2to1 mux_1b_2to1_9 (.out(w_wa4_2), .in1(zero), .in2(w_s3[14]), .sel(op[1]));
    // wrap around module 4_3
    wire w_wa4_3;
    mux_1b_2to1 mux_1b_2to1_10 (.out(w_wa4_3), .in1(zero), .in2(w_s3[13]), .sel(op[1]));
    // wrap around module 4_4
    wire w_wa4_4;
    mux_1b_2to1 mux_1b_2to1_11 (.out(w_wa4_4), .in1(zero), .in2(w_s3[12]), .sel(op[1]));
    // wrap around module 4_5
    wire w_wa4_5;
    mux_1b_2to1 mux_1b_2to1_12 (.out(w_wa4_5), .in1(zero), .in2(w_s3[11]), .sel(op[1]));
    // wrap around module 4_6
    wire w_wa4_6;
    mux_1b_2to1 mux_1b_2to1_13 (.out(w_wa4_6), .in1(zero), .in2(w_s3[10]), .sel(op[1]));
    // wrap around module 4_7
    wire w_wa4_7;
    mux_1b_2to1 mux_1b_2to1_14 (.out(w_wa4_7), .in1(zero), .in2(w_s3[9]), .sel(op[1]));
    // wrap around module 4_8
    wire w_wa4_8;
    mux_1b_2to1 mux_1b_2to1_15 (.out(w_wa4_8), .in1(zero), .in2(w_s3[8]), .sel(op[1]));

    // construct shift values
    wire [15:0] w_shift4;
    assign w_shift4[15:8] = w_s3[7:0];
    assign w_shift4[7] = w_wa4_1;
    assign w_shift4[6] = w_wa4_2;
    assign w_shift4[5] = w_wa4_3;
    assign w_shift4[4] = w_wa4_4;
    assign w_shift4[3] = w_wa4_5;
    assign w_shift4[2] = w_wa4_6;
    assign w_shift4[1] = w_wa4_7;
    assign w_shift4[0] = w_wa4_8;

    // shift
    wire [15:0] w_s4;
    mux_16b_2to1 mux_16b_2to1_4 (.out(w_s4), .in1(w_s3), .in2(w_shift4), .sel(shift[3]));


    // reverse back
    wire [15:0] w_r2;
    reverse_16b reverse_16b_2 (.out(w_r2), .in(w_s4), .revBit(op[0]));


    // assign output
    assign out = w_r2;
endmodule
`default_nettype wire
