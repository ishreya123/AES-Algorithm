//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 15.06.2025 
// Design Name: AddRoundKey
// Module Name: AddRoundKey.sv
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


module AddRoundKey (data_in, data_out, key);
	input logic [127:0] data_in;
	input logic [127:0] key;
	output logic [127:0] data_out;

	assign data_out = key ^ data_in;


endmodule : AddRoundKey
