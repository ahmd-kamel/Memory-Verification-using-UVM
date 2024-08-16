import pack_mem :: *;
module top; 
  // Clock generation
  bit clk, reset_n;
  always #5 clk = ~clk; // resetting and clocking mechanism ?
  
  Intf mem_intf(clk);

  Memory #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(4)
  ) memory_instance (
    .inst(mem_intf)
  );

  Env env_inst = new(mem_intf);

  parameter T = 10;
  parameter N = 30;
  
  
  initial begin
    env_inst.run(N);
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #(N*T);
    $finish;
  end
  
endmodule