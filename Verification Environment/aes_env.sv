class aes_env extends uvm_env;
  `uvm_component_utils(aes_env)
    aes_agent agent;
    aes_scoreboard sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      	`uvm_info("AES_ENV","Entered build phase",UVM_NONE);
        agent = aes_agent::type_id::create("agent", this);
        sb = aes_scoreboard::type_id::create("sb", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
      agent.mon.ap.connect(sb.monitor_imp);
        `uvm_info("AES_ENV","Connection between monitor and scoreboard is done",UVM_NONE);
    endfunction
endclass
