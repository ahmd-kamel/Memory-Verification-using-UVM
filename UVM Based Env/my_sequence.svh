class my_sequence extends uvm_sequence;
  
  `uvm_object_utils(my_sequence)

  function new(string name = "my_sequence");
    super.new(name);
  endfunction
endclass

class reset_sequence extends my_sequence;

  `uvm_object_utils(reset_sequence)        
  my_sequence_item txn;
  
  function new(string name="reset_sequence");
      super.new(name);
  endfunction
  
  task body();
    txn = my_sequence_item :: type_id :: create("txn");
    start_item(txn);
    assert (txn.randomize() with {reset_n == 0;})
      else 
        $error("randomiztion failed");
    finish_item(txn);
  endtask
  
endclass

class read_sequence extends my_sequence;

    `uvm_object_utils(read_sequence)
    my_sequence_item tnx;
    
  	integer num_transactions = 500;
  
    task gen_tnx();
      tnx = my_sequence_item :: type_id :: create("tnx");
      start_item(tnx);
      assert (tnx.randomize() with {reset_n == 1; write_en == 0; read_en == 1;})
        else 
          $error("randomiztion failed");
      finish_item(tnx);
    endtask
  
    virtual task body();
      repeat(num_transactions)
        gen_tnx();
    endtask

  function new (string name = "read_sequence");
      super.new(name);
  endfunction
endclass

class write_sequence extends my_sequence;

    `uvm_object_utils(write_sequence)
    my_sequence_item tnx;
    
  	integer num_transactions = 1000;
  
    task gen_tnx();
      tnx = my_sequence_item :: type_id :: create("tnx");
      start_item(tnx);
      assert (tnx.randomize() with {reset_n == 1; write_en == 1; read_en == 0;})
        else 
          $error("randomiztion failed");
      finish_item(tnx);
    endtask
  
    virtual task body();
      repeat(num_transactions)
        gen_tnx();
    endtask

  function new (string name = "write_sequence");
      super.new(name);
  endfunction
endclass

class write_read_sequence extends my_sequence;

    `uvm_object_utils(write_read_sequence)
    my_sequence_item tnx;
    
  	integer num_transactions = 8000;
    integer i;
  
    task gen_write_tnx();
      tnx = my_sequence_item :: type_id :: create("tnx");
      start_item(tnx);
      assert (tnx.randomize() with {reset_n == 1; write_en == 1; read_en == 0;})
        else 
          $error("randomiztion failed");
      finish_item(tnx);
    endtask
  
    task gen_read_tnx();
      tnx = my_sequence_item :: type_id :: create("tnx");
      start_item(tnx);
      assert (tnx.randomize() with {reset_n == 1; write_en == 0; read_en == 1;})
        else 
          $error("randomiztion failed");
      finish_item(tnx);
    endtask
  
    virtual task body();
      for(i = 0; i < num_transactions; i = i + 1) begin
        if(i % 2 != 0) begin
          gen_write_tnx();
        end
 		else begin
          gen_read_tnx();
          end
      end
    endtask

  function new (string name = "write_read_sequence");
      super.new(name);
  endfunction
endclass

