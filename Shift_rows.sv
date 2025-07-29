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
	input [0:127] in,
	output [0:127] shifted
	);

//First row not shifted
assign shifted[0+:8] = in[0+:8];
assign shifted[32+:8] = in[32+:8];
assign shifted[64+:8] = in[64+:8];
assign shifted[96+:8] = in[96+:8];

//Second row: 1 byte left shift
	assign shifted[8+:8] = in[40+:8]; 
	assign shifted[40+:8] = in[72+:8]; 
	assign shifted[72+:8] = in[104+:8];
	assign shifted[104+:8] = in[8+:8];

//Third row: 2 byte left shift
	assign shifted[16+:8] = in[80+:8]; 
	assign shifted[48+:8] = in[112+:8];
	assign shifted[80+:8] = in[16+:8];
	assign shifted[112+:8] = in[48+:8];

//Fourth row: 3 byte left shift
	assign shifted[24+:8] = in[120+:8]; 
	assign shifted[56+:8] = in[24+:8];
	assign shifted[88+:8] = in[56+:8];
	assign shifted[120+:8] = in[88+:8]; 

endmodule : Shift_rows
