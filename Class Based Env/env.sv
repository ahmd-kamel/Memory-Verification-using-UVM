import pack_mem :: *;
class Env;
  Driver driver_inst;
  Sequencer #(32, 4) seqncr_inst;
  Monitor monitr_inst;
  Scoreboard scbrd_inst;
  Subscriber subs_inst;
  
  mailbox #(Transaction) tr_mbox;
  mailbox #(Transaction) mon_sub_mbox;
  mailbox #(Transaction) mon_scb_mbox;

  function new(virtual Intf vif);
    tr_mbox  = new();
    mon_sub_mbox = new();
    mon_scb_mbox = new();
    
    seqncr_inst = new(tr_mbox);
    driver_inst = new(vif, tr_mbox);
    scbrd_inst  = new(mon_scb_mbox);
    subs_inst   = new(mon_sub_mbox);
    monitr_inst = new(vif, mon_sub_mbox, mon_scb_mbox);
  endfunction

  task run(int num);
    fork
      repeat(num) begin
        seqncr_inst.run();
      end
      driver_inst.run();
      monitr_inst.run();
      scbrd_inst.run();
      //subs_inst.run();
    join_none
  endtask
  
endclass