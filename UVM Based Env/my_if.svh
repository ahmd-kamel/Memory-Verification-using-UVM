interface intf(input logic clk);
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 4;

  logic [DATA_WIDTH - 1 : 0] data_in;
  logic [DATA_WIDTH - 1 : 0] data_out;
  logic [ADDR_WIDTH - 1 : 0] address;
  logic write_en;
  logic valid_out;
  logic reset_n;
  logic read_en;

  clocking cb @(posedge clk);
    default input #1step output #1step;
    input  data_in;
    input  address;
    input  write_en;
    input  read_en;
    input  reset_n;
    output data_out;
    output valid_out;
  endclocking
endinterface