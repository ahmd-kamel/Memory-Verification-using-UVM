class my_sequence_item extends uvm_sequence_item;
  parameter DATA_WIDTH = 32, ADDR_WIDTH = 4;
  
  `uvm_object_utils(my_sequence_item)
  
  rand bit write_en;
  rand bit read_en;
  rand bit reset_n;
  randc bit [ADDR_WIDTH - 1 : 0] address;
  rand bit [DATA_WIDTH - 1 : 0] data_in;
  
  logic [DATA_WIDTH - 1 : 0] data_out;
  logic valid_out;

  function new(string name = "my_sequence_item");
    super.new(name);
  endfunction

  constraint reset_behavior 
  {
    if (reset_n == 0) 
    {
      address == 0;
      data_in == 0;
    }
  }
  constraint const_address    {address  inside {[0:15]};}
  constraint const_data_in    {data_in  dist {[0 : 400]:/50, [401 : 800]:/30, [801 : 1000]:/30,[1001 : $]:/50};}
  constraint const_read_write {{read_en != write_en};}

  task displaySQ(string class_name);
    $display("%0s :%0t inputs: reset_n =%0b read_en=%0b write_en=%0d address=%0d data_in=%0d", class_name, $time, reset_n, read_en, write_en, address, data_in);
  endtask
endclass