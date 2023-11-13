module apb_slave(clk_i,rst_i,addr_i,wdata_i,valid_i,wr_rd_i,ready_o,rdata_o);
  parameter DEPTH=64;
  parameter WIDTH=16;
  parameter ADDR_WIDTH=8;
 
  input clk_i,rst_i;
  input [ADDR_WIDTH-1:0]addr_i;
  input [WIDTH-1:0]wdata_i;
  input wr_rd_i,valid_i;
  output reg [WIDTH-1:0]rdata_o;
  output reg ready_o;
  
  reg[WIDTH-1:0]mem[DEPTH-1:0];
  
  always@(posedge clk_i)begin
    if(rst_i==1)begin
      rdata_o=0;
      ready_o=0;
      for(integer i=0;i<DEPTH;i=i+1)mem[i]=0;
    end
  else begin
    if(valid_i==1)begin
      ready_o=1;
      if(wr_rd_i==1)mem[addr_i]=wdata_i;
      else rdata_o=mem[addr_i];
      
    end
   else begin
     ready_o=0;
   end
  end
  end
endmodule