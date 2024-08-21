class my_env extends uvm_env;
  
  // registration to the uvm factory
  `uvm_component_utils(my_env)
  
  // defining the inf and componenents inside my_env
  virtual  intf in1_env;
  my_agent 		  agent;
  my_scoreboard scrbrd;
  my_subscriber subscribr;
  
  // first stage in build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_env");
    agent      = my_agent::type_id::create("agent", this);
    scrbrd     = my_scoreboard::type_id::create("scrbrd", this);
    subscribr  = my_subscriber::type_id::create("subscribr", this);
    // get the inf signals from the upper component through config db
    if(!uvm_config_db#(virtual intf) :: get(this, "", "env_vif", in1_env))
      `uvm_fatal(get_full_name(), "Error!")
      // setting the inf instance to the agent in config db
      uvm_config_db#(virtual intf) :: set(this, "agent", "agnt_vif", in1_env);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_env");
    // connecting the analysis port in agent to both the scoreboard and subscriber
    agent.agnt_analysis_port.connect(scrbrd.scrbd_analysis_imp);
    agent.agnt_analysis_port.connect(subscribr.sub_analysis_exp);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  // this is the dummy constractor
  function new(string name = "my_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass