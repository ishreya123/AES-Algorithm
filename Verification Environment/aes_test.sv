class aes_test extends uvm_test;
  `uvm_component_utils(aes_test)
  
    aes_env env;
    aes_sequence seq;
  
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      `uvm_info("AES_TEST","Entered build phase",UVM_NONE);
        super.build_phase(phase);
        env = aes_env::type_id::create("env", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
    	uvm_top.print_topology();
    endfunction
  
endclass
