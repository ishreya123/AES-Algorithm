`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2025 16:22:44
// Design Name: AES Top Testbench
// Module Name: Aes_top_tb
// Project Name: AES Encryption
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


module Aes_top_tb;
    reg [127:0] in;
    reg [127:0] key;
    wire [127:0] out;
    
    Aes_top dut ( in,key,out);
    
    initial begin
//   in= 128'h32_88_31_e0_43_5a_31_37_f6_30_98_07_a8_8d_a2_34;
//   key= 128'h2b_28_ab_09_7e_ae_f7_cf_15_d2_15_4f_16_a6_88_3c;

    in=128'h32_43_f6_a8_88_5a_30_8d_31_31_98_a2_e0_37_07_34;
    key=128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
     $monitor ("in= %h,key= %h, out= %h",in,key,out);
    
    end

endmodule
