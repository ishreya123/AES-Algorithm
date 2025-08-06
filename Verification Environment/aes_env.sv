class aes_env extends uvm_env;
  `uvm_component_utils(aes_env)

  aes_agent agent;
  aes_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info("AES_ENV", "Entered build phase", UVM_LOW);
    agent = aes_agent::type_id::create("agent", this);
    scoreboard = aes_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    agent.monitor.mon_ap.connect(scoreboard.item_export);
    `uvm_info("AES_ENV", "Monitor to scoreboard connection done", UVM_NONE);
  endfunction

endclass
