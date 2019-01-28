/*
* TITLE: synthyboy.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Describes the architecture of the synth 
*/

module synthboy(
  i_clk50mhz,
  o_data
);

  input i_clk50mhz;
  output [15:0] o_data;


  reg [23:0] r_fcw = 24'hffffff;
  wire w_clk5;


  clock_5MHz CLK5MHZ(
    .i_clk50mhz(i_clk50mhz),
    .o_clk5mhz(w_clk5)
  );

  phase_accu PHASE_ACCU(
    .i_clk5MHz(w_clk5),
    .i_fcw(r_fcw),
    .o_16bit_addr(o_data)
  );

endmodule

