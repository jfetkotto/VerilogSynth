/*
* TITLE: s16_to_u16.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Convert from 2s comp to unsigned binary
*/

module s16_to_u16(
  i_clk,
  i_s16,
  o_u16
);

  input i_clk;
  input signed [15:0] i_s16;
  output reg [15:0] o_u16;

  always @ (posedge i_clk) begin
    o_u16 <= i_s16 + 16'd32767;
  end

endmodule
