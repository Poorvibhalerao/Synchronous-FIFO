`define MCB vif.MONITOR.monitor_cb

class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor);
  
  virtual fifo_interface vif;
  sequence_item pkt;
  
  uvm_analysis_port#(sequence_item)item_collected_port;
  
  function new(string name="monitor", uvm_component parent);
    super.new(name,parent);
    pkt = new();
    item_collected_port = new("item_collected_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name," [MONITOR] BUILD_PHASE " , UVM_NONE);
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif",vif)) begin
      `uvm_fatal("NO VIF",{"Virtual Interface must be set for : ",get_full_name,".vif"});
    end else
      `uvm_info(get_type_name,"[MON] [BUILD_P] Virtual interface obtained",UVM_NONE);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name,"[MONITOR] RUN_PHASE",UVM_NONE);
    forever begin
      @(`MCB);
      wait(`MCB.r_en==1 || `MCB.w_en==1) begin
        if(`MCB.w_en) begin
          pkt.w_en		<=`MCB.w_en;
          pkt.data_in	<=`MCB.data_in;
          pkt.full		<=`MCB.full;
          @(`MCB);
        end
        if(`MCB.r_en) begin 
          pkt.r_en		<=`MCB.r_en;
          pkt.w_en		<=`MCB.w_en;
          @(`MCB)
          pkt.empty		<=`MCB.empty;
          pkt.data_out	<=`MCB.data_out;
        end
        item_collected_port.write(pkt);
      end
    end
  endtask
    
endclass