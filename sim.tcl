
project open /home/sam/Repos/VerilogSynth/SynthTest.mpf
layout load Simulate

vlog *.v
vsim work.synthyboy_tb
add wave -position end sim:/synthyboy_tb/r_spi_clk
add wave -position end  sim:/synthyboy_tb/r_spi_mosi
add wave -position end  sim:/synthyboy_tb/r_spi_ss
add wave -position end  sim:/synthyboy_tb/w_spi_miso
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_spi_to_brain
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_wave
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_freq
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_phase
add wave -radix hexadecimal -position end  sim:/synthyboy_tb/UUT/w_brain_to_osc_amp
add wave -clampanalog 1 -max 65535 -min 0 -color magenta -position end  sim:/synthyboy_tb/UUT/temp_o
add wave -clampanalog 1 -max 65535 -min 0 -color blue -position end  sim:/synthyboy_tb/UUT/o_data

property wave -format analog -height 100 -radix unsigned /synthyboy_tb/UUT/o_data
property wave -format analog -height 100 -radix unsigned /synthyboy_tb/UUT/temp_o

run 100 ms
