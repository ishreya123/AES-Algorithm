class aes_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(aes_scoreboard)
  uvm_analysis_imp #(aes_transaction, aes_scoreboard) monitor_imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor_imp = new("monitor_imp", this);
  endfunction
  
   function void write(aes_transaction t);
    // scoreboard code
  endfunction
endclass
