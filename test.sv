`include "sequence.sv"
`include "environment.sv"

class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  environment env;
  fifo_sequence seq;
  
  function new(string name="test",uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name,"BUILD PHASE",UVM_NONE);
    env=environment::type_id::create("env", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    //fifo_sequence seq; // works 
    super.run_phase(phase);
    `uvm_info(get_type_name,"RUN PHASE",UVM_NONE)
    //fifo_sequence seq; // give error if super or info is written above.
    seq=fifo_sequence::type_id::create("seq");
    phase.raise_objection(this);
    $display("%t [TEST] Starting Sequence in [RUN_PHASE]",$time);
    seq.start(env.agnt.seqr);
    phase.drop_objection(this);
  endtask
  
endclass
  