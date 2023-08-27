
// ASSOC!!!!!!!
///////////////////////

`default_nettype none
module cache_controller(
    // Outputs 
    c_comp0, 
    c_comp1, 
    c_write0, 
    c_write1, 
    c_offsetSel,  
    victimSel,
    m_offsetSel, 
    m_write, 
    m_read, 
    m_addrSel, 
    c_dataInSel, 
    control_stall, 
    control_done, 
    no_hit,
    // Inputs 
    memWrite, 
    memRead, 
    c_hit0,
    c_hit1, 
    c_dirty0,
    c_dirty1, 
    c_valid0,
    c_valid1, 
    m_stall, 
    m_busy, 
    clk, 
    rst
    );

// Outputs 
    output reg c_comp0, c_comp1, c_write0, c_write1, m_addrSel, m_write, m_read, c_dataInSel, no_hit;
    output wire victimSel;
    output wire control_stall, control_done;
    output reg [2:0] c_offsetSel, m_offsetSel;
    // Inputs 
    input wire memWrite, memRead, c_hit0, c_hit1, c_dirty0, c_dirty1, c_valid0, c_valid1, m_stall;
    input wire [3:0] m_busy;
    input wire clk, rst;

    // internal signals for state machine
    wire [3:0] currState;
    reg [3:0] newState;

    wire victimDirty, victimValid, victimHit;
    assign victimDirty = victimSel ? c_dirty1 : c_dirty0;
    assign victimValid = victimSel ? c_valid1 : c_valid0;
    assign victimHit = victimSel ? c_hit1 : c_hit0;

    // transitions
    wire a_trans, b_trans, b_trans_asynch, c_trans, d_trans, e_trans, f_trans, g_trans;
    reg read_hit_check;
    assign a_trans = (memWrite ^ memRead);
    assign b_trans = (c_valid0 & c_hit0) | (c_valid1 & c_hit1);
    assign c_trans = ~victimHit & victimDirty;
    assign d_trans = m_stall;
    assign e_trans = ~m_stall;
    assign f_trans = (!victimHit & !victimDirty) | !victimValid;
    assign control_stall = (|currState);
    assign control_done = (!currState) & (memRead ^ memWrite);

    // state flip flop
    dff_param #(.DATA_WIDTH(4)) stateRegister(.d(newState), .q(currState), .clk(clk), .en(1'b1), .rst(rst));
    //dff_param #(.DATA_WIDTH(1)) b_trans_reg (.d(b_trans_asynch), .q(b_trans), .clk(clk), .en(1'b1), .rst(rst));

    wire victimWay;
    dff_param  #(.DATA_WIDTH(1)) victimFF(.d(~victimWay), .q(victimWay), .clk(clk), .en(control_done), .rst(rst));
    assign victimSel = c_valid0 & (~c_valid1 | victimWay);

    always @* case(currState)
        4'b0000: begin // IDLE
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            read_hit_check = 1'b0;
            no_hit = 1'b1;
            m_write = 1'b0;
            m_read = 1'b0;
            m_addrSel = 1'b0;
            c_dataInSel = 1'b0;
            c_offsetSel = 3'b111;
            m_offsetSel = 3'b111;
            case (a_trans)
            1'b1: begin newState = 4'b0001; end
            1'b0: begin newState = 4'b0000; end
            default: begin newState = 4'b0000; end
            endcase
        end
        4'b0001: begin // COMPARE TAG

            no_hit = read_hit_check;
            case (memRead)
            1'b1:   begin
                    c_comp0 = 1'b1;
                    c_comp1 = 1'b1;
                    c_write0 = 1'b0;
                    c_write1 = 1'b0;
                    m_write = 1'b0;
                    m_read = 1'b0;
                    m_addrSel = 1'b0;
                    c_offsetSel = 3'b111;
            end
            1'b0: begin
                case (memWrite)
                    1'b1: begin c_comp0 = 1'b1;
                                c_comp1 = 1'b1;
                                c_write0 = 1'b1;
                                c_write1 = 1'b1;
                                m_write = 1'b0;
                                m_read = 1'b0;
                                c_offsetSel = 3'b111;
                                c_dataInSel = 1'b0;
                                m_addrSel = 1'b0;
                                end
                    1'b0: begin 
                                c_comp0 = 1'b1;
                                c_comp1 = 1'b1;
                                c_write0 = 1'b0;
                                c_write1 = 1'b0;
                                m_write = 1'b0;
                                m_read = 1'b0;
                                c_offsetSel = 3'b111;
                                m_addrSel = 1'b0;
                                end
                    default: begin 
                                c_comp0 = 1'b1;
                                c_comp1 = 1'b1;
                                c_write0 = 1'b0;
                                c_write1 = 1'b0;
                                m_write = 1'b0;
                                m_read = 1'b0;
                                c_offsetSel = 3'b111; 
                                m_addrSel = 1'b0;
                                end
                endcase
            end
            default: begin 
                    c_comp0 = 1'b1;
                    c_comp1 = 1'b1;
                    c_write0 = 1'b0;
                    c_write1 = 1'b0;
                    m_write = 1'b0;
                    m_read = 1'b0;
                    c_offsetSel = 3'b111;
                    m_addrSel = 1'b0;
                    end
            endcase
            case (b_trans)
            1'b1: begin newState = 4'b0000; end
            1'b0: case (c_trans)
                    1'b1: begin newState = 4'b0010; end
                    1'b0: case (f_trans)
                            1'b1: begin newState = 4'b0110; end
                            1'b0: begin newState = 4'b0001; end
                            default: begin newState = 4'b0001; end
                            endcase
                    default: begin newState = 4'b0001; end
                    endcase
            default: begin newState = 4'b0001; end
            endcase
        end
        4'b0010: begin // WB WORD 1
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            m_write = 1'b1;
            m_read = 1'b0;
            m_addrSel = 1'b1;
            m_offsetSel = 3'b000;
            c_offsetSel = 3'b000;
            case (e_trans)
            1'b1: begin newState = 4'b0011; end
            1'b0: begin newState = 4'b0010; end
            default: begin newState = 4'b0010; end
            endcase
        end
        4'b0011: begin // WB WORD 2
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            m_write = 1'b1;
            m_read = 1'b0;
            m_addrSel = 1'b1;
            m_offsetSel = 3'b010;
            c_offsetSel = 3'b010;
            case (e_trans)
            1'b1: begin newState = 4'b0100; end
            1'b0: begin newState = 4'b0011; end
            default: begin newState = 4'b0011; end
            endcase
        end
        4'b0100: begin // WB WORD 3
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            m_write = 1'b1;
            m_read = 1'b0;
            m_addrSel = 1'b1;
            m_offsetSel = 3'b100;
            c_offsetSel = 3'b100;
            case (e_trans)
            1'b1: begin newState = 4'b0101; end
            1'b0: begin newState = 4'b0100; end
            default: begin newState = 4'b0100; end
            endcase
        end
        4'b0101: begin // WB WORD 4
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            m_write = 1'b1;
            m_read = 1'b0;
            m_addrSel = 1'b1;
            c_dataInSel = 1'b0;
            m_offsetSel = 3'b110;
            c_offsetSel = 3'b110;
            case (e_trans)
            1'b1: begin newState = 4'b0110; end
            1'b0: begin newState = 4'b0101; end
            default: begin newState = 4'b0101; end
            endcase
        end
        4'b0110: begin // RD WORD 1
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            read_hit_check = 1'b1;
            m_write = 1'b0;
            m_read = 1'b1;
            m_addrSel = 1'b0;
            c_dataInSel = 1'b1;
            m_offsetSel = 3'b000;
            c_offsetSel = 3'b000; // x
            case (e_trans)
            1'b1: begin newState = 4'b0111; end
            1'b0: begin newState = 4'b0110; end
            default: begin newState = 4'b0110; end
            endcase
        end
        4'b0111: begin // RD WORD 2
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            m_write = 1'b0;
            m_read = 1'b1;
            m_addrSel = 1'b0;
            c_dataInSel = 1'b1;
            m_offsetSel = 3'b010;
            c_offsetSel = 3'b000; // x
            case (e_trans)
            1'b1: begin newState = 4'b1000; end
            1'b0: begin newState = 4'b0111; end
            default: begin newState = 4'b0111; end
            endcase
        end
        4'b1000: begin // RD WORD 3
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = !victimSel;
            c_write1 = victimSel;
            m_write = 1'b0;
            m_read = 1'b1;
            m_addrSel = 1'b0;
            c_dataInSel = 1'b1;
            m_offsetSel = 3'b100;
            c_offsetSel = 3'b000;
            case (e_trans)
            1'b1: begin newState = 4'b1001; end
            1'b0: begin newState = 4'b1000; end
            default: begin newState = 4'b1000; end
            endcase
        end
        4'b1001: begin // RD WORD 4
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = !victimSel;
            c_write1 = victimSel;
            m_write = 1'b0;
            m_read = 1'b1;
            m_addrSel = 1'b0;
            c_dataInSel = 1'b1;
            m_offsetSel = 3'b110;
            c_offsetSel = 3'b010;
            case (e_trans)
            1'b1: begin newState = 4'b1010; end
            1'b0: begin newState = 4'b1001; end
            default: begin newState = 4'b1001; end
            endcase
        end
        4'b1010: begin // STALL
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = !victimSel;
            c_write1 = victimSel;
            m_write = 1'b0;
            m_read = 1'b0;
            m_addrSel = 1'b0;
            m_offsetSel = 3'b100;
            c_offsetSel = 3'b100;
            newState = 4'b1011;
        end
        4'b1011: begin // STALL
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = !victimSel;
            c_write1 = victimSel;
            no_hit = 1'b0;
            read_hit_check = 1'b0;
            m_write = 1'b0;
            m_read = 1'b0;
            m_addrSel = 1'b0;
            m_offsetSel = 3'b110;
            c_offsetSel = 3'b110;
            newState = 4'b0001;
        end
        default: begin // IDLE? MAYBE SHOULD BE STALL?
            c_comp0 = 1'b0;
            c_comp1 = 1'b0;
            c_write0 = 1'b0;
            c_write1 = 1'b0;
            read_hit_check = 1'b0;
            m_write = 1'b0;
            m_read = 1'b0;
            m_addrSel = 1'b0;
            c_dataInSel = 1'b0;
            c_offsetSel = 3'b111;
            m_offsetSel = 3'b111;
        end
    endcase


endmodule // cache_controller
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :9:
