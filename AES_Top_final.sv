`timescale 1ns / 1ps

module Aes_top(
    input logic clk,
    input logic reset,
    input logic start_encrypt,
    input logic [127:0] data_in,
    input logic [127:0] key,
    output logic [127:0] out,
    output logic encrypt_done
);

    parameter Nr = 10; //Number of rounds
    
    // Internal state signals for the combinational path
    logic [1407:0] fullkeys;
    logic [127:0] state_rounds [0:Nr];

    always_ff @(posedge clk) begin
        // Key expansion function is called 
        fullkeys <= key_expansion(key);
    end

    // The encryption is a single, large combinational block.
    // The result is ready in one clock cycle after start_encrypt.
    always_ff @(posedge clk) begin
        // Initial round: first AddRoundKey
        state_rounds[0] <= AddRoundKey(data_in, fullkeys[1407 -: 128]);

        // Standard rounds (1 to 9)
        state_rounds[1] <= encrypt_round(state_rounds[0], fullkeys[1407 - 128*1 -: 128]);
        state_rounds[2] <= encrypt_round(state_rounds[1], fullkeys[1407 - 128*2 -: 128]);
        state_rounds[3] <= encrypt_round(state_rounds[2], fullkeys[1407 - 128*3 -: 128]);
        state_rounds[4] <= encrypt_round(state_rounds[3], fullkeys[1407 - 128*4 -: 128]);
        state_rounds[5] <= encrypt_round(state_rounds[4], fullkeys[1407 - 128*5 -: 128]);
        state_rounds[6] <= encrypt_round(state_rounds[5], fullkeys[1407 - 128*6 -: 128]);
        state_rounds[7] <= encrypt_round(state_rounds[6], fullkeys[1407 - 128*7 -: 128]);
        state_rounds[8] <= encrypt_round(state_rounds[7], fullkeys[1407 - 128*8 -: 128]);
        state_rounds[9] <= encrypt_round(state_rounds[8], fullkeys[1407 - 128*9 -: 128]);

        // Final round (no MixColumns)
        state_rounds[10] <= final_round(state_rounds[9], fullkeys[1407 - 128*Nr -: 128]);
        
        // Final output
        out <= state_rounds[10];
    end
    
    logic out_reg_en;
    assign out_reg_en = start_encrypt;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            encrypt_done <= 0;
        end else if (out_reg_en) begin
            encrypt_done <= 1;
        end else begin
            encrypt_done <= 0;
        end
    end
    
    //=========================================================================================
    // Key Expansion 
    //=========================================================================================
    function automatic [1407:0] key_expansion(input logic [127:0] key);
        logic [31:0] W [0:43];
        integer i;
        
        // First 4 words
        W[0] = key[127:96];
        W[1] = key[95:64];
        W[2] = key[63:32];
        W[3] = key[31:0];
        
        //for next 40 words
        for (i = 4; i < 44; i = i + 1) begin
            if (i % 4 == 0)
                W[i] = W[i-4] ^ subword(rotword(W[i-1])) ^ rcon(i/4);
            else
                W[i] = W[i-4] ^ W[i-1];
        end
        
        // Reverse the concatenation to match the slicing 
        
        key_expansion = {
               W[0],W[1],W[2],W[3],W[4],W[5],W[6],W[7],W[8],W[9],W[10],W[11],
            W[12],W[13],W[14],W[15],W[16],W[17],W[18],W[19],W[20],W[21],W[22],
            W[23],W[24],W[25],W[26],W[27],W[28],W[29],W[30],W[31],W[32],W[33],
            W[34],W[35],W[36],W[37],W[38],W[39],W[40],W[41],W[42],W[43]
        };
    endfunction

    //1-byte circular left shift
    function automatic [31:0] rotword(input logic [31:0] x);
        rotword = {x[23:0], x[31:24]};
    endfunction

    function automatic [31:0] subword(input logic [31:0] x);
        subword[31:24] = sbox(x[31:24]);
        subword[23:16] = sbox(x[23:16]);
        subword[15:8]  = sbox(x[15:8]);
        subword[7:0]   = sbox(x[7:0]);
    endfunction

    function automatic [31:0] rcon(input integer r);
        case(r)
            1:  rcon = 32'h01000000; 2:  rcon = 32'h02000000; 3:  rcon = 32'h04000000; 4:  rcon = 32'h08000000;
            5:  rcon = 32'h10000000; 6:  rcon = 32'h20000000; 7:  rcon = 32'h40000000; 8:  rcon = 32'h80000000;
            9:  rcon = 32'h1b000000; 10: rcon = 32'h36000000; default: rcon = 32'h00000000;
        endcase
    endfunction

    //=========================================================================================
    // AES Round Functions
    //=========================================================================================

    // Standard round: SubBytes, ShiftRows, MixColumns, AddRoundKey
    function automatic [127:0] encrypt_round(input logic [127:0] data_in, input logic [127:0] k);
        encrypt_round = AddRoundKey(mix_columns(Shift_rows(subbytes(data_in))), k);
    endfunction

    // Final round: SubBytes, ShiftRows, AddRoundKey
    function automatic [127:0] final_round(input logic [127:0] data_in, input logic [127:0] k);
        final_round = AddRoundKey(Shift_rows(subbytes(data_in)), k);
    endfunction

    //======================= SubBytes ===========================
    function automatic [127:0] subbytes(input logic [127:0] in);
    logic [7:0] state[0:3][0:3], out_state[0:3][0:3];
    logic [127:0] out;
    int row, col;
    
    // Unpack in column-wise order
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            state[row][col] = in[127-8*(4*col+row) -: 8];
    // SubBytes
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            out_state[row][col] = sbox(state[row][col]);
    // Pack column-wise
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            out[127-8*(4*col+row) -: 8] = out_state[row][col];
    return out;
endfunction

    //======================= ShiftRows ===========================
    function automatic [127:0] Shift_rows(input logic [127:0] in);
    logic [7:0] state[0:3][0:3], out_state[0:3][0:3];
    logic [127:0] out;
    int row, col;
    // Unpack in column-wise order
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            state[row][col] = in[127-8*(4*col+row) -: 8];
    // ShiftRows operation
    for (row = 0; row < 4; row++)
        for (col = 0; col < 4; col++)
            out_state[row][col] = state[row][(col + row) % 4]; // left shift each row by its index
    // Pack in column-wise
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            out[127-8*(4*col+row) -: 8] = out_state[row][col];
    return out;
endfunction

// MixColumns multipliers
    function automatic [7:0] mb2(input [7:0] x);
        mb2 = (x[7] ? ((x << 1) ^ 8'h1b) : (x << 1));
    endfunction

    function automatic [7:0] mb3(input [7:0] x);
        mb3 = mb2(x) ^ x;
    endfunction

    //======================= MixColumns ===========================
    function automatic [127:0] mix_columns(input logic [127:0] in);
    logic [7:0] state[0:3][0:3], out_state[0:3][0:3];
    logic [127:0] out;
    int row, col;
    // Unpack in column-wise order
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            state[row][col] = in[127-8*(4*col+row) -: 8];
    // MixColumns per column
    for (col = 0; col < 4; col++) begin
        out_state[0][col] = mb2(state[0][col]) ^ mb3(state[1][col]) ^ state[2][col] ^ state[3][col];
        out_state[1][col] = state[0][col] ^ mb2(state[1][col]) ^ mb3(state[2][col]) ^ state[3][col];
        out_state[2][col] = state[0][col] ^ state[1][col] ^ mb2(state[2][col]) ^ mb3(state[3][col]);
        out_state[3][col] = mb3(state[0][col]) ^ state[1][col] ^ state[2][col] ^ mb2(state[3][col]);
    end
    // Pack in column-wise
    for (col = 0; col < 4; col++)
        for (row = 0; row < 4; row++)
            out[127-8*(4*col+row) -: 8] = out_state[row][col];
    return out;
endfunction

    //======================= AddRoundKey ===========================
    function automatic [127:0] AddRoundKey(input logic [127:0] a, input logic [127:0] b);
    AddRoundKey = a ^ b;
endfunction

    //======================= S-Box ===========================
    function automatic [7:0] sbox(input logic [7:0] in);
        const byte ROM [0:255] = '{
            8'h63,8'h7C,8'h77,8'h7B,8'hF2,8'h6B,8'h6F,8'hC5,8'h30,8'h01,8'h67,8'h2B,8'hFE,8'hD7,8'hAB,8'h76,
            8'hCA,8'h82,8'hC9,8'h7D,8'hFA,8'h59,8'h47,8'hF0,8'hAD,8'hD4,8'hA2,8'hAF,8'h9C,8'hA4,8'h72,8'hC0,
            8'hB7,8'hFD,8'h93,8'h26,8'h36,8'h3F,8'hF7,8'hCC,8'h34,8'hA5,8'hE5,8'hF1,8'h71,8'hD8,8'h31,8'h15,
            8'h04,8'hC7,8'h23,8'hC3,8'h18,8'h96,8'h05,8'h9A,8'h07,8'h12,8'h80,8'hE2,8'hEB,8'h27,8'hB2,8'h75,
            8'h09,8'h83,8'h2C,8'h1A,8'h1B,8'h6E,8'h5A,8'hA0,8'h52,8'h3B,8'hD6,8'hB3,8'h29,8'hE3,8'h2F,8'h84,
            8'h53,8'hD1,8'h00,8'hED,8'h20,8'hFC,8'hB1,8'h5B,8'h6A,8'hCB,8'hBE,8'h39,8'h4A,8'h4C,8'h58,8'hCF,
            8'hD0,8'hEF,8'hAA,8'hFB,8'h43,8'h4D,8'h33,8'h85,8'h45,8'hF9,8'h02,8'h7F,8'h50,8'h3C,8'h9F,8'hA8,
            8'h51,8'hA3,8'h40,8'h8F,8'h92,8'h9D,8'h38,8'hF5,8'hBC,8'hB6,8'hDA,8'h21,8'h10,8'hFF,8'hF3,8'hD2,
            8'hCD,8'h0C,8'h13,8'hEC,8'h5F,8'h97,8'h44,8'h17,8'hC4,8'hA7,8'h7E,8'h3D,8'h64,8'h5D,8'h19,8'h73,
            8'h60,8'h81,8'h4F,8'hDC,8'h22,8'h2A,8'h90,8'h88,8'h46,8'hEE,8'hB8,8'h14,8'hDE,8'h5E,8'h0B,8'hDB,
            8'hE0,8'h32,8'h3A,8'h0A,8'h49,8'h06,8'h24,8'h5C,8'hC2,8'hD3,8'hAC,8'h62,8'h91,8'h95,8'hE4,8'h79,
            8'hE7,8'hC8,8'h37,8'h6D,8'h8D,8'hD5,8'h4E,8'hA9,8'h6C,8'h56,8'hF4,8'hEA,8'h65,8'h7A,8'hAE,8'h08,
            8'hBA,8'h78,8'h25,8'h2E,8'h1C,8'hA6,8'hB4,8'hC6,8'hE8,8'hDD,8'h74,8'h1F,8'h4B,8'hBD,8'h8B,8'h8A,
            8'h70,8'h3E,8'hB5,8'h66,8'h48,8'h03,8'hF6,8'h0E,8'h61,8'h35,8'h57,8'hB9,8'h86,8'hC1,8'h1D,8'h9E,
            8'hE1,8'hF8,8'h98,8'h11,8'h69,8'hD9,8'h8E,8'h94,8'h9B,8'h1E,8'h87,8'hE9,8'hCE,8'h55,8'h28,8'hDF,
            8'h8C,8'hA1,8'h89,8'h0D,8'hBF,8'hE6,8'h42,8'h68,8'h41,8'h99,8'h2D,8'h0F,8'hB0,8'h54,8'hBB,8'h16
        };
        sbox = ROM[in];
    endfunction
endmodule
