import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "test.sv"

module top;
  
  bit clk,reset;
  
  initial begin
    clk=0;
  end
  
  always #5 clk = ~clk;
  
  initial begin
    reset=1;
    #10 reset=0;
  end
  
  fifo_interface in(clk,reset);
  
  FIFO UUT(.clk(in.clk), .reset(in.reset), .w_en(in.w_en),
           .r_en(in.r_en), .data_in(in.data_in),
           .data_out(in.data_out), .counter(in.counter),
           .full(in.full), .empty(in.empty));
  
  initial begin
    uvm_config_db#(virtual fifo_interface)::set(uvm_root::get(),"*","vif",in);
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    run_test("test");
  end
  
endmodule