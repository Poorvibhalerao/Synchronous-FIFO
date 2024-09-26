# Synchronous-FIFO
 
The FIFO (First-In, First-Out) design is a memory-based circuit that stores data in the 
order it is received and outputs it in the same order. It has two pointers: one for writing 
data in and one for reading data out. The FIFO uses a clock to synchronize these 
operations and includes signals to indicate when it is full or empty. A reset signal can 
clear the memory and reset the pointers. This design helps manage data flow smoothly, 
especially when transferring data between different parts of a system. 
 |Signal name | Description |
|-------------|-------------|
| clk | Base clk |
| reset | Active high reset signal |
| w_en | Indicating fifo in write state |
| r_en | indication fifo in read state |
| data_out | 8-bit wide output data |
| data_in | 8-bit wide input data |
| counter | indicating the current position of FIFO memory |
| full | indicating fifo is full |
| empty | indicating fifo is empty |
