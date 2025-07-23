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
input [0:127]in;
output [0:127]out;
input [0:127] key;

wire [0:127] after_subBytes;
wire [0:127] after_shiftRows;
wire [0:127] after_mixColumns;
wire [0:127] after_addRoundKey;


SubBytes sub(in, after_subBytes);
Shift_rows shift(after_subBytes,after_shiftRows);
mix_columns mix(after_shiftRows, after_mixColumns);
AddRoundKey ark(after_mixColumns,key,out);

endmodule

