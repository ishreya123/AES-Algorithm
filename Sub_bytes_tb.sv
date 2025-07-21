
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




module Sub_bytes_tb ( );
  logic [127:0] in;  logic [127:0] out;

	SubBytes dut (in, out);
	
initial begin
		      in = 128'h19_a0_9a_e9_3d_f4_c6_f8_e3_e2_8d_48_be_2b_2a_08; 
	    //expected output : d4_e0_b8_1e_27_bf_b4_41_11_98_5d_52_ae_f1_e5_30
	      //Actual output : 34 06 46 09 36 24 03 80 05 42 86 10 02 80 75 97 27 97 52
//After converting dec to hex : 19 A0 9A E9 3D F4 C6 F8 E3 E2 8D 48 BE 2B 2A 08
	
  $display ("in1" , in);
  $display ("out1 " , out);
	#10;
	
	in = 128'ha4_68_6b_02_9c_9f_5b_6a_7f_35_ea_50_f2_2b_43_49;
	//expected output : 49_45_7f_77_de_db_39_02_d2_96_87_53_89_f1_1a_3b
  $display ("in2" , in);
  $display ("out2 " , out);

end
endmodule : Sub_bytes_tb
