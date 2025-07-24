class aes_agent extends uvm_agent;
  `uvm_component_utils(aes_agent)
  
    aes_driver drv;
    aes_monitor mon;
  uvm_sequencer #(aes_transaction) seqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("AES_AGENT","Entered build phase",UVM_NONE);
        drv = aes_driver::type_id::create("drv", this);
        mon = aes_monitor::type_id::create("mon", this);
      seqr = uvm_sequencer#(aes_transaction)::type_id::create("seqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
      `uvm_info("AES_AGENT","Connection between driver and sequencer is done",UVM_NONE);
    endfunction
endclass
