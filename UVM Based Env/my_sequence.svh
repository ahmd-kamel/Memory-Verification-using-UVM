class my_sequence extends uvm_sequence;
  
  `uvm_object_utils(my_sequence)

  function new(string name = "my_sequence");
    super.new(name);
  endfunction
endclass