`timescale 1ns/100ps


module clock_5MHz_tb();

  reg clk50 = 0;
  wire clk5;

  clock_5MHz UUT(
    .i_clk50mhz(clk50),
    .o_clk5mhz(clk5)
  );

  always
  begin
    #10;
    clk50 = !clk50;
  end
endmodule
