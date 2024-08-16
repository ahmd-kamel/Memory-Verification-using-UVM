`include "my_if.svh"

module top;
  import uvm_pkg::*;
  import my_pkg::*;
  
  intf in1();
  initial begin
    uvm_config_db#(virtual interface intf) :: set(null, "uvm_test_top", "my_if", in1);
    run_test("my_test");
  end
endmodule