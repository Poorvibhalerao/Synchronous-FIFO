`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class agent extends uvm_agent;
  
  `uvm_component_utils(agent)
  
  sequencer	seqr;
  driver	drv;
  monitor	mtr;
  
  function new(string name="agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name," [AGENT] BUILD_PHASE " ,UVM_NONE);
    seqr=sequencer::type_id::create("seqr",this);
    drv=driver::type_id::create("drv",this);
    mtr=monitor::type_id::create("mtr",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass