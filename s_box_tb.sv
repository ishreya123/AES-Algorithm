module s_box_tb (
	input [7:0] a_key,
	output reg [7:0] c_key);

S_box dut (a_key,c_key);

initial begin
	a_key = 8'h25;
	#10;
	a_key = 8'h33;
	#10;
	a_key = 8'h4b;
	#10;
	a_key = 8'h59;
	#10;
	a_key = 8'h69;
	#10;
	a_key = 8'h75;
	#10;
	a_key = 8'h97;
	#10;
	a_key = 8'hb6;
	#10;
	a_key = 8'hca;
	#10;
	a_key = 8'hea;
	#10;
	a_key = 8'hfa;
end

endmodule : s_box_tb