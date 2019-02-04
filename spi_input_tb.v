`timescale 1ns/100ps

module spi_input_tb();
  
  reg r_sys_clk = 0;
  reg r_spi_clk = 0;
  reg r_spi_mosi;
  reg r_spi_ss;
  wire w_spi_miso;
  wire [7:0] w_data;

  spi_input UUT(
    .i_sys_clk(r_sys_clk),
    .i_spi_clk(r_spi_clk),
    .i_spi_mosi(r_spi_mosi),
    .i_spi_ss(r_spi_ss),
    .o_spi_miso(w_spi_miso),
    .o_data(w_data)
  );

  // sys clock
  always begin
    #10 r_sys_clk <= !r_sys_clk;
  end

  //spi clock
  always begin
    #52000 r_spi_clk <= !r_spi_clk;
  end

  always begin
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 1;
    r_spi_ss <= 1;

    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 1;
    r_spi_ss <= 1;
  end

endmodule
