class sequence_item extends uvm_sequence_item;
  
  rand bit[7:0] data_in;
  rand bit r_en;
  rand bit w_en;
  
  bit full, empty;
  bit [7:0] data_out;
  
  `uvm_object_utils_begin(sequence_item)
  	`uvm_field_int(data_in,UVM_ALL_ON);
  	`uvm_field_int(r_en,UVM_ALL_ON);
  	`uvm_field_int(w_en,UVM_ALL_ON);
  	`uvm_field_int(full,UVM_ALL_ON);
  	`uvm_field_int(empty,UVM_ALL_ON);
  	`uvm_field_int(data_out,UVM_ALL_ON);
  `uvm_object_utils_end
  
  constraint C1 { w_en != r_en; };
  
  function void pre_randomize();
    if(r_en)
      data_in.rand_mode(0);
  endfunction
  
  function new(string name="sequence_item");
    super.new(name);
  endfunction
  
endclass
  