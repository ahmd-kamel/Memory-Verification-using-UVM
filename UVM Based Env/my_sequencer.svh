class my_sequencer extends uvm_sequencer#(my_sequence_item);
  
  `uvm_component_utils(my_sequencer)

  function new(string name = "my_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_sequencer");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_sequencer");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
endclass