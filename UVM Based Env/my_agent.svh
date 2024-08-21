class my_agent extends uvm_agent;
  
  // registration to the uvm factory
  `uvm_component_utils(my_agent)
  
  // defining the inf and componenents inside my_agent
  virtual intf  in1_agnt;
  my_driver     driver;
  my_monitor    monitor;
  my_sequencer  seqncr;
  uvm_analysis_port#(my_sequence_item) agnt_analysis_port;
  
  // this is the dummy constractor
  function new(string name = "my_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_agent");
    seqncr  = my_sequencer::type_id::create("seqncr", this);
    driver  = my_driver::type_id::create("driver", this);
    monitor = my_monitor::type_id::create("monitor", this);
    agnt_analysis_port = new("agnt_analysis_port", this);
    
    if(!uvm_config_db#(virtual intf) :: get(this, "", "agnt_vif", in1_agnt))
      `uvm_fatal(get_full_name(), "Error!")
      
    uvm_config_db#(virtual intf) :: set(this, "monitor", "moni_vif", in1_agnt);
    uvm_config_db#(virtual intf) :: set(this, "driver", "driv_vif", in1_agnt);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_agent");
    driver.seq_item_port.connect(seqncr.seq_item_export);
    monitor.mon_analysis_port.connect(this.agnt_analysis_port);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
endclass