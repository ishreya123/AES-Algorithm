class aes_agent extends uvm_agent;
  `uvm_component_utils(aes_agent)

  aes_driver driver;
  aes_monitor monitor;
  uvm_sequencer#(aes_transaction) sequencer;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AES_AGENT", "Entered build phase", UVM_LOW);
    driver = aes_driver::type_id::create("driver", this);
    monitor = aes_monitor::type_id::create("monitor", this);
    sequencer = uvm_sequencer#(aes_transaction)::type_id::create("sequencer", this);
    `uvm_info("AES_AGENT", "Entered build phase", UVM_LOW);
  endfunction

  function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    `uvm_info("AES_AGENT", "Driver port and sequencer connection is done ", UVM_LOW);
  endfunction

endclass
