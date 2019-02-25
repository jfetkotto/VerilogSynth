/*
* TITLE: synthyboy.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Describes the architecture of the synth
*/

module synthyboy(
  input i_clk50mhz,
  input i_spi_clk,
  input i_spi_mosi,
  output o_spi_miso,
  input i_spi_ss,
  output [15:0] o_data
);

  wire w_clk5;
  wire [15:0] w_addr[0:1];
  wire [15:0] w_paccu_to_padjust[0:1];
  wire [15:0] w_sine_to_mux[0:1];
  wire [15:0] w_square_to_mux[0:1];
  wire [15:0] w_tri_to_mux[0:1];
  wire [15:0] w_noise_to_mux[0:1];
  wire [15:0] w_saw_to_mux[0:1];
  wire [15:0] w_mux_out[0:1];

  wire [15:0] w_convert_out[0:1];

  wire [7:0] w_spi_to_brain;
  wire w_spi_to_data_load;

  wire [7:0] w_brain_to_osc_wave[0:1];
  wire [23:0] w_brain_to_osc_freq[0:1];
  wire [15:0] w_brain_to_osc_phase[0:1];
  wire [15:0] w_brain_to_osc_amp[0:1];

  wire [15:0] temp_o[0:1];

  reg [16:0] r_out = 17'h000;

  assign o_data = r_out[15:0];

  always @ (posedge w_clk5)
  begin
    r_out <= (temp_o[0] + temp_o[1]) >> 1;
  end

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
    .o_osc1_wave(w_brain_to_osc_wave[0]),
    .o_osc1_freq(w_brain_to_osc_freq[0]),
    .o_osc1_phase(w_brain_to_osc_phase[0]),
    .o_osc1_amp(w_brain_to_osc_amp[0]),
    .o_osc2_wave(w_brain_to_osc_wave[1]),
    .o_osc2_freq(w_brain_to_osc_freq[1]),
    .o_osc2_phase(w_brain_to_osc_phase[1]),
    .o_osc2_amp(w_brain_to_osc_amp[1])
  );

  genvar i;
  generate
    for(i=0;i<2;i=i+1) begin: loop
      phase_accu PHASE_ACCU(
        .i_clk5MHz(w_clk5),
        .i_fcw(w_brain_to_osc_freq[i]),
        .o_16bit_addr(w_paccu_to_padjust[i])
      );

      phase_adjust PHASE_ADJUST(
        .i_clk(w_clk5),
        .i_addr(w_paccu_to_padjust[i]),
        .i_adjust(w_brain_to_osc_phase[i]),
        .o_addr(w_addr[i])
      );

      wave_mux WAVE_MUX(
        .i_sel(w_brain_to_osc_wave[i[2:0]]),
        .i_sine(w_sine_to_mux[i]),
        .i_saw(w_saw_to_mux[i]),
        .i_square(w_square_to_mux[i]),
        .i_tri(w_tri_to_mux[i]),
        .i_noise(w_noise_to_mux[i]),
        .o_data(w_mux_out[i])
      );

      s16_to_u16 S16_TO_U16(
        .i_clk(w_clk5),
        .i_s16(w_mux_out[i]),
        .o_u16(w_convert_out[i])
      );

      amp AMP(
        .i_clk(w_clk5),
        .i_wave(w_convert_out[i]),
        .i_amp(w_brain_to_osc_amp[i]),
        .o_data(temp_o[i])
      );

      sine_wave SINE_WAVE(
        .i_clk(w_clk5),
        .i_addr(w_addr[i]),
        .o_data(w_sine_to_mux[i])
      );

      saw_wave SAW(
        .i_clk(w_clk5),
        .i_addr(w_addr[i]),
        .o_data(w_saw_to_mux[i])
      );

      square_wave SQUARE(
        .i_clk(w_clk5),
        .i_addr(w_addr[i]),
        .o_data(w_square_to_mux[i])
      );

      tri_wave TRI(
        .i_clk(w_clk5),
        .i_addr(w_addr[i]),
        .o_data(w_tri_to_mux[i])
      );

      noise NOISE(
        .i_clk(w_clk5),
        .o_data(w_noise_to_mux[i])
      );
    end
  endgenerate
endmodule
