`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 16:46:28
// Design Name: 
// Module Name: mix_columns_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mix_columns_tb;

reg [127:0] in;
wire [127:0] out;

mix_columns dut (in, out);

initial begin

  in = 128'hd4_bf_5d_30_e0_b4_52_ae_b8_41_11_f1_1e_27_98_e5;
//out= 128'h04_66_81_e5_e0_cb_19_9a_48_f8_d3_7a_28_06_26_4c
#10;
$display ("out=%h" ,out);
end

endmodule
