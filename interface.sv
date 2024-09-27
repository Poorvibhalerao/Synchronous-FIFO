interface fifo_interface(input logic clk,reset);
  
  logic w_en, r_en;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic [3:0] counter;
  logic full, empty;
  
  clocking driver_cb @(posedge clk);    
    output w_en, r_en;
    output data_in;
    input data_out;
    input counter;
    input full, empty;       
  endclocking
   
  clocking monitor_cb@(posedge clk);
    input w_en, r_en;
    input data_in;
    input data_out;
    input counter;
    input full, empty;
  endclocking
  
  modport DRIVER(clocking driver_cb, input clk,reset);
  modport MONITOR(clocking monitor_cb, input clk,reset);
  
endinterface