class my_sequence_item extends uvm_sequence_item;
  
  `uvm_object_utils(my_sequence_item)
  
  function new(string name = "my_sequence_item");
    super.new(name);
  endfunction
endclass