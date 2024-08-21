module Memory
#(parameter DATA_WIDTH = 32,
            ADDR_WIDTH = 4
 )(intf inst);

  localparam mem_depth = 1 << ADDR_WIDTH;
  logic [DATA_WIDTH - 1 : 0] mem_array [mem_depth];

  always @(posedge inst.clk or negedge inst.reset_n) begin
    if (!inst.reset_n) begin
      integer i;
      for (i = 0; i < mem_depth; i = i + 1) begin
        mem_array[i] <= 0;
      end
      inst.valid_out <= 0;
      inst.data_out  <= 0;
    end else begin
      if (inst.write_en && !inst.read_en) begin
        mem_array[inst.address] <= inst.data_in;
        inst.valid_out <= 0;
      end else if(inst.read_en && !inst.write_en) begin
        inst.data_out <= mem_array[inst.address];
        inst.valid_out <= 1;
      end else begin
        inst.valid_out <= 0;
        inst.data_out <= 'bx;
      end
    end
  end
endmodule