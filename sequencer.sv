class sequencer extends uvm_sequencer#(sequence_item);
  
  `uvm_component_utils(sequencer);
  
  function new(string name="sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name," [SEQR] BUILD_PHASE " , UVM_NONE);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name," [SEQR] RUN_PHASE " , UVM_NONE);
  endtask
  
endclass