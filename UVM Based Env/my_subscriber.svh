class my_subscriber extends uvm_subscriber#(my_sequence_item);
  
  `uvm_component_utils(my_subscriber)
  
  my_sequence_item seqnc_item;
  uvm_analysis_imp#(my_sequence_item, my_subscriber) sub_analysis_exp;
  real cov;

  covergroup mem_cov;
    reset: coverpoint seqnc_item.reset_n
    {
      bins low   = {0};
      bins high  = {1};
      bins trans_1 = (0=>1);
      bins trans_2 = (1=>0);
    }
    read: coverpoint seqnc_item.read_en
    {
      bins high  = {1};
      bins low   = {0};
      bins trans_1 = (0=>1);
      bins trans_2 = (1=>0);
    }
    write: coverpoint seqnc_item.write_en
    {
      bins write = {1};
      bins read  = {0};
      bins trans_1 = (0=>1);
      bins trans_2 = (1=>0);
    }
    address: coverpoint seqnc_item.address
    {
      bins address[] = {[0:15]}; // take care here from mem depth
    }
    data_in: coverpoint seqnc_item.data_in
    {
      option.auto_bin_max = 100;
    }
    data_out: coverpoint seqnc_item.data_out
    {
      option.auto_bin_max = 100;
    }
    valid_out: coverpoint seqnc_item.valid_out;
  endgroup

  function new(string name = "my_subscriber", uvm_component parent = null);
    super.new(name, parent);
    mem_cov = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_subscriber");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
    sub_analysis_exp = new("sub_analysis_exp", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_subscriber");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  virtual function void write(my_sequence_item t);
    seqnc_item = t;
    mem_cov.sample();
  endfunction
  
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov = mem_cov.get_coverage();
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f", cov), UVM_LOW)
  endfunction
endclass