class aes_monitor extends uvm_monitor;
  `uvm_component_utils(aes_monitor)

  uvm_analysis_port#(aes_transaction) mon_ap;
  aes_transaction req;
  virtual aes_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_ap = new("mon_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db#(virtual aes_if)::get(this, "", "vif", vif)) begin
    `uvm_fatal("AES_MONITOR", "Failed to get virtual interface from config DB")
  end
  `uvm_info("AES_MONITOR", "Entered build phase", UVM_NONE);
endfunction

  task run_phase(uvm_phase phase);
    forever begin
      // Wait for changes in ciphertext (simple combinational trigger)
      @(vif.driver_done_event);
      $display("Monitor saw driver_done_event at time %t", $time);
      `uvm_info("AES_MON_DEBUG", $sformatf("Event seen.  plaintext=%h key=%h ciphertext=%h", vif.plaintext, vif.key, vif.ciphertext), UVM_NONE)
      req = aes_transaction::type_id::create("req",this);
      req.plaintext = vif.plaintext;
      req.key = vif.key;
      req.ciphertext = vif.ciphertext;
          `uvm_info("AES_MON_DEBUG", $sformatf("Event seen.  plaintext=%h key=%h ciphertext=%h", req.plaintext, req.key, req.ciphertext), UVM_NONE)
      mon_ap.write(req);
      `uvm_info("AES_MONITOR","Transaction captured and published.",UVM_NONE);
    
    end
  endtask

endclass
