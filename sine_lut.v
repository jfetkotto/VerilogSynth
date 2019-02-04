module sine_lut(
  i_clk,
  i_addr,
  o_data
);

  input i_clk;
  input [15:0] i_addr;
  output reg [15:0] o_data;
  // ROM for LUT, 16x16
  reg [15:0] r_lut [0:(2**16)-1];

  initial begin
    $readmemb("lut_data.mem", r_lut);
  end

  always @ (posedge i_clk)
  begin
    o_data <= r_lut[i_addr];
  end

endmodule
