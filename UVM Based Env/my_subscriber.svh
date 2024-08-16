class my_subscriber extends uvm_subscriber#(my_sequence_item);
  
  `uvm_component_utils(my_subscriber)
  
  my_sequence_item seqnc_item;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_subscriber");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_subscriber");
  endfunction
  
  task run_phase(uvm_phase phase);
    
  endtask
  
  function new(string name = "my_subscriber", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void write(my_sequence_item t);
  endfunction
  
endclass