module wave_mux(
  i_sel,
  i_sine,
  i_square,
  i_tri,
  i_noise,
  o_data
);

  input [1:0] i_sel;
  input [15:0] i_sine;
  input [15:0] i_square;
  input [15:0] i_tri;
  input [15:0] i_noise;

  output reg [15:0] o_data;

  always @ (i_sel, i_sine, i_square, i_tri, i_noise)
  begin
    case (i_sel)
      2'b00 : o_data <= i_noise;
      2'b01 : o_data <= i_tri;
      2'b10 : o_data <= i_square;
      default : o_data <= i_sine;
    endcase
  end

endmodule


