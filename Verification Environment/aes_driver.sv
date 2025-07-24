class aes_driver extends uvm_driver #(aes_transaction);
  `uvm_component_utils(aes_driver)
    //virtual fifo_if vif;

  function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      `uvm_info("AES_DRIVER","Entered build phase",UVM_NONE);
        //if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
          //  `uvm_fatal("NOVIF", "No virtual interface specified for driver")
    endfunction

endclass
