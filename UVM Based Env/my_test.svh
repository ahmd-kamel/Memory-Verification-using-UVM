class my_test extends uvm_test;
  
  `uvm_component_utils(my_test)
  
  virtual intf in1_test;
  my_env env;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_test");
    env = my_env :: type_id :: create("env", this);
    if(!uvm_config_db#(virtual intf) :: get(this, "", "my_if", in1_test))
      `uvm_fatal(get_full_name(), "Error!")
      uvm_config_db#(virtual intf) :: set(this, "env", "env_vif", in1_test);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_test");
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass