`timescale 1ns/100ps

module amp_tb();

  reg r_clk = 1'b0;
  reg [15:0] r_wave = 16'hffff;
  reg [15:0] r_amp = 16'h7fff;

  wire [15:0] w_data;

  amp UUT(
    .i_clk(r_clk),
    .i_wave(r_wave),
    .i_amp(r_amp),
    .o_data(w_data)
  );

  always begin
    #10 r_clk = !r_clk;
  end

  always begin
    #100 r_amp <= 16'h3fff;
    #100 r_amp <= 16'h0000;
    #100 r_amp <= 16'h7fff;
  end

endmodule
