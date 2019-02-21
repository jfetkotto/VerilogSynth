`timescale 1ns/100ps

/* SPI Commands */
`define OSC1_WAVE 8'h01
`define OSC1_FREQ 8'h02
`define OSC1_PHASE 8'h03
`define OSC1_AMP 8'h04
`define OSC2_WAVE 8'h01
`define OSC2_FREQ 8'h02
`define OSC2_PHASE 8'h03
`define OSC2_AMP 8'h04

/* Kick for FSM */
`define NULL_BYTE 8'h00

module synthyboy_tb();

  reg r_clk50 = 0;

  reg r_spi_clk = 0;
  reg r_spi_mosi;
  reg r_spi_ss = 1;

  wire [15:0] w_data;
  wire w_spi_miso;

  synthyboy UUT(
    .i_clk50mhz(r_clk50),
    .i_spi_clk(r_spi_clk),
    .i_spi_mosi(r_spi_mosi),
    .i_spi_ss(r_spi_ss),
    .o_spi_miso(w_spi_miso),
    .o_data(w_data)
  );


  /* Bit Bash SPI output */
  integer i;
  task spi_send;
    input [7:0] byte;
    begin
      #416000;
      r_spi_ss <= 0;
      for (i = 7; i >= 0; i = i-1) begin
        r_spi_mosi <= byte[i];
        #104000;
      end
      r_spi_ss <= 1;
    end
  endtask


  initial begin
    $display("...........................................");
    $display("... Synthyboy Testbench");
    $display("...........................................");
  end


  always
    #10 r_clk50 <= !r_clk50;

  always begin
      #52000;
      case (r_spi_ss)
        0 : r_spi_clk <= !r_spi_clk;
        default : r_spi_clk <= 0;
      endcase
  end

  always begin
   /* JUNK */
    spi_send(`NULL_BYTE);

    /* OSC1 wave => Sine*/
    spi_send(`OSC1_WAVE);
    spi_send(8'h05);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_WAVE => Sine", $time);

    /* OSC1 Freq => 0x00ffff */
    spi_send(`OSC1_FREQ);
    spi_send(8'hff);
    spi_send(8'hff);
    spi_send(8'h00);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_FREQ => 0x00ffff", $time);

    /* OSC1 amp => 0xffffff */
    spi_send(`OSC1_AMP);
    spi_send(8'hff);
    spi_send(8'hff);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_AMP => 0xffff", $time);

    #4160000;
    /* OSC1 wave => triangle*/
    spi_send(`OSC1_WAVE);
    spi_send(8'h01);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_WAVE => Triangle", $time);

    /* OSC1 amp => 0x7fff */
    #4160000;
    spi_send(`OSC1_AMP);
    spi_send(8'hff);
    spi_send(8'h7f);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_AMP => 0x7fff", $time);

    #4160000;
    #4160000;
    #4160000;
    /* OSC1 wave => saw */
    spi_send(`OSC1_WAVE);
    spi_send(8'h02);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_WAVE => Saw", $time);

    /* OSC1 amp => 0x3fff */
    #4160000;
    spi_send(`OSC1_AMP);
    spi_send(8'hff);
    spi_send(8'h3f);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_AMP => 0x3fff", $time);

    #4160000;
    #4160000;
    #4160000;
    spi_send(`OSC1_FREQ);
    spi_send(8'hff);
    spi_send(8'hff);
    spi_send(8'h03);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_FREQ => 0x03ffff", $time);

    #4160000;
    #4160000;
    #4160000;
    /* OSC1 wave => square */
    spi_send(`OSC1_WAVE);
    spi_send(8'h03);
    spi_send(`NULL_BYTE);
    $display("%d nS : OSC1_WAVE => square", $time);


    /* JUNK */
    spi_send(`NULL_BYTE);
    #4160000;
    #4160000;
    $display("%d nS : TEST PATTERN END", $time);
  end

endmodule
