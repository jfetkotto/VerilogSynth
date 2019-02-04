/*
* TITLE: noise.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: LFSR to create White Noise signal
* 
*/

module noise(
  i_clk,
  o_data
);

  input i_clk;
  output reg signed [15:0] o_data;

  reg [0:15] r_shift16 = 16'hdead;

  always @ (posedge i_clk) begin
    r_shift16[0] <= (((r_shift16[15]^r_shift16[14])^r_shift16[12])^r_shift16[3]);
    r_shift16[1:15] <= r_shift16[0:14];
  end

  always @ (posedge i_clk) begin
    // Sending -32768 out is bad juju, so be good. 
    case (r_shift16)
      16'b1000_0000_0000_0000: o_data <= 16'b1000_0000_0000_0001;
                      default: o_data <= r_shift16;
    endcase
  end

endmodule
