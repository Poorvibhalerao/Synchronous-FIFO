`include "sequence_item.sv"

class fifo_sequence extends uvm_sequence#(sequence_item);
  
  `uvm_object_utils(fifo_sequence)
  
  function new(string name="fifo_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    rsp = new();
    while(rsp.full != 1) begin
      $display("%t		[SEQUENCE] - Write sequence ",$time);
      req = new();
      start_item(req);
      assert(req.randomize() with {req.w_en==1;});
      finish_item(req);
      get_response(rsp);
//       $display("Data_in = %0d, W_en=%0d, R_en=%0d, Full=%0d, Empty=%0d",
//                req.data_in,req.w_en,req.r_en,rsp.full,rsp.empty);
    end
    
    while(rsp.empty != 1) begin
      $display("%t		[SEQUENCE] - Read sequence ",$time);
      req = new();
      start_item(req);
      assert(req.randomize() with{req.r_en==1;});
      finish_item(req);
      get_response(rsp);
//       $display("Data_in = %0d, W_en=%0d, R_en=%0d, Full=%0d, Empty=%0d, Data_out=%0d",
//                req.data_in,req.w_en,req.r_en,rsp.full,rsp.empty,req.data_out);
    end
    
  endtask
  
endclass