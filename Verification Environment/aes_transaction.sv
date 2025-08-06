class aes_transaction extends uvm_sequence_item;
  
  bit [127:0] plaintext;
  bit [127:0] key;
  bit [127:0] ciphertext;
  
  `uvm_object_utils_begin(aes_transaction)
    `uvm_field_int(plaintext, UVM_ALL_ON)
    `uvm_field_int(key, UVM_ALL_ON)
    `uvm_field_int(ciphertext, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "aes_transaction");
    super.new(name);
  endfunction
  
endclass
