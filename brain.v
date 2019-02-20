module brain(
  input [7:0] i_data,
  input i_data_load,
  output reg [7:0] o_osc1_wave,
  output reg [23:0] o_osc1_freq,
  output reg [15:0] o_osc1_phase,
  output reg [15:0] o_osc1_amp,
  output reg [7:0] o_osc2_wave,
  output reg [23:0] o_osc2_freq,
  output reg [15:0] o_osc2_phase,
  output reg [15:0] o_osc2_amp
);

  // States
  parameter idle = 0,
            osc1_wave = 1,
            osc1_freq = 2,
            osc1_phase = 3,
            osc1_amp = 4,
            osc2_wave = 5,
            osc2_freq = 6,
            osc2_phase = 7,
            osc2_amp = 8,
            shift1 = 9,
            shift2 = 10,
            data_out = 11;
  // Initial state
  reg [3:0] state = idle;

  reg [23:0] r_data_buffer;

  reg [3:0] output_target;

  always @ (posedge i_data_load)
  begin
    case (state)
      idle :
        begin
          case (i_data)
            8'h01 :
              begin
                state <= osc1_wave;
                output_target <= osc1_wave;
              end
            8'h02 :
              begin
                state <= osc1_freq;
                output_target <= osc1_freq;
              end
            8'h03 :
              begin
                state <= osc1_phase;
                output_target <= osc1_phase;
              end
            8'h04 :
              begin
                state <= osc1_amp;
                output_target <= osc1_amp;
              end
            8'h11 :
              begin
                state <= osc2_wave;
                output_target <= osc2_wave;
              end
            8'h12 :
              begin
                state <= osc2_freq;
                output_target <= osc2_freq;
              end
            8'h13 :
              begin
                state <= osc2_phase;
                output_target <= osc2_phase;
              end
            8'h14 :
              begin
                state <= osc2_amp;
                output_target <= osc2_amp;
              end
          endcase
        end
      osc1_wave : state <= data_out;
      osc1_freq : state <= shift1;
      osc1_phase : state <= shift2;
      osc1_amp : state <= shift2;
      osc2_wave : state <= data_out;
      osc2_freq : state <= shift1;
      osc2_phase : state <= shift2;
      osc2_amp : state <= shift2;
      shift1 : state <= shift2;
      shift2 : state <= data_out;
      default : state <= idle;
    endcase
  end

  always @ (posedge i_data_load)
  begin
    case (state)
      shift1, shift2 :
        begin
          r_data_buffer <= r_data_buffer >> 8;
          r_data_buffer[23:16] <= i_data;
        end
      data_out :
        begin
          case (output_target)
            osc1_wave : o_osc1_wave <= r_data_buffer[23:16];
            osc1_freq : o_osc1_freq <= r_data_buffer;
            osc1_phase : o_osc1_phase <= r_data_buffer[23:8];
            osc1_amp : o_osc1_amp <= r_data_buffer[23:8];
            osc2_wave : o_osc2_wave <= r_data_buffer[23:16];
            osc2_freq : o_osc2_freq <= r_data_buffer;
            osc2_phase : o_osc2_phase <= r_data_buffer[23:8];
            osc2_amp : o_osc2_amp <= r_data_buffer[23:8];
          endcase
        end
      default :
        r_data_buffer[23:16] <= i_data;
    endcase
  end

endmodule
