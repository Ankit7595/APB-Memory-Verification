class apb_drv extends uvm_driver#(apb_tx);
virtual apb_intf vif;
  
  `uvm_component_utils(apb_drv)
  
      function new (string name="",uvm_component parent=null);
        super.new(name,parent);
      endfunction
      
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("apb_drv::build_phase");
        vif=top.apb_pif;
      endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      req.print();
      drive_tx(req);
      seq_item_port.item_done();
    end
  endtask
  
  task drive_tx(apb_tx tx);
    begin
      @(vif.clk_i);
      vif.addr_i<=tx.addr;
      vif.wr_rd_i<=tx.wr_rd;
      
      if(tx.wr_rd==1)vif.wdata_i<=tx.data;
      vif.valid_i<=1;
      wait(vif.ready_o==1);
      reset_inputs();
    end
    endtask
      
      task reset_inputs();
        begin
          vif.addr_i<=0;
          vif.wr_rd_i<=0;
          vif.wdata_i<=0;
          vif.valid_i<=0;
        end
      endtask
 endclass