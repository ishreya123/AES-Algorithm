class aes_sequence extends uvm_sequence#(aes_transaction);
  `uvm_object_utils(aes_sequence)

  function new(string name = "aes_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_info("AES_SEQUENCE", "Starting aes_base_sequence...", UVM_LOW)
    repeat(1) begin
      aes_transaction seq_item = aes_transaction::type_id::create("seq_item");
      start_item(seq_item);
      seq_item.plaintext = 128'h3243f6a8885a308d313198a2e0370734;
      seq_item.key       = 128'h2b7e151628aed2a6abf7158809cf4f3c;
     // Set reference value!
      `uvm_warning("SEQ_ITEM_CHECK",$sformatf("PLAINTEXT: %h | KEY: %h ", seq_item.plaintext, seq_item.key));
      finish_item(seq_item);
    end
    `uvm_info("AES_SEQUENCE", "Finished aes_base_sequence.", UVM_LOW)
  endtask

endclass
