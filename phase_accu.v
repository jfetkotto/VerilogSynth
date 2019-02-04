/*
* TITLE: phase_accu.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: linear ramp from 0 to (2^32)-1
*/

module phase_accu(
  i_clk5MHz,
  i_fcw,
  o_16bit_addr
);

  input i_clk5MHz;
  input [23:0] i_fcw;
  output [15:0] o_16bit_addr;

  reg [23:0] r_fcw = 24'h000001;
  reg [31:0] r_count = 32'h00000000;

  assign o_16bit_addr = r_count[31:16];

  always @ (i_fcw)
    r_fcw <= i_fcw;

  always @ (posedge i_clk5MHz)
  begin
    r_count <= r_count + r_fcw;
  end 
endmodule

