
project open /home/sam/Repos/VerilogSynth/SynthTest.mpf
layout load Simulate

vlog *.v
vsim work.synthyboy_tb

add wave -label SPI_CLK -position end sim:/synthyboy_tb/r_spi_clk
add wave -label SPI_MOSI -position end  sim:/synthyboy_tb/r_spi_mosi
add wave -label SPI_SS -position end  sim:/synthyboy_tb/r_spi_ss
add wave -label SPP_MISO -position end  sim:/synthyboy_tb/w_spi_miso
add wave -label SPI_TO_BRAIN -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_spi_to_brain
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_wave
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_freq
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_phase
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_amp
add wave -label Osc1 -format Analog-Step -max 65535 -min 0 -radix unsigned -height 100 -position end sim:/synthyboy_tb/UUT/temp_o(0)
add wave -label Osc2 -format Analog-Step -max 65535 -min 0 -radix unsigned -height 100 -position end sim:/synthyboy_tb/UUT/temp_o(1)
add wave -label Output -format Analog-Step -max 65535 -min 0 -radix unsigned -height 100 -position end sim:/synthyboy_tb/UUT/o_data

run 400 ms

wave zoom full
