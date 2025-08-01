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
module Aes_top(reset,in,key,out);

input reset;
input[127:0] in;
//input[N-1:0] key;
input[127:0] key;
output  [127:0] out;

parameter Nr=10;
parameter Nk=4;

wire [(128*(Nr+1))-1:0] fullkeys;
//wire [1407:0] fullkeys;
wire [127:0] states [Nr+1:0];
wire [127:0] after_subBytes;
wire [127:0] after_shiftRows;

//key_expansion #(Nr,N,Nk) ke (Nr,key,fullkeys);
key_expansion #(Nk, Nr) ke (key,fullkeys);
//num_round, input_key, output_key
AddRoundKey addrk1(in, fullkeys[128*Nr+:128],states[0]);
//AddRoundKey addrk1(in, fullkeys[1407-:128],states[0]);


genvar i;

generate

    for(i=1;i<Nr;i=i+1)begin:loop
    //for(i=1;i<10;i=i+1)begin:loop
        encrypt_round er(states[i-1],fullkeys[(((128*(Nr+1))-1)-128*i)-:128],states[i]);
        //encrypt_round er(states[i-1],fullkeys[(1407-(128*i))-:128],states[i]);
        end
        
        SubBytes sub(states[Nr-1], after_subBytes);
        Shift_rows shift(after_subBytes,after_shiftRows);
        //AddRoundKey ark(after_shiftRows,fullkeys[127:0],states[Nr]);
        AddRoundKey ark(after_shiftRows,fullkeys[127:0],states[Nr]);
    
endgenerate

assign out = (reset) ? 128'd0 : states[Nr];

initial begin
#10;
$monitor ("Round keys (full keys)= %h",fullkeys);
$monitor ("Subbytes keys (sub bytes)= %h",after_subBytes);
$monitor ("After Shiftrows = %h", after_shiftRows);
$monitor ("Final output = %h", out);
end

endmodule
