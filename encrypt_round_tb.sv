`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2025 10:59:36
// Design Name: 
// Module Name: encrypt_round_tb
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


module encrypt_round_tb;
reg [127:0]in;
wire [127:0]out;
reg [127:0] key;

encrypt_round dut(in,key,out);

initial begin
//in = 128'h19_a0_9a_e9_3d_f4_c6_f8_e3_e2_8d_48_be_2b_2a_08;
in = 128'h19_3d_e3_be_a0_f4_e2_2b_9a_c6_8d_2a_e9_f8_48_08;
key = 128'ha0_fa_fe_17_88_54_2c_b1_23_a3_39_39_2a_6c_76_05; 
end
endmodule
