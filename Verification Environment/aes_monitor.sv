class aes_monitor extends uvm_monitor;
  `uvm_component_utils(aes_monitor)
  
    //virtual fifo_if vif;
  
  uvm_analysis_port #(aes_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      `uvm_info("AES_MONITOR","Entered build phase",UVM_NONE);
        //if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
          //  `uvm_fatal("NOVIF", "No virtual interface specified for monitor")
      ap = new("ap", this);
    endfunction


endclass
