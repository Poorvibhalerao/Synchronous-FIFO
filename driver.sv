`define DCB vif.DRIVER.driver_cb

class driver extends uvm_driver#(sequence_item);
  
  `uvm_component_utils(driver);
  
  virtual fifo_interface vif;
  sequence_item pkt;
  
  function new(string name="driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name," [DRIVER] BUILD_PHASE " , UVM_NONE);
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NO VIF",{"Virtual interface must be set for :",get_full_name,".vif"});
    end else
      `uvm_info(get_type_name," [DRIVER] [BUILD_P] Virtual interface obtained",UVM_NONE);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name," [DRIVER] RUN_PHASE " , UVM_NONE);
  	forever begin
      seq_item_port.get_next_item(pkt);
      @(posedge vif.DRIVER.clk);
      if(pkt.w_en) begin
        `DCB.data_in <= pkt.data_in;
        `DCB.w_en <= pkt.w_en;
        `DCB.r_en <= pkt.r_en;
        @(posedge vif.DRIVER.clk);
        `DCB.w_en <= 1'b0;
        pkt.full <= `DCB.full;
      end
      if(pkt.r_en) begin
        `DCB.w_en <= pkt.w_en;
        `DCB.r_en <= pkt.r_en;
        @(posedge vif.DRIVER.clk) begin //
        pkt.data_out <= `DCB.data_out;
        pkt.empty <= `DCB.empty;
        pkt.full <= `DCB.full;
        end //
      end
      @(posedge vif.DRIVER.clk);
      `DCB.w_en <= 1'b0;
      `DCB.r_en <= 1'b0;
      seq_item_port.item_done(pkt);
    end 
  endtask
      
endclass