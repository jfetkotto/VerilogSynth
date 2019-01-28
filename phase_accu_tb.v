`timescale 1ns/100ps

module phase_accu_tb();
 
  reg clk5 = 0;
  reg [23:0] fcw = 24'hffffff;
  wire [15:0] addr;

  phase_accu UUT(
    .i_clk5MHz(clk5),
    .i_fcw(fcw),
    .o_16bit_addr(addr)
  );

  
  // 5MHZ CLOCK
  always
  begin
    #100
    clk5 = !clk5;
  end

endmodule

