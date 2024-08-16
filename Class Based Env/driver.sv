import pack_mem :: *;
class Driver;
  virtual Intf vif;
  Transaction trans;
  mailbox #(Transaction) trans_mbox;

  function new(virtual Intf vif, mailbox #(Transaction) trans_mbox);
    this.vif = vif;
    this.trans_mbox = trans_mbox;
  endfunction

  task run();
    forever begin
      trans_mbox.get(trans);
      trans.display("Driver");
      @(negedge vif.clk);
      vif.reset_n  <= trans.reset_n;
      vif.read_en  <= trans.read_en;
      vif.write_en <= trans.write_en;
      vif.address  <= trans.address;
      vif.data_in  <= trans.data_in;
      
      //@(vif.cb);
      /*vif.write_en <= 0;
      vif.read_en  <= 0;*/
    end
  endtask
endclass