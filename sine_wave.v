module sine_wave(
  i_clk,
  i_addr,
  o_data
);

  input i_clk;
  input [15:0] i_addr;

  output reg [15:0] o_data;

  wire [13:0] w_saddr_to_lut;
  wire w_neg;
  wire [15:0] w_data;

  sine_addr SINE_ADDR(
    .i_clk(i_clk),
    .i_addr(i_addr),
    .o_addr(w_saddr_to_lut),
    .o_neg(w_neg)
  );

  quad_sine QUAD_SINE(
    .i_clk(i_clk),
    .i_addr(w_saddr_to_lut),
    .o_data(w_data)
  );

  always @ (posedge i_clk)
  begin
    case (w_neg)
      0 : o_data <= w_data;
      default : o_data <= -w_data;
    endcase
  end

endmodule
