class aes_sequence extends uvm_sequence #(aes_transaction);
  `uvm_object_utils(aes_sequence)

  function new(string name = "aes_sequence");
        super.new(name);
    endfunction


endclass
