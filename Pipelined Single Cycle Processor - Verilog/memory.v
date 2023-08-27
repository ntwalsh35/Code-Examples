/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (
   // output
   dReadData, err, hit,
   // input
   aluResult, writeData, createDump, memRead, memWrite, clk, rst
   );

   // output signals
   output wire [15:0] dReadData;
   output wire err, hit;

   // input signals
   input wire [15:0] aluResult, writeData;
   input wire clk, rst;
   
   //control signals
   input wire createDump, memRead, memWrite;
   wire done, stall, mem_err;

   assign err = mem_err & (memRead | memWrite);

   // modules
   //data_mem dataMemory(dReadData, aluResult, writeData, memRead, memWrite, createDump, clk, rst);
   data_mem_system dataMem(.DataOut(dReadData), .Done(done), .Stall(stall), .CacheHit(hit), .err(mem_err), .Addr(aluResult), .DataIn(writeData), .Rd(memRead), .Wr(memWrite), .createdump(createDump), .clk(clk), .rst(rst));

endmodule
`default_nettype wire
