class my_test extends uvm_test;
  
  `uvm_component_utils(my_test)
  
  virtual intf in1_test;
  my_env env;
  reset_sequence rst_seq;
  write_sequence write_seq;
  read_sequence  read_seq;
  write_read_sequence wr_rd_seq;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("this is build my_test");
    env = my_env :: type_id :: create("env", this);
    if(!uvm_config_db#(virtual intf) :: get(this, "", "my_if", in1_test))
      `uvm_fatal(get_full_name(), "Error!")
      uvm_config_db#(virtual intf) :: set(this, "env", "env_vif", in1_test);
    
    rst_seq   = reset_sequence :: type_id :: create("rst_seq");
    write_seq = write_sequence :: type_id :: create("write_seq");
    read_seq  = read_sequence  :: type_id :: create("read_seq");
    wr_rd_seq = write_read_sequence :: type_id :: create("wr_rd_seq");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("this is connect my_test");
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    rst_seq.start(env.agent.seqncr);
    #100;
    read_seq.start(env.agent.seqncr);
    #100;
    write_seq.start(env.agent.seqncr);
    #100;
    read_seq.start(env.agent.seqncr);
    #100;
    wr_rd_seq.start(env.agent.seqncr);
    #100;
    rst_seq.start(env.agent.seqncr);
    #100;
    phase.drop_objection(this);
  endtask
  
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass