import pack_mem :: *;
class Monitor;
  virtual Intf vif;
  mailbox #(Transaction) mon_sub_mbox;
  mailbox #(Transaction) mon_scb_mbox;
  Transaction trans;

  function new(virtual Intf vif, mailbox #(Transaction) mon_sub_mbox, mon_scb_mbox);
    this.trans = new();
    this.vif = vif;
    this.mon_sub_mbox = mon_sub_mbox;
    this.mon_scb_mbox = mon_scb_mbox;
  endfunction

  task run();
    #10;
    forever begin
      //wait(vif.read_en || vif.write_en)
      @(vif.cb);
      trans.address   = vif.address;
      trans.write_en  = vif.write_en;
      trans.read_en   = vif.read_en;
      trans.data_in   = vif.data_in;
      trans.reset_n   = vif.reset_n;
      //if(vif.read_en) begin
       // @(negedge vif.clk);
      trans.data_out  = vif.data_out;
      trans.valid_out = vif.valid_out;
      //end
      trans.display("Monitor");
      mon_sub_mbox.put(trans);
      mon_scb_mbox.put(trans);
      //@(posedge vif.clk);
      //#10;
    end
  endtask
endclass