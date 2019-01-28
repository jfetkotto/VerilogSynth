`timescale 1ns/100ps

module square_wave_tb();
  
  reg r_clk5M = 0;
  reg [15:0] r_addr = 0;
  wire [15:0] w_data;

  reg [15:0] r_counter = 0;

  square_wave UUT(
    .i_clk(r_clk5M),
    .i_addr(r_addr),
    .o_data(w_data)
  );


  // CLOCK 5MHZ
  always begin
    #100 r_clk5M = !r_clk5M;
  end

  // COUNTER
  always @ (posedge r_clk5M) begin
    if (r_counter == 65535) begin
      r_counter <= 0;
    end else begin
      r_counter <= r_counter + 1;
    end
  end

  // ADDRESS LOOKUP
  always @ (posedge r_clk5M) begin
    r_addr <= r_counter;
  end

endmodule
