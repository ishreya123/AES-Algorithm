//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 15.06.2025 
// Design Name: Key_expansion
// Module Name: Key_expansion.sv
// Project Name: AES ENCRYPTION
// Target Devices: ZED board
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


module key_expansion (num_round, input_key, output_key);
	input logic [3:0] num_round;
	input logic [127:0] input_key;
	output logic [127:0] output_key;


	logic [31:0] w0, w1, w2, w3; 
	logic [31:0] g, temp, rcon_val;
	


	//spliting the input key into words
	assign w0 = input_key[127:96];
	assign w1 = input_key[95:64];
	assign w2 = input_key[63:32];
	assign w3 = input_key[31:0];
	
	//Rotword: left rotate by 8 bits 
	assign temp = {w3[23:0], w3[31:24]};
	
	//S-box substitutions
	wire [7:0] sb0, sb1, sb2, sb3;
	
	S_box s0(.a_key(temp[31:24]), .c_key(sb0));
	S_box s1(.a_key(temp[23:16]), .c_key(sb1));
	S_box s2(.a_key(temp[15:8]), .c_key(sb2));
	S_box s3(.a_key(temp[7:0]), .c_key(sb3));

    assign g = {sb0, sb1, sb2, sb3};
    
    
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
	
	//XORing the first word with the round constant
	always_comb begin
	    rcon_val = rcon(num_round);
	    output_key[127:96] = w0 ^ g ^ rcon_val;
	    output_key[95:64] = (w0 ^ g ^ rcon_val) ^ w1;
	    output_key[63:32] = (w0 ^ g ^ rcon_val ^ w1) ^ w2;
	    output_key[31:0] = (w0 ^ g ^ rcon_val ^ w1 ^ w2) ^ w3;
end
endmodule : key_expansion


//2nd approaach for key expansion 
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 15.06.2025 
// Design Name: Key_expansion
// Module Name: Key_expansion.sv
// Project Name: AES ENCRYPTION
// Target Devices: ZED board
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


module key_expansion (num_round, input_key, output_key);
	input logic [3:0] num_round;
//	input logic [0:127] input_key;
//	output logic [0:1407] output_key;
	input logic [127:0] input_key;
	output logic [1407:0] output_key;


	logic [31:0] w0, w1, w2, w3; 
	logic [31:0] g, temp, rcon_val;
	


	//spliting the input key into words
	assign w0 = input_key[127:96];
	assign w1 = input_key[95:64];
	assign w2 = input_key[63:32];
	assign w3 = input_key[31:0];
	
	//Rotword: left rotate by 8 bits 
	assign temp = {w3[23:0], w3[31:24]};
	
	//S-box substitutions
	wire [7:0] sb0, sb1, sb2, sb3;
	
	S_box s0(.a_key(temp[31:24]), .c_key(sb0));
	S_box s1(.a_key(temp[23:16]), .c_key(sb1));
	S_box s2(.a_key(temp[15:8]), .c_key(sb2));
	S_box s3(.a_key(temp[7:0]), .c_key(sb3));

    assign g = {sb0, sb1, sb2, sb3};
    
    
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
	
	//XORing the first word with the round constant
	always_comb begin
	    rcon_val = rcon(num_round);
	    output_key[127:96] = w0 ^ g ^ rcon_val;
	    output_key[95:64] = (w0 ^ g ^ rcon_val) ^ w1;
	    output_key[63:32] = (w0 ^ g ^ rcon_val ^ w1) ^ w2;
	    output_key[31:0] = (w0 ^ g ^ rcon_val ^ w1 ^ w2) ^ w3;
end
endmodule : key_expansion
