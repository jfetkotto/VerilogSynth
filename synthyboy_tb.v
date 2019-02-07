`timescale 1ns/100ps

module synthyboy_tb();

  reg clk50 = 0;
  reg [15:0] r_amp = 16'hffff;
  reg [2:0] r_mux = 3'b100;

  wire [15:0] data;

  synthyboy UUT(
    .i_clk50mhz(clk50),
    .i_amp(r_amp),
    .i_mux_sel(r_mux),
    .o_data(data)
  );

  always
  begin
    #10 clk50 = !clk50;
  end

  always
  begin
    #1000000 r_amp <= 16'h7fff;
    #1000000 r_amp <= 16'h3fff;
    #1000000 r_amp <= 16'hffff;
  end


  always
  begin
    #100000 r_mux <= 3'b000;
    #100000 r_mux <= 3'b001;
    #100000 r_mux <= 3'b010;
    #100000 r_mux <= 3'b011;
    #100000 r_mux <= 3'b100;
  end

endmodule

