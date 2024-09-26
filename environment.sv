`include "agent.sv"
`include "scoreboard.sv"

class environment extends uvm_env;
  
  `uvm_component_utils(environment);
  
  scoreboard	scb;
  agent			agnt;
  
  function new(string name="environment",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name," [ENV] BUILD_PHASE",UVM_NONE)
    scb=scoreboard::type_id::create("scb",this);
    agnt=agent::type_id::create("agnt",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name,"[EVN] CONNECT_PHASE",UVM_NONE);
    agnt.mtr.item_collected_port.connect(scb.item_collected_export);
  endfunction
  
endclass