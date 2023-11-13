class apb_mon extends uvm_monitor;
  
apb_tx tx;
virtual apb_intf vif;
  
uvm_analysis_port#(apb_tx)ap_port;// In place of mail box
  `uvm_component_utils(apb_mon)
  
  
  function new(string name="",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_port=new("ap_port",this);
   // vif=top.apb_pif;
    uvm_resource_db#(virtual apb_intf)::read_by_name("GLOBAL","VIF",vif,this);
  endfunction
  
  task run_phase(uvm_phase phase);
    //vif=top.apb_pif;
    
    forever begin
      @(posedge vif.clk_i);
      if(vif.valid_i==1 && vif.ready_o==1)begin
        tx=new();
        tx.addr=vif.addr_i;
        tx.wr_rd=vif.wr_rd_i;
        tx.data=vif.wr_rd_i?vif.wdata_i:vif.rdata_o;
        //tx.wr_rd=vif.wr_rd_i;
        ap_port.write(tx);
      end
    end
  endtask
  
endclass
  