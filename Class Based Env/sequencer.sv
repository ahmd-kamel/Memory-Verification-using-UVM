import pack_mem :: *;
class Sequencer #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 4);
  mailbox #(Transaction) trans_mbox;
  Transaction trans;

  function new(mailbox #(Transaction) trans_mbox);
    this.trans_mbox = trans_mbox;
    this.trans = new();
  endfunction

  task run();
    void'(trans.randomize());
    trans.display("Sequencer");
    trans_mbox.put(trans);
    #10;
  endtask
endclass
