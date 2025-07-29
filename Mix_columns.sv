`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 21.07.2025 14:53:41
// Design Name: 
// Module Name: mix_columns
// Project Name: AES Encryption
// Target Devices: Zed board
// Tool Versions: Vivado 2019.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mix_columns(in, out);

input [127:0] in;
output [127:0] out;

function [7:0] mb2;
    input [7:0] x;
    begin
        if(x[7] == 1) mb2 = ((x << 1)^8'h1b);
        else mb2 = x << 1;
    end
endfunction

function [7:0] mb3;
    input[7:0] x;
    begin
        mb3 = mb2(x)^x;
    end
endfunction


genvar i;

generate 
for(i=0;i<4;i=i+1) begin: m_col

    assign out [(i*32+24)+:8] = mb2(in[(i*32+24)+:8]) ^ mb3(in[(i*32+16)+:8]) ^ in[(i*32+8)+:8] ^ in[i*32+:8];
    assign out [(i*32+16)+:8] = in[(i*32+24)+:8] ^ mb2(in[(i*32+16)+:8]) ^ mb3(in[(i*32+8)+:8]) ^ in[i*32+:8];
    assign out [(i*32+8)+:8] = in[(i*32+24)+:8] ^ in[(i*32+16)+:8] ^ mb2(in[(i*32+8)+:8]) ^ mb3(in[i*32+:8]);
    assign out [i*32+:8] = mb3(in[(i*32+24)+:8]) ^ in[(i*32+16)+:8] ^ in[(i*32+8)+:8] ^ mb2(in[i*32+:8]); 

end

endgenerate

endmodule
