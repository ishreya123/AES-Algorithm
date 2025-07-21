//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 15.06.2025 
// Design Name: s_box_tb
// Module Name: s_box_tb.sv
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


module s_box_tb (
	input [7:0] a_key,
	output reg [7:0] c_key);

S_box dut (a_key,c_key);

initial begin
	a_key = 8'h25; //expected output : 3F
	#10;
	a_key = 8'h33; //expected output : C3
	#10;
	a_key = 8'h4b; //expected output : B3
	#10;
	a_key = 8'h59; //expected output : CB
	#10;
	a_key = 8'h69; //expected output : F9
	#10;
	a_key = 8'h75; //expected output : 9D
	#10;
	a_key = 8'h97; //expected output : 88
	#10;
	a_key = 8'hb6; //expected output : 4E
	#10;
	a_key = 8'hca; //expected output : 74
	#10;
	a_key = 8'hea; //expected output : 87
	#10;
	a_key = 8'hfa; //expected output : 2D
end

endmodule : s_box_tb
