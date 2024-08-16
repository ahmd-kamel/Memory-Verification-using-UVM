class my_agent extends uvm_agent;
  
  `uvm_component_utils(my_agent)
  
  virtual intf in1_agnt;
  my_driver     driver;
  my_monitor    monitor;
  my_sequencer  seqncr;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_agent");
    seqncr     = my_sequencer::type_id::create("seqncr", this);
    driver     = my_driver::type_id::create("driver", this);
    monitor    = my_monitor::type_id::create("monitor", this);
 
    if(!uvm_config_db#(virtual intf) :: get(this, "", "agnt_vif", in1_agnt))
      `uvm_fatal(get_full_name(), "Error!")
      
    uvm_config_db#(virtual intf) :: set(this, "monitor", "moni_vif", in1_agnt);
    uvm_config_db#(virtual intf) :: set(this, "driver", "driv_vif", in1_agnt);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_agent");
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  function new(string name = "my_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass