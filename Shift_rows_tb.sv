`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 13:09:54
// Design Name: 
// Module Name: Shift_rows_tb
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


module Shift_rows_tb();

	 reg [127:0] in;
	wire [127:0] shifted;
Shift_rows dut (in,shifted);
initial begin	
//in = 128'h d4_e0_b8_1e_27_bf_b4_41_11_98_5d_52_ae_f1_e5_30;
//d4 e0 b8 1e bf b4 41 27 5d 52 11 98 30 ae f1 e5

in=128'hd4_27_11_ae_e0_bf_98_f1_b8_b4_5d_e5_1e_41_52_30;
#10;

$display("shifted = %h",shifted);
end


endmodule
