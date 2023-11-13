`define ADDR_WIDTH 8
`define WIDTH 16
 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_tx.sv"
`include "apb_seq.sv"
`include "apb_intf.sv"
`include "apb_mon.sv"
`include "apb_cov.sv"
`include "apb_drv.sv"
`include "apb_sqr.sv"
`include "apb_agent.sv"
`include "apb_env.sv"
`include "apb_test.sv"


module top;
  reg clk_i,rst_i;
  apb_intf apb_pif(clk_i,rst_i);
  
  initial begin
    clk_i=0;
    forever #5 clk_i=~clk_i;
  end
  
  initial begin
    uvm_resource_db#(virtual apb_intf)::set("GLOBAL","VIF",apb_pif,null);
    rst_i=1;
    #20;
    rst_i=0;
  end
  
  apb_slave dut (
    .clk_i(apb_pif.clk_i),
    .rst_i(apb_pif.rst_i),
    .addr_i(apb_pif.addr_i),
    .wdata_i(apb_pif.wdata_i),
    .valid_i(apb_pif.valid_i),
    .wr_rd_i(apb_pif.wr_rd_i),
    .ready_o(apb_pif.ready_o),
    .rdata_o(apb_pif.rdata_o));
    
  
  initial begin
    run_test("apb_test");
  end
  
  initial begin
    $dumpvars();
    $dumpfile("1.vcd");
  end
endmodule

