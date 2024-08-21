`include "my_if.svh"
`include "memory.sv"

module top;
import uvm_pkg::*;
import my_pkg::*;

  bit clk, reset_n;
  always #5 clk = ~clk; // resetting and clocking mechanism ?
  
  intf in1(clk);

  Memory #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(4)
  ) memory_instance (
    .inst(in1)
  );

  initial begin
    uvm_config_db#(virtual intf) :: set(null, "uvm_test_top", "my_if", in1);
    run_test("my_test");
  end
endmodule