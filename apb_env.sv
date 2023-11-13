class apb_env extends uvm_env;
  apb_agent agent;
  
  `uvm_component_utils(apb_env)
  
      function new (string name="",uvm_component parent=null);
        super.new(name,parent);
      endfunction
      
      function void build_phase (uvm_phase phase);
        $display("apb_env::build_phase");
        agent=new("agent",this);
      endfunction 
  
  /*function void connect_phase (uvm_phase phase);
    $display("apb_env::connect_phase");
       // agent=new("agent",this);
      endfunction */
endclass