import pack_mem :: *;
class Subscriber#(int DATA_WIDTH = 32, ADDR_WIDTH = 4);
  mailbox #(Transaction) mon_sub_mbox;
  Transaction trans;

  covergroup mem_cov;
    reset: coverpoint trans.reset_n{
      bins low   = {0};
      bins high  = {1};
      bins trans = (0=>1);
    }
    read: coverpoint trans.read_en{
      bins high  = {1};
      bins low   = {0};
    }
    write: coverpoint trans.write_en{
      bins write = {1};
      bins read  = {0};
    }
    address: coverpoint trans.address{
        bins address[] = {[0:2**ADDR_WIDTH - 1]};
    }
    data_in: coverpoint trans.data_in{
      bins data_in1 = {[0:400]};
      bins data_in2 = {[401:800]};
      bins data_in3 = {[1000:$]};
    }
    data_out: coverpoint trans.data_out{
      bins data_out1 = {[0:400]};
      bins data_out2 = {[401:800]};
      bins data_out3 = {[1000:$]};
    }
    valid_out: coverpoint trans.valid_out;
    cross1 :cross address, data_in;
  endgroup

  function new(mailbox #(Transaction) mon_sub_mbox);
    this.mon_sub_mbox = mon_sub_mbox;
    mem_cov = new();
  endfunction

  task run();
    forever begin
      mon_sub_mbox.get(trans);
      mem_cov.sample();
    end
  endtask
endclass