class my_driver extends uvm_driver#(my_sequence_item);
  
  `uvm_component_utils(my_driver)
  
  virtual intf in1_drvr;
  my_sequence_item seqnc_item;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_driver");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
    if(!uvm_config_db#(virtual intf) :: get(this, "", "driv_vif", in1_drvr))
      `uvm_fatal(get_full_name(), "Error!")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_driver");
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  function new(string name = "my_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass
