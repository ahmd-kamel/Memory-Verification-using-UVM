import pack_mem :: *;
class Scoreboard#(int DATA_WIDTH = 32, ADDR_WIDTH = 4);
  mailbox #(Transaction) mon_scb_mbox;
  Transaction trans;
  int no_trans;
  
  parameter mem_depth = ADDR_WIDTH ** 2;
  logic [DATA_WIDTH - 1 : 0] mem_array [mem_depth];
  
  function new(mailbox #(Transaction) mon_scb_mbox);
    this.mon_scb_mbox = mon_scb_mbox;
  endfunction

  task run();
    forever begin
      mon_scb_mbox.get(trans);
      trans.display("Scoreboard");
      if(!trans.reset_n) begin
        $display("[SCB-RESET]");
        foreach(mem_array[i])
          mem_array[i] = 'b0;
        
        trans.read_en   = 0;
        trans.write_en  = 0;
        trans.valid_out = 0;
      end
      else if(trans.write_en) begin
        mem_array[trans.address] = trans.data_in;
        $display("[SCB-WRITE] Addr = %0d, \t  Data = %0d", trans.address, trans.data_in);
      end
      else if(trans.read_en) begin
        if((mem_array[trans.address] !== trans.data_out) && trans.valid_out !== 1) begin
          $error("[SCB-READ-FAIL]   Addr = %0d, \t   Data :: Expected = %0d Actual = %0d Valid = %0d",trans.address, mem_array[trans.address], trans.data_out, trans.valid_out);
        end
        else begin
          $display("[SCB-READ-PASS] Addr = %0d, \t  Data :: Expected = %0d Actual = %0d Valid = %0d",trans.address, mem_array[trans.address], trans.data_out, trans.valid_out);
        end
      end
      no_trans++;
    end
  endtask
endclass