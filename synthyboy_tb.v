`timescale 1ns/100ps

module synthyboy_tb();

  reg clk50 = 0;
  wire [15:0] data;

  synthboy UUT(
    .i_clk50mhz(clk50),
    .o_data(data)
  );

  always
  begin
    #10 clk50 = !clk50;
  end

endmodule

