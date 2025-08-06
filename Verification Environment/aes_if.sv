interface aes_if;
  logic clk;
  logic reset;
  logic start_encrypt;
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] ciphertext;
  logic encrypt_done;
  // Add an event for driver-monitor synchronization
  event driver_done_event;

endinterface
