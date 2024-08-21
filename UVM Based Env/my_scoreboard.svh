class my_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(my_scoreboard)
  
  my_sequence_item seqnc_item;
  uvm_analysis_imp#(my_sequence_item, my_scoreboard) scrbd_analysis_imp;
  
  localparam DATA_WIDTH = 32;    
  localparam ADDR_WIDTH = 4;
  localparam DEPTH = 1 << ADDR_WIDTH;
  logic [DATA_WIDTH - 1 : 0] mem_array [DEPTH];
  
  int total_no_tnxs;
  int total_reset_tnxs;
  int total_write_tnxs;
  int total_read_tnxs;
  int correct_read_tnxs;
  int incorrect_read_tnxs;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_scoreboard");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
    scrbd_analysis_imp = new("scrbd_analysis_imp", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_scoreboard");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  function new(string name = "my_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void write(input my_sequence_item inst);
    
    if(!inst.reset_n) begin
      $display("[SCB-RESET]");
      total_reset_tnxs++;
      foreach(mem_array[i])
        mem_array[i] = 'b0;

      inst.read_en   = 0;
      inst.write_en  = 0;
      inst.valid_out = 0;
    end
    else if(inst.write_en) begin
      total_write_tnxs++;
      mem_array[inst.address] = inst.data_in;
      $display("[SCB-WRITE] Addr = %0d, \t  Data = %0d", inst.address, inst.data_in);
    end
    else if(inst.read_en) begin
      total_read_tnxs++;
      if((mem_array[inst.address] === inst.data_out) && inst.valid_out === 1) begin
        correct_read_tnxs++;
        $display("[SCB-READ-PASS] Addr = %0d, \t  Data :: Expected = %0d Actual = %0d Valid = %0d",inst.address, mem_array[inst.address], inst.data_out, inst.valid_out);
      end
      else begin
        incorrect_read_tnxs++;
        $error("[SCB-READ-FAIL]   Addr = %0d, \t   Data :: Expected = %0d Actual = %0d Valid = %0d",inst.address, mem_array[inst.address], inst.data_out, inst.valid_out);
      end
    end
    total_no_tnxs++;
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("total no of tnx is %d", total_no_tnxs), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total no of reset tnx is %d", total_reset_tnxs), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total no of write tnx is %d", total_write_tnxs), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total no of read tnx is %d", total_read_tnxs), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total no of correct read tnx is %d", correct_read_tnxs), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("total no of incorrect read tnx is %d", incorrect_read_tnxs), UVM_LOW)
  endfunction
endclass