class aes_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(aes_scoreboard)

  uvm_analysis_imp #(aes_transaction, aes_scoreboard) item_export;
  
  bit [127:0] exp_ciphertext= 128'h3925841d02dc09fbdc118597196a0b32;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("AES_SCOREBOARD","Entered build phase",UVM_NONE)
    super.build_phase(phase);
    item_export = new("item_export", this);
  endfunction

  function void write(aes_transaction t);
    `uvm_info("AES_SCOREBOARD","Entered write of scoreboard",UVM_NONE)
    `uvm_info("AES_SCB_DEBUG", 
              $sformatf("Comparing values: DUT_output = %h, Expected_output = %h", 
                        t.ciphertext, exp_ciphertext),
              UVM_LOW);

  // Use reduction XOR to check if any bit is X in the vectors
  if (t.ciphertext !== exp_ciphertext) begin
      `uvm_error("AES_SCB", $sformatf("Mismatch: expected = %h, got = %h", exp_ciphertext, t.ciphertext));
    end else begin
      `uvm_info("AES_SCB", "Encryption output correctly matches.", UVM_LOW);
    end
endfunction


endclass

