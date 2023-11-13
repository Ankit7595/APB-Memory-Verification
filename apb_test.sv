 class apb_test extends uvm_test;
   apb_env env;
    `uvm_component_utils (apb_test)
    
    function new (string name ="",uvm_component parent =null);
      super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      $display("apb_test::build_phase");
      env=new("env",this);
    endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_seq seq;
    seq=apb_seq::type_id::create("seq");
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    seq.start(env.agent.sqr);
    phase.drop_objection(this);
  endtask
 endclass