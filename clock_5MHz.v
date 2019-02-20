/*
* TITLE: clock_5MHz.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Divide 50Mhz input clock by 10 to produce 5MHz output clock
*
* TODO: Add ENABLE input
*
*/

module clock_5MHz(
  input i_clk50mhz,
  output o_clk5mhz
);

  reg [2:0] r_count = 0;
  reg r_clk = 0;

  assign o_clk5mhz = r_clk;

  always @ (posedge i_clk50mhz)
  begin
    if ( r_count == 4 )
    begin
      r_count <= 0;
      r_clk <= ~r_clk;
    end
    else
      r_count <= r_count + 1;
  end

endmodule
