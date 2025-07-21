`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 19:16:56
// Design Name: 
// Module Name: encrypt_round
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


module encrypt_round(in,key,out);
input [127:0]in;
output [127:0]out;
input [127:0] key;
wire [127:0] after_subBytes;
wire [127:0] after_shiftRows;
wire [127:0] after_mixColumns;
wire [127:0] after_addRoundKey;

Sub_bytes sub(in, after_subBytes);
Shift_rows shift(after_subBytes,after_shiftRows);
Mix_columns mix(after_shiftRows, after_mixColumns);
Add_RoundKey ark(after_mixColumns,out,key);

endmodule
