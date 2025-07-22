`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 17:34:03
// Design Name: Aes Top module
// Module Name: Aes_top
// Project Name: AES Encryption
// Target Devices: Zed Board 
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

//module Aes_top#(parameter N=128, parameter Nr=10, parameter Nk=4)(in,key,out);
module Aes_top(in,key,out);
input[127:0] in;
//input[N-1:0] key;
input[127:0] key;
output [127:0] out;
//wire [(128*(Nr+1))-1:0] fullkeys;
wire [1407:0] fullkeys;
wire [127:0] states [11:0];
wire [127:0] after_subBytes;
wire [127:0] after_shiftRows;

//key_expansion #(Nr,N,Nk) ke (Nr,key,fullkeys);
key_expansion ke (4'b1010,key,fullkeys);
//num_round, input_key, output_key
//AddRoundKey addrk1(in, fullkeys[((128*(Nr+1))-1)-:128],states[0]);
AddRoundKey addrk1(in, fullkeys[1407-:128],states[0]);
genvar i;

generate

    //for(i=1;i<Nr;i=i+1)begin:loop
    for(i=1;i<10;i=i+1)begin:loop
        //encrypt_round er(states[i-1],fullkeys[(((128*(Nr+1))-1)-128*i)-:128],states[i]);
        encrypt_round er(states[i-1],fullkeys[(1407-128*i)-:128],states[i]);
        
        end
        SubBytes sub(in, after_subBytes);
        Shift_rows shift(after_subBytes,after_shiftRows);
        //AddRoundKey ark(after_shiftRows,fullkeys[127:0],states[Nr]);
        AddRoundKey ark(after_shiftRows,fullkeys[127:0],states[10]);
        assign out = states[10];
        
endgenerate
integer j;
always @* begin
#10;
$display("fullkeys: %h",fullkeys);
$display("Shift_rows: %h",after_shiftRows);
for (j = 0; j <= 10; j = j + 1) begin
        $display("states[%0d]: %h", j, states[j]);
    end
$display("AddRoundKey: %h",out);
end

endmodule
