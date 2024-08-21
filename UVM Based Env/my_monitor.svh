class my_monitor extends uvm_monitor;
  
  `uvm_component_utils(my_monitor)
  
  virtual intf in1_mont;
  my_sequence_item seqnc_item;
  uvm_analysis_port#(my_sequence_item) mon_analysis_port;

  function new(string name = "my_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_monitor");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
    if(!uvm_config_db#(virtual intf) :: get(this, "", "moni_vif", in1_mont))
      `uvm_fatal(get_full_name(), "Error!")
    mon_analysis_port = new("mon_analysis_port", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_monitor");
  endfunction
  
  task run_phase(uvm_phase phase);
    #10;
    forever begin
      @(in1_mont.cb);
      seqnc_item.address   = in1_mont.address;
      seqnc_item.write_en  = in1_mont.write_en;
      seqnc_item.read_en   = in1_mont.read_en;
      seqnc_item.data_in   = in1_mont.data_in;
      seqnc_item.reset_n   = in1_mont.reset_n;
      seqnc_item.data_out  = in1_mont.data_out;
      seqnc_item.valid_out = in1_mont.valid_out;

      mon_analysis_port.write(seqnc_item);
    end
  endtask
endclass