//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 14.06.2025 
// Design Name: Sub_bytes
// Module Name: Sub_bytes.sv
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


module SubBytes(in, out);
	input logic [127:0] in;
	output logic [127:0] out;

	genvar i;
	generate
		for (int i = 0; i < 128; i=1+8) begin
			S_box s(in[i +: 8], out[i +: 8]);
		end
		
	endgenerate
	
endmodule : SubBytes
