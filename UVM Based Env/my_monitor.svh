class my_monitor extends uvm_monitor;
  
  `uvm_component_utils(my_monitor)
  
  virtual intf in1_mont;
  my_sequence_item seqnc_item;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_monitor");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
    if(!uvm_config_db#(virtual intf) :: get(this, "", "moni_vif", in1_mont))
      `uvm_fatal(get_full_name(), "Error!")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_monitor");
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  function new(string name = "my_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass