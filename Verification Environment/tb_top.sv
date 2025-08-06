 `timescale 1ns / 1ps

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "aes_transaction.sv"      
`include "aes_sequence.sv"
`include "aes_driver.sv"
`include "aes_monitor.sv"
`include "aes_scoreboard.sv"
`include "aes_agent.sv"
`include "aes_env.sv"
`include "aes_test.sv"

module top;
   // Interface instantiation
  aes_if aes_intf();

  //Design instantiation
  Aes_top dut(
    .clk(aes_intf.clk),
    .reset(aes_intf.reset),
    .start_encrypt(aes_intf.start_encrypt),
    .data_in(aes_intf.plaintext),
    .key(aes_intf.key),
    .out(aes_intf.ciphertext),
    .encrypt_done(aes_intf.encrypt_done)
  );

  always #5 aes_intf.clk = ~aes_intf.clk;
  initial begin
    
    aes_intf.clk = 0;
    aes_intf.reset = 1;
    #10;
    aes_intf.reset = 0;
  end

  initial begin
    // Use same key in config_db get/set
    uvm_config_db #(virtual aes_if)::set(null, "*", "vif", aes_intf);
    `uvm_info("TOP", "Entered the top", UVM_NONE);
    run_test("aes_test");
    #1000; // Allow time for test to run
    $finish();
  end
  
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0,top);
    end
endmodule
