`timescale 1ns/100ps

module noise_tb();
  
  reg r_clk = 0;
  wire [15:0] w_data;

  noise UUT(
    .i_clk(r_clk),
    .o_data(w_data)
  );

  always begin
    #10 r_clk = !r_clk;
  end

endmodule
