class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard);
  
  uvm_analysis_imp#(sequence_item, scoreboard)item_collected_export;
  
  sequence_item que[$];
  int count=0;
  sequence_item pkt;
  bit[2:0] r_ptr;
  bit[2:0] w_ptr;
  bit[0:7] mem_sc[0:7];  
  
  function new(string name="scoreboard",uvm_component parent);
    super.new(name,parent);
    item_collected_export=new("item_collected_export",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name," [SCB] BUILD_PHASE ",UVM_NONE);
  endfunction
  
  function void write(sequence_item pkt1);
    $display("Data pushed in que");
    que.push_back(pkt1);
    $display("[write function] Pused data :: in::%0d :: out::%0d",pkt1.data_in,pkt1.data_out);
    `uvm_info(get_type_name,$sformatf("Data from pkt : %0d",pkt1.data_in),UVM_NONE);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name," [SCB] RUN_PHASE " , UVM_NONE);
    forever begin
      wait(que.size()>0) begin
        pkt=que.pop_front();
        $display("[RUN phase] data poped :: in::%0d :: out::%0d",pkt.data_in,pkt.data_out);
        $display("W_en = %0d :: r_en = %0d",pkt.w_en,pkt.r_en);
        if(pkt.w_en && count<8) begin
          mem_sc[w_ptr] = pkt.data_in;
          count++;
          w_ptr++;
        end
        if(pkt.r_en) begin   
          $display("%t Data in mem_sc[%0d] = %0d",$time,r_ptr,mem_sc[r_ptr]);
          $display("%t Data_out = %0d",$time,pkt.data_out);
          if(pkt.data_out == mem_sc[r_ptr]) begin
            `uvm_info(get_type_name,"--------- PASS -----------",UVM_NONE);
          end else if(pkt.data_out != mem_sc[r_ptr]) begin
            `uvm_info(get_type_name,"--------- FAIL -----------",UVM_NONE);
          end
          r_ptr++;
        end
        $display("Mem_SC :: %p",mem_sc);
      end
    end
  endtask
endclass