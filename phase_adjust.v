module phase_adjust(
  input i_clk,
  input [15:0] i_addr,
  input [15:0] i_adjust, 
  output reg [15:0] o_addr
);

  reg [16:0] r_temp;

  always @(posedge i_clk)
  begin
    r_temp <= (i_addr + i_adjust);
    o_addr <= r_temp[15:0];
  end

endmodule
