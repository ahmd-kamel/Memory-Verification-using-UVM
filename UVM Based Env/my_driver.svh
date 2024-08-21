class my_driver extends uvm_driver#(my_sequence_item);

  // registration to the uvm factory
  `uvm_component_utils(my_driver)

  // defining the inf and tnx inside my_driver
  virtual intf in1_drvr;
  my_sequence_item seqnc_item;

  // this is the dummy constractor
  function new(string name = "my_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_driver");
    seqnc_item = my_sequence_item :: type_id :: create("seqnc_item");
    if(!uvm_config_db#(virtual intf) :: get(this, "", "driv_vif", in1_drvr))
      `uvm_fatal(get_full_name(), "Error!")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_driver");
  endfunction
  
  task map_signals(input my_sequence_item inst);
    @(negedge in1_drvr.clk);
    in1_drvr.reset_n  <= inst.reset_n;
    in1_drvr.read_en  <= inst.read_en;
    in1_drvr.write_en <= inst.write_en;
    in1_drvr.address  <= inst.address;
    in1_drvr.data_in  <= inst.data_in;
  endtask

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(seqnc_item);
      map_signals(seqnc_item);
      seq_item_port.item_done(seqnc_item);
    end
  endtask
endclass
