class aes_driver extends uvm_driver#(aes_transaction);
  `uvm_component_utils(aes_driver)

   // Analysis port to send the expected transaction to the scoreboard
  uvm_analysis_port#(aes_transaction) ap;

  virtual aes_if vif;
  

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    ap = new("ap", this);
  if (!uvm_config_db#(virtual aes_if)::get(this, "", "vif", vif)) begin
    `uvm_fatal("AES_DRIVER", "Failed to get virtual interface from config DB")
  end
  `uvm_info("AES_DRIVER", "Entered build phase", UVM_LOW);
endfunction


  task run_phase(uvm_phase phase);
    forever begin
      req = aes_transaction::type_id::create("req",this);
      seq_item_port.get_next_item(req);
      `uvm_info("AES_DRIVER", $sformatf("Driving new transaction:\n%s", req.sprint()), UVM_HIGH)
      do_drive(req);
      
      `uvm_info("AES_DRIVER_DEBUG", $sformatf(" plaintext=%h key=%h ciphertext=%h", vif.plaintext, vif.key, vif.ciphertext), UVM_NONE)
      seq_item_port.item_done();
    end
  endtask
  
  task do_drive(aes_transaction req);
     `uvm_info("DRIVE_CHECK", 
  $sformatf("Driving PLAINTEXT: %h | KEY: %h", req.plaintext, req.key), 
  UVM_NONE);
  vif.plaintext <= req.plaintext;
  vif.key      <= req.key;
 // vif.exp_ciphertext <= req.exp_ciphertext; // used for checking only

  // Wait 1 cycle for values to settle
  @(posedge vif.clk);

  // Assert start_encrypt
  vif.start_encrypt <= 1;
  @(posedge vif.clk);
  vif.start_encrypt <= 0;
  
  // Optionally wait for encrypt_done (if synchronous)
  wait (vif.encrypt_done == 1); // If present
  // Or add extra clocks to allow DUT to process

  -> vif.driver_done_event;
endtask


endclass
