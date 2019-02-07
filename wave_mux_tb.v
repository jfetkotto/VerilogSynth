`timescale 1ns/100ps


module wave_mux_tb();
  
  reg [1:0] r_sel = 2'b00;
  reg [15:0] r_sine = 16'hef;
  reg [15:0] r_noise = 16'hde;
  reg [15:0] r_saw = 16'hff;
  reg [15:0] r_tri = 16'had;
  reg [15:0] r_square = 16'hbe;

  wire [15:0] w_data;

  wave_mux UUT(
    .i_sel(r_sel),
    .i_sine(r_sine),
    .i_saw(r_saw),
    .i_square(r_square),
    .i_tri(r_tri),
    .i_noise(r_noise),
    .o_data(w_data)
  );


  always
  begin
    #100;
    r_sel <= 3'b001;
    #100;
    r_sel <= 3'b010;
    #100;
    r_sel <= 3'b011;
    #100;
    r_sel <= 3'b100;
    #100;
    r_sel <= 3'b000;
  end
endmodule
