/*
* TITLE: spi_input.v
* AUTHOR: Sam Mitchell
* DATE: Jan 2019
* DESCRIPTION: Shift in bits in accordance with SPI protocol, spits out 8 bit parallel lines
*/

module spi_input(
  input i_sys_clk,
  input i_spi_clk,
  input i_spi_mosi,
  input i_spi_ss,
  output o_spi_miso,
  output reg [7:0] o_data,
  output o_data_load
);

  reg [2:0] r_counter = 3'b000;
  reg [7:0] r_shift_reg = 8'h00;
  reg r_spi_clk;
  reg r_spi_ss;
  reg r_spi_mosi;
  reg r_spi_miso;
  wire f_data_out; // DATA_OUT Flag


  assign f_data_out = r_counter == 0 ? 1 : 0;
 
  assign o_data_load = f_data_out;

  assign o_spi_miso = r_spi_miso;

  // Register all inputs on system clock edge
  always @ (posedge i_sys_clk) begin
    r_spi_clk <= i_spi_clk;
    r_spi_ss <= i_spi_ss;
    r_spi_mosi <= i_spi_mosi;
  end

  // Counter
  always @ (posedge r_spi_clk) begin
    case (r_counter)
        7 : r_counter <= 0;
        default : r_counter <= r_counter + 1;
    endcase
  end

  // Shift data in on spi clock edge
  always @ (posedge r_spi_clk) begin
    if (r_spi_ss == 0)
      r_shift_reg <= {r_spi_mosi, r_shift_reg[7:1]};
  end

  // MISO
  always @ (posedge r_spi_clk) begin
    case (r_spi_ss)
           0 : r_spi_miso <= r_shift_reg[0];
      default: r_spi_miso <= 0;
    endcase
  end

  // Data out
  always @ (posedge i_sys_clk) begin
    if ((f_data_out == 1) & (r_spi_ss == 1))
      o_data <= {r_shift_reg[0],
                 r_shift_reg[1],
                 r_shift_reg[2],
                 r_shift_reg[3],
                 r_shift_reg[4],
                 r_shift_reg[5],
                 r_shift_reg[6],
                 r_shift_reg[7]
      };
  end
endmodule
