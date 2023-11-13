class apb_agent extends uvm_agent;
  apb_sqr sqr;
  apb_drv drv;
  apb_cov cov;
  apb_mon mon;
  
  `uvm_component_utils(apb_agent)
  
   function new (string name="",uvm_component parent=null);
        super.new(name,parent);
     endfunction
      
  
  
  function void build_phase (uvm_phase phase);
    $display("apb_agent::build_phase");
    sqr=new("sqr",this);
    drv=new("drv",this);
    cov=new("cov",this);
    mon=new("mon",this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    $display("apb_agent::connect_phase");
    drv.seq_item_port.connect(sqr.seq_item_export);
   // mon.ap_port.connect(cov.analysis_export);
    mon.ap_port.connect(cov.analysis_export);
  endfunction
  
endclass