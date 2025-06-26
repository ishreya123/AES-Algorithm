module key_expansion (num_round, input_key, output_key);
	input [3:0] num_round;
	input [127:0] input_key;
	output [127:0] output_key;


	wire [31:0] w0, w1, w2, w3, g;


	//spliting the input key into words
	assign w0 = input_key[127:96];
	assign w1 = input_key[95:64];
	assign w2 = input_key[63:32];
	assign w3 = input_key[31:0];


	//rotword rotate the words and substitution of words
	s_box s3(.a_key(w3[31:24]), .c_key(g[7:0]));
	s_box s2(.a_key(w3[7:0]), .c_key(g[15:8]));
	s_box s1(.a_key(w3[15:8]), .c_key(g[23:16]));
	s_box s0(.a_key(w3[23:16]), .c_key(g[31:24]));


	//XORing the first word with the round constant
	assign output_key[127:96] = w0 ^ g ^ rcon(num_round);
	assign output_key[95:64] = w0 ^ g ^ rcon(num_round) ^ w1;
	assign output_key[63:32] = w0 ^ g ^ rcon(num_round) ^ w1 ^ w2;
	assign output_key[31:0] = w0 ^ g ^ rcon(num_round) ^ w1 ^ w2 ^ w3;


	//round constants
	function  [31:0] rcon;
    	input [3:0] num_round;
    	begin
    	case (num_round)
        	4'h0: rcon=32'h01_00_00_00;
         	4'h1: rcon=32'h02_00_00_00;
         	4'h2: rcon=32'h04_00_00_00;
         	4'h3: rcon=32'h08_00_00_00;
         	4'h4: rcon=32'h10_00_00_00;
         	4'h5: rcon=32'h20_00_00_00;
         	4'h6: rcon=32'h40_00_00_00;
         	4'h7: rcon=32'h80_00_00_00;
         	4'h8: rcon=32'h1b_00_00_00;
         	4'h9: rcon=32'h36_00_00_00;
         default: rcon=32'h00_00_00_00;
    	endcase
    	end
	endfunction
endmodule : key_expansion
