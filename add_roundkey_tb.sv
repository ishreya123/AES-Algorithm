module add_roundkey_tb (
	input [127:0] data_in, key,
	output [127:0] data_out
);
AddRoundKey dut (data_in, data_out, key);

intial begin
	data_in = 128'h3243f6a8885a308d313198a2e0370734;
	key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
end
endmodule : add_roundkey_tb