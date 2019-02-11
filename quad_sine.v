module quad_sine(
  i_clk,
  i_addr,
  o_data
);

  input i_clk;

  input [13:0] i_addr;
  output reg [15:0] o_data;
  // ROM for LUT, 16x16
  (* romstyle = "M9K" *)
  reg [15:0] r_lut [0:(2**14)-1];


  initial begin
    $readmemb("quad_lut.mem", r_lut);
  end

	always @ (posedge i_clk)
	begin
    o_data <= r_lut[i_addr[13:0]];
	end

/*

  always @ (posedge i_clk)
  begin
    case ({i_addr[15],i_addr[14]})
      2'b00 : o_data <= r_lut[i_addr[13:0]];
      2'b01 : o_data <= r_lut[~i_addr[13:0]];
      2'b10 : o_data <= -r_lut[i_addr[13:0]];
      2'b11 : o_data <= -r_lut[~i_addr[13:0]];
    endcase
  end
*/
endmodule
