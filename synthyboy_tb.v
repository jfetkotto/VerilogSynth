`timescale 1ns/100ps

module synthyboy_tb();

  reg r_clk50 = 0;

  reg r_spi_clk = 0;
  reg r_spi_mosi = 0;
  reg r_spi_ss = 1;
  wire w_spi_miso;

  wire [15:0] w_data;

  synthyboy UUT(
    .i_clk50mhz(r_clk50),
    .i_spi_clk(r_spi_clk),
    .i_spi_mosi(r_spi_mosi),
    .i_spi_ss(r_spi_ss),
    .o_spi_miso(w_spi_miso),
    .o_data(w_data)
  );

  always
  begin
    #10 r_clk50 = !r_clk50;
  end

  always begin
      #52000;
      case (r_spi_ss) 
        0 : r_spi_clk <= !r_spi_clk;
        default : r_spi_clk <= 0;
      endcase
  end

  always begin
    /* OSC1 => sine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
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
    #104000
    r_spi_ss <= 1;


    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
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
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_ss <= 1;
   
    /* Kick state machine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;

    #416000;

    /* OSC1 => freq 19.53KHz */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
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
    #104000
    r_spi_mosi <= 0;
    #104000
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
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
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
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_ss <= 1;

    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;

    /* Kick State Machine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;



    /* OSC1 => Max Amp */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
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
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
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
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
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
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_ss <= 1;

    /* Kick State Machine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;

    /* OSC1 => saw */
    #4160000;
    #4160000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
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
    #104000
    r_spi_ss <= 1;


    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
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
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;
   
    /* Kick state machine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;

    /* OSC1 => square */
    #4160000;
    #4160000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
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
    #104000
    r_spi_ss <= 1;


    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
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
    #104000
    r_spi_mosi <= 1;
    #104000
    r_spi_ss <= 1;
   
    /* Kick state machine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;


    /* Kick state machine */
    #416000
    r_spi_ss <= 0;
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_mosi <= 0;
    #104000
    r_spi_ss <= 1;



    #4160000;
  end

endmodule
