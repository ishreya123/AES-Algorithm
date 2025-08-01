`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2025 16:22:44
// Design Name: AES Top Testbench
// Module Name: Aes_top_tb
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


module Aes_top_tb;
    reg reset;
    reg [0:127] in;
    reg [0:127] key;
    wire [0:127] out;
    
    Aes_top dut (reset,in,key,out);
    
    initial begin
    reset = 1;
//   in= 128'h54686973206973203132336269746573;
//   key= 128'h4d795365637265744b65793030313233;

    in=128'h3243f6a8885a308d313198a2e0370734;
    key=128'h2b7e151628aed2a6abf7158809cf4f3c;
     $monitor ("in= %h,key= %h, out= %h",in,key,out);
#10;
reset=0;    
    end

endmodule
