interface apb_intf(input bit clk_i,rst_i);
  bit [`ADDR_WIDTH-1:0]addr_i;
  bit[`WIDTH-1:0]wdata_i;
  bit[`WIDTH-1:0]rdata_o;
  bit wr_rd_i,valid_i;
  bit ready_o;
endinterface