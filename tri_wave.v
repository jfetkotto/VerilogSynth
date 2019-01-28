/*
* TITLE: tri_wave.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Output triangular wave based on ramp input
*/

module tri_wave(
  i_clk,
  i_addr,
  o_data
);

  input i_clk;
  input [15:0] i_addr;
  output reg signed [15:0] o_data;

  always @ (posedge i_clk) begin
    if (i_addr < 32768) begin
      o_data <= (2*i_addr)-32767;
    end else begin
      o_data <= 65536 - ((2*i_addr) - 32767);
    end
  end

endmodule
