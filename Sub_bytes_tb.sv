module Sub_bytes_tb ( );
  logic [127:0] in;  logic [127:0] out;

	SubBytes dut (in, out);
	
initial begin
			            in = 128'h19_a0_9a_e9_3d_f4_c6_f8_e3_e2_8d_48_be_2b_2a_08; 
	//expected output :           d4_e0_b8_1e_27_bf_b4_41_11_98_5d_52_ae_f1_e5_30
  			//Actual output :     28_29_63_14_39_55_22_75_85_22_05_38_06_11_42_43_67_34_25_6
  //After converting dec to hex : D4_E0_B8_1E_27_BF_B4_41_11_98_5D_52_AE_F1_E5_30
  $display ("out1 " , out);
 
	#10;

			  in = 128'ha4_68_6b_02_9c_9f_5b_6a_7f_35_ea_50_f2_2b_43_49;
	//expected output : 49_45_7f_77_de_db_39_02_d2_96_87_53_89_f1_1a_3b
  
  
  $display ("out2 " , out);
end
endmodule : Sub_bytes_tb
