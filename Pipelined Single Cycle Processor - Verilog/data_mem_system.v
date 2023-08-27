/* $Author: karu $ */
/* $LastChangedDate: 2009-04-24 09:28:13 -0500 (Fri, 24 Apr 2009) $ */
/* $Rev: 77 $ */

/******************************************************

ASSOC
*/

`default_nettype none
module data_mem_system(/*AUTOARG*/
   // Outputs
   DataOut, Done, Stall, CacheHit, err,
   // Inputs
   Addr, DataIn, Rd, Wr, createdump, clk, rst
   );
   
   input wire [15:0] Addr;
   input wire [15:0] DataIn;
   input wire        Rd;
   input wire        Wr;
   input wire        createdump;
   input wire        clk;
   input wire        rst;
   
   output wire [15:0] DataOut;
   output wire       Done;
   output wire       Stall;
   output wire       CacheHit;
   output wire        err;

   // internal signals
   wire [2:0] c_offset, c_offsetSel;
   wire [2:0] m_offset, m_offsetSel;
   wire [15:0] offsetAddr, tagOffsetAddr, memAddrInput, c_dataOut0, c_dataOut1;
   wire [15:0] c_dataIn, m_dataOut, m_dataIn;
   wire c_dataInSel, m_addrSel;
   wire [4:0] tag_out0, tag_out1, tag_out_both;
   wire c_err0, c_err1, m_err;
   wire m_wr, m_rd, m_stall;
   wire [3:0] m_busy;
   wire c_en;
   wire c_hit0, c_dirty0, c_valid0, c_comp0, c_write0, c_validIn, no_hit;
   wire c_hit1, c_dirty1, c_valid1, c_comp1, c_write1;

   // new control signals
   wire victimSel;

   assign DataOut = (c_hit1 & c_valid1) ? c_dataOut1 : c_dataOut0;
   assign m_dataIn = victimSel ? c_dataOut1 : c_dataOut0;
   assign tag_out_both = victimSel ? tag_out1 : tag_out0;

   assign c_offset = (&c_offsetSel) ? Addr[2:0] : c_offsetSel;
   assign m_offset = (&m_offsetSel) ? Addr[2:0] : m_offsetSel;
   assign offsetAddr = {Addr[15:3], m_offset[2:0]};
   assign tagOffsetAddr = { tag_out_both[4:0] , Addr[10:3], m_offset[2:0]};
   assign memAddrInput = m_addrSel ? tagOffsetAddr : offsetAddr;
   assign err = c_err0 | c_err1 | m_err;
   assign c_dataIn = c_dataInSel ? m_dataOut : DataIn;
   assign c_en = Wr ^ Rd;
   assign c_validIn = 1'b1;

   assign CacheHit = ((c_hit0 & c_valid0) | (c_hit1 & c_valid1)) & ~no_hit; // could maybe do  ... & (Wr ^ RD)

   cache_controller cache_control(
    // Outputs 
    .c_comp0(c_comp0), 
    .c_comp1(c_comp1), 
    .c_write0(c_write0), 
    .c_write1(c_write1), 
    .c_offsetSel(c_offsetSel), 
    .victimSel(victimSel),
    .m_offsetSel(m_offsetSel), 
    .m_write(m_wr), 
    .m_read(m_rd), 
    .m_addrSel(m_addrSel), 
    .c_dataInSel(c_dataInSel), 
    .control_stall(Stall), 
    .control_done(Done), 
    .no_hit(no_hit),
   // Inputs 
    .memWrite(Wr), 
    .memRead(Rd), 
    .c_hit0(c_hit0), 
    .c_hit1(c_hit1),
    .c_dirty0(c_dirty0), 
    .c_dirty1(c_dirty1), 
    .c_valid0(c_valid0), 
    .c_valid1(c_valid1), 
    .m_stall(m_stall), 
    .m_busy(m_busy), 
    .clk(clk), 
    .rst(rst)
    );



   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter memtype = 1;
   cache #(0 + memtype) c0(// Outputs
                          .tag_out              (tag_out0),
                          .data_out             (c_dataOut0),
                          .hit                  (c_hit0),
                          .dirty                (c_dirty0),
                          .valid                (c_valid0),
                          .err                  (c_err0),
                          // Inputs
                          .enable               (c_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (Addr[15:11]),
                          .index                (Addr[10:3]),
                          .offset               (c_offset),
                          .data_in              (c_dataIn),
                          .comp                 (c_comp0),
                          .write                (c_write0),
                          .valid_in             (c_validIn));
   cache #(2 + memtype) c1(// Outputs
                          .tag_out              (tag_out1),
                          .data_out             (c_dataOut1),
                          .hit                  (c_hit1),
                          .dirty                (c_dirty1),
                          .valid                (c_valid1),
                          .err                  (c_err1),
                          // Inputs
                          .enable               (c_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (Addr[15:11]),
                          .index                (Addr[10:3]),
                          .offset               (c_offset),
                          .data_in              (c_dataIn),
                          .comp                 (c_comp1),
                          .write                (c_write1),
                          .valid_in             (c_validIn));

   four_bank_mem mem(// Outputs
                     .data_out          (m_dataOut),
                     .stall             (m_stall),
                     .busy              (m_busy),
                     .err               (m_err),
                     // Inputs
                     .clk               (clk),
                     .rst               (rst),
                     .createdump        (createdump),
                     .addr              (memAddrInput),
                     .data_in           (m_dataIn),
                     .wr                (m_wr),
                     .rd                (m_rd));
   
   // your code here

   
endmodule // mem_system
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :9:
