/*
* TITLE: square_wave.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Output square wave based on ramp input
*/

module square_wave(
  i_clk,
  i_addr,
  o_data
);

  input i_clk;
  input [15:0] i_addr;
  output reg signed [15:0] o_data;

  always @ (posedge i_clk) begin
    case (i_addr[15])
            // Values of -32767 and 32767
            0: o_data <= 16'b1000000000000001;
      default: o_data <= 16'b0111111111111111;
    endcase
  end
endmodule
