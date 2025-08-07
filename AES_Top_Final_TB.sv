`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2025 11:11:51
// Design Name: 
// Module Name: Aes_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Aes_top_tb;
    reg clk;
    reg reset;
    reg start_encrypt;
    reg [127:0] data_in;
    reg [127:0] key;
    wire [127:0] out;
    wire encrypt_done;

     //Instantiate DUT (Device Under Test)
    Aes_top dut (
        .clk(clk), .reset(reset), .start_encrypt(start_encrypt),
        .data_in(data_in), .key(key), .out(out), .encrypt_done(encrypt_done)
    );
    
    //aes_top1 dut (reset,clk,in,key,out);

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize all inputs
        reset = 1;
        start_encrypt = 0;
        data_in = 0;
        key = 0;

        // Hold reset for a few cycles
        #15;
        reset = 0;

        // Wait a clock, then apply stimulus
        #10;
        data_in = 128'h3243f6a8885a308d313198a2e0370734;
        key     = 128'h2b7e151628aed2a6abf7158809cf4f3c;
          
//          data_in = 128'h54776F204F6E65204E696E652054776F;
//          key     = 128'h5468617473206D79204B756E67204675;
          //expected output = 29c3505f571420f6402299b31a02d73a

        //One clock pulse to start_encrypt
        start_encrypt = 1;
        #10;
        start_encrypt = 0;

        // Monitor ciphertext (compare with: 3925841d02dc09fbdc118597196a0b32)
        $monitor ("At time %t: data_in=%h key=%h out=%h encrypt_done=%b",
                  $time, data_in, key, out, encrypt_done);

        #1000;
        $finish;
    end
endmodule


