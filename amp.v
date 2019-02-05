module amp(
  i_clk,
  i_wave,
  i_amp,
  o_data
);

  input i_clk;
  input [15:0] i_wave;
  input [15:0] i_amp;
  output reg [15:0] o_data;
  
  // 16bits x 16bits = 32bits
  reg [31:0] r_temp;

  always @ (posedge i_clk)
  begin
    r_temp <= i_wave * i_amp;
    o_data <= r_temp >> 16;
  end

endmodule
