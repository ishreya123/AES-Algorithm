module AddRoundKey (data_in, data_out, key);
	input logic [127:0] data_in;
	input logic [127:0] key;
	output logic [127:0] data_out;

	assign data_out = key ^ data_in;


endmodule : AddRoundKey