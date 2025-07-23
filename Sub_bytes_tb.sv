
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 14.06.2025 
// Design Name: Sub_bytes_tb
// Module Name: Sub_bytes_tb.sv
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




module Sub_bytes_tb ;

reg [0:127] in;
wire [0:127] out;

SubBytes dut(in,out);

initial begin
in = 128'h19_3d_e3_be_a0_f4_e2_2b_9a_c6_8d_2a_e9_f8_48_08;
end


endmodule : Sub_bytes_tb
