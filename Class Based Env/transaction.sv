class Transaction #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 4); // done
  rand bit write_en;
  rand bit read_en;
  rand bit reset_n;
  rand bit [ADDR_WIDTH - 1 : 0] address;
  rand bit [DATA_WIDTH - 1 : 0] data_in;
  
  logic [DATA_WIDTH - 1 : 0] data_out;
  logic valid_out;
  
  constraint const_resen_n    {reset_n  dist {0:=10, 1:=90};}
  constraint reset_behavior 
  {
    if (reset_n == 0) 
    {
      write_en == 0;
      read_en == 0;
      address == 0;
      data_in == 0;
    }
  }
  constraint const_address    {address  dist {[0 : 4]:=50, [5 : 10]:=20, [11 : $]:=50};}
  constraint const_data_in    {data_in  dist {[0 : 400]:/50, [401 : 800]:/30, [801 : 1000]:/30,[1001 : $]:/50};}
  constraint const_read_write {{read_en != write_en};}

  task display(string class_name);
    $display("%0s :%0t inputs: reset_n =%0b read_en=%0b write_en=%0d address=%0d data_in=%0d", class_name, $time, reset_n, read_en, write_en, address, data_in);
  endtask
endclass
