`timescale 1ns/100ps

module s16_to_u16_tb();

  reg r_clk = 0;
  reg signed [15:0] r_s16 = -32767;
  wire [15:0] w_u16;

  s16_to_u16 UUT(
    .i_clk(r_clk),
    .i_s16(r_s16),
    .o_u16(w_u16)
  );

  always begin
    #10 r_clk = !r_clk;
  end

  always begin
    #20 r_s16 = 32767;
    #20 r_s16 = -32767;
  end
endmodule
