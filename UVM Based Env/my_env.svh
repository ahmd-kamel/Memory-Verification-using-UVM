class my_env extends uvm_env;
  
  `uvm_component_utils(my_env)
  
  virtual  intf in1_env;
  my_agent 		agent;
  my_scoreboard scrbrd;
  my_subscriber subscribr;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_env");
    agent      = my_agent::type_id::create("agent", this);
    scrbrd     = my_scoreboard::type_id::create("scrbrd", this);
    subscribr  = my_subscriber::type_id::create("subscribr", this);
    if(!uvm_config_db#(virtual intf) :: get(this, "", "env_vif", in1_env))
      `uvm_fatal(get_full_name(), "Error!")
      uvm_config_db#(virtual intf) :: set(this, "agent", "agnt_vif", in1_env);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_env");
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  function new(string name = "my_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass