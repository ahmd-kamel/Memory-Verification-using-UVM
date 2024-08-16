module top;
  int x;
  integer y;
  
  bit clk;
  always #5 clk = ~clk;
  
  covergroup group_1(ref int x, ref integer y)@(negedge clk);
    coverpoint x
    {
      bins bin_1   = {1, 2, [19:22]};
      bins bin_2[] = {7, 10};
      bins bin_3[] = {24, 32, 38, 46};
      bins bin_4[] = default;
    }
    
    coverpoint y
    {
      option.auto_bin_max =  64;
      bins bin_5[64] = {[1:$]}; // take care of memory overflow
      bins bin_6   = (2=>3);
      bins bin_7[] = (1,2=>4,5);
      bins bin_8   = (7[*3] => 8);
    }
    
    cross x,y
    {
        bins xy_bin_1 = (binsof(x) intersect {1} && binsof(y) intersect {2}) || (binsof(x) intersect {3} && binsof(y) intersect {6});
        bins xy_bin_2 = binsof(x) intersect {2, 7, 10} && binsof(y) intersect {[7:10]};
    }
    
  endgroup
  
  group_1 inst = new(x, y);
  
  always@(negedge clk) begin
    x = $urandom($time);
    y = $urandom($time);
  end
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    #100000;
    $stop;
  end
  
  
endmodule