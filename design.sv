module FIFO(input clk,reset,w_en,r_en,
            input [7:0] data_in,
            output reg [7:0] data_out,
            output reg [3:0] counter,
            output reg full, empty);
  
  reg [2:0] w_ptr,r_ptr;
  
  reg [0:7] mem[0:7];
  
  assign empty = ( counter == 0 );
  assign full = ( counter == 4'd8 );
  
  ////////////////////////////////////////////////
  ////////////   For Counter Value   /////////////
  ////////////////////////////////////////////////
  
  always@(posedge clk) begin
    if(reset) counter <= 4'd0;
    
    else if(r_en && !empty) counter <= counter-1;
    
    else if(w_en && !full) counter <= counter+1;
    
    else counter <= counter;
  end
  
  ////////////////////////////////////////////////
  ////////////   For Read Operation  /////////////
  ////////////////////////////////////////////////
  
  always@(posedge clk) begin       
    if(reset) begin
      data_out <= 8'd0;
      foreach(mem[i]) mem[i] <= 8'd0;
    end
    else if(r_en && !empty) data_out <= mem[r_ptr];
    else
      data_out <= data_out;
  end
  
  ////////////////////////////////////////////////
  ///////////   For write Operation  /////////////
  ////////////////////////////////////////////////
  
  always@(posedge clk) begin       
    if(!reset) begin
      if(w_en && !full) mem[w_ptr] <= data_in;
    end
    else
      mem[w_ptr] <= mem[w_ptr];
  end
  
  ////////////////////////////////////////////////
  ///////////   For Pointer Value   //////////////
  ////////////////////////////////////////////////
  
  always@(posedge clk) begin
    if(reset) begin
      w_ptr <= 3'd0;
      r_ptr <= 3'd0;
    end
    else if(w_en && !full)	w_ptr <= w_ptr+1;
    else if(r_en && !empty)	r_ptr <= r_ptr+1;
    else begin
      w_ptr <= w_ptr;
      r_ptr <= r_ptr;
    end
  end
  
endmodule
            