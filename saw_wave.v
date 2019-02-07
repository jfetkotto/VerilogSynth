module saw_wave(
  i_clk,
  i_addr,
  o_data
);

  input i_clk;
  input [15:0] i_addr;
  output reg [15:0] o_data;

  reg [15:0] r_delay;

  // Delay by one sample just so it's in phase with other waves
  always @ (posedge i_clk)
  begin
    r_delay <= i_addr;
    o_data <= r_delay;
  end

endmodule
