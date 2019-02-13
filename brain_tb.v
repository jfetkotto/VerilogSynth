`timescale 1ns/100ps

module brain_tb();

  reg r_clk = 0;
  reg r_data_load = 0;
  reg [7:0] r_data;

  wire [7:0] w_osc1_wave;
  wire [23:0] w_osc1_freq;
  wire [15:0] w_osc1_phase;
  wire [15:0] w_osc1_amp;

  wire [7:0] w_osc2_wave;
  wire [23:0] w_osc2_freq;
  wire [15:0] w_osc2_phase;
  wire [15:0] w_osc2_amp;

  brain UUT(
    //i_clk(r_clk),
    .i_data_load(r_data_load),
    .i_data(r_data),
    .o_osc1_wave(w_osc1_wave),
    .o_osc1_freq(w_osc1_freq),
    .o_osc1_phase(w_osc1_phase),
    .o_osc1_amp(w_osc1_amp),
    .o_osc2_wave(w_osc2_wave),
    .o_osc2_freq(w_osc2_freq),
    .o_osc2_phase(w_osc2_phase),
    .o_osc2_amp(w_osc2_amp)
  );

  always begin
    #10 r_clk <= !r_clk;
  end

  always begin
    // send shit
    #1000
    r_data <= 8'h00;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;

    // adjust osc1_wave
    #1000
    r_data <= 8'h01;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'h02;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    // termination byte
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;

    // adjust osc1_freq
    #1000
    r_data <= 8'h02;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hee;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    // termination byte
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;

    // adjust osc1_amp
    #1000
    r_data <= 8'h04;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hee;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    // termination byte
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;

    // adjust osc1_wave
    #1000
    r_data <= 8'h01;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'h04;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    // termination byte
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;

    // adjust osc2_wave
    #1000
    r_data <= 8'h11;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'h00;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    // termination byte
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;

    // adjust osc2_freq
    #1000
    r_data <= 8'h12;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hef;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hcd;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    #100
    r_data <= 8'hab;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;
    // termination byte
    #100
    r_data <= 8'hff;
    r_data_load <= 1'b1;
    #100
    r_data_load <= 1'b0;


  end
endmodule
