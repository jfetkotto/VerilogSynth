module wave_mux(
  input [2:0] i_sel,
  input [15:0] i_sine,
  input [15:0] i_saw,
  input [15:0] i_square,
  input [15:0] i_tri,
  input [15:0] i_noise,
  output reg [15:0] o_data
);

  always @ (i_sel, i_sine, i_square, i_saw, i_tri, i_noise)
  begin
    case (i_sel)
      3'b000 : o_data <= i_noise;
      3'b001 : o_data <= i_tri;
      3'b010 : o_data <= i_saw;
      3'b011 : o_data <= i_square;
      default : o_data <= i_sine;
    endcase
  end

endmodule


