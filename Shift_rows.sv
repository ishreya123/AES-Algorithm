//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 14.06.2025 
// Design Name: Shift_rows
// Module Name: Shift_rows.sv
// Project Name: AES ENCRYPTION
// Target Devices: ZED bord
// Tool Versions: 2019.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Shift_rows (
	input [127:0] in,
	output [127:0] shifted
	);

//First row not shifted
assign shifted[0+:8] = in[0+:8];
assign shifted[32+:8] = in[32+:8];
assign shifted[64+:8] = in[64+:8];
assign shifted[96+:8] = in[96+:8];

//Second row: 1 byte left shift
assign shifted[8+:8] = [40+:8]; 
assign shifted[40+:8] = [72+:8]; 
assign shifted[72+:8] = [104+:8];
assign shifted[104+:8] = [8+:8];

//Third row: 2 byte left shift
assign shifted[16+:8] = [80+:8]; 
assign shifted[48+:8] = [112+:8];
assign shifted[80+:8] = [16+:8];
assign shifted[112+:8] = [48+:8];

//Fourth row: 3 byte left shift
assign shifted[24+:8] = [120+:8]; 
assign shifted[56+:8] = [24+:8];
assign shifted[88+:8] = [56+:8];
assign shifted[120+:8] = [88+:8]; 

endmodule : Shift_rows
