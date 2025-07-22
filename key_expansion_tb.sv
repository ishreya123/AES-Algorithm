`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2025 11:06:32
// Design Name: Key expansion tb
// Module Name: key_expansion_tb
// Project Name: AES Encryption
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module key_expansion_tb;
reg [127:0] k1;
reg [3:0] num_round;
wire [127:0] out1;

key_expansion ks(num_round,k1,out1);

initial begin
$monitor("k=%h, out =%h",k1,out1);
k1 = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
for (num_round = 0; num_round < 10; num_round = num_round + 1) begin
        #10;
        $display("num_round %0d key: %h", num_round+1, out1);
        k1 = out1; // feed next key back as input
    end
    $finish;
end

endmodule
