/*
* TITLE: synthyboy.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Describes the architecture of the synth
*/

module synthyboy(
  i_clk50mhz,
  i_mux_sel,
  i_spi_clk,
  i_spi_mosi,
  o_spi_miso,
  i_spi_ss,
  o_data
);

  input i_clk50mhz;

  input [2:0] i_mux_sel;
  input i_spi_clk;
  input i_spi_mosi;
  input i_spi_ss;


  output o_spi_miso;
  output [15:0] o_data;

  wire w_clk5;
  wire [15:0] w_addr;
  wire [15:0] w_sine_to_mux;
  wire [15:0] w_square_to_mux;
  wire [15:0] w_tri_to_mux;
  wire [15:0] w_noise_to_mux;
  wire [15:0] w_saw_to_mux;
  wire [15:0] w_mux_out;

  wire [15:0] w_convert_out;

  wire [7:0] w_spi_to_brain;
  wire w_spi_to_data_load;

  wire [7:0] w_brain_to_osc1_wave;
  wire [23:0] w_brain_to_osc1_freq;
  wire [15:0] w_brain_to_osc1_phase;
  wire [15:0] w_brain_to_osc1_amp;
  wire [7:0] w_brain_to_osc2_wave;
  wire [23:0] w_brain_to_osc2_freq;
  wire [15:0] w_brain_to_osc2_phase;
  wire [15:0] w_brain_to_osc2_amp;


  clock_5MHz CLK5MHZ(
    .i_clk50mhz(i_clk50mhz),
    .o_clk5mhz(w_clk5)
  );

  spi_input SPI(
    .i_sys_clk(i_clk50mhz),
    .i_spi_clk(i_spi_clk),
    .i_spi_mosi(i_spi_mosi),
    .i_spi_ss(i_spi_ss),
    .o_spi_miso(o_spi_miso),
    .o_data(w_spi_to_brain),
    .o_data_load(w_spi_to_data_load)
  );

  brain BRAIN(
    .i_data(w_spi_to_brain),
    .i_data_load(w_spi_to_data_load),
    .o_osc1_wave(w_brain_to_osc1_wave),
    .o_osc1_freq(w_brain_to_osc1_freq),
    .o_osc1_phase(w_brain_to_osc1_phase),
    .o_osc1_amp(w_brain_to_osc1_amp),
    .o_osc2_wave(w_brain_to_osc2_wave),
    .o_osc2_freq(w_brain_to_osc2_freq),
    .o_osc2_phase(w_brain_to_osc2_phase),
    .o_osc2_amp(w_brain_to_osc2_amp)
  );

  phase_accu PHASE_ACCU(
    .i_clk5MHz(w_clk5),
    .i_fcw(w_brain_to_osc1_freq),
    .o_16bit_addr(w_addr)
  );

  wave_mux WAVE_MUX(
    .i_sel(w_brain_to_osc1_wave[2:0]),
    .i_sine(w_sine_to_mux),
    .i_saw(w_saw_to_mux),
    .i_square(w_square_to_mux),
    .i_tri(w_tri_to_mux),
    .i_noise(w_noise_to_mux),
    .o_data(w_mux_out)
  );

  s16_to_u16 S16_TO_U16(
    .i_clk(w_clk5),
    .i_s16(w_mux_out),
    .o_u16(w_convert_out)
  );

  amp AMP(
    .i_clk(w_clk5),
    .i_wave(w_convert_out),
    .i_amp(w_brain_to_osc1_amp),
    .o_data(o_data)
  );

  sine_wave SINE_WAVE(
    .i_clk(w_clk5),
    .i_addr(w_addr),
    .o_data(w_sine_to_mux)
  );

  saw_wave SAW(
    .i_clk(w_clk5),
    .i_addr(w_addr),
    .o_data(w_saw_to_mux)
  );

  square_wave SQUARE(
    .i_clk(w_clk5),
    .i_addr(w_addr),
    .o_data(w_square_to_mux)
  );

  tri_wave TRI(
    .i_clk(w_clk5),
    .i_addr(w_addr),
    .o_data(w_tri_to_mux)
  );

  noise NOISE(
    .i_clk(w_clk5),
    .o_data(w_noise_to_mux)
  );

endmodule
