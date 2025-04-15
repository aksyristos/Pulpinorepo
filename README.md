## Grade 3

**Step 1)** Run HelloWorld ✔️

**Step 2)** Create and run with ram wrapper and verify it uses all 32kb. ✔️

To integrate, replace sr_ram_wrap.sv and sp_ram.sv with the ones here. Vcompile_pulpino.sh needs to be changed accordingly due to the difference between .sv and .v

**Step 3)** Switch to external clk source ✔️

**Step 4)** Remove peripherals✔️, add top with pads ✔️

**Step 5)** Define seperate clk domains (added in synthesis)✔️

**Step 5)** Synthesis✔️

Had to change dc_data_buffer.v and add a seperate testbench for the padded top. 
WARNING: If you want the simulation to print the RX string, DON'T comment out the ifdef VERILATOR in peripherals.sv and use the initial design_setup.tcl. 
Otherwise you don't use all apb_uart.* files in the design.tcl and thus, change apb_uart.sv to remove an additional generated latch by adding 
```
always_comb
begin
    fifo_tx_data = 8'b0000_0000; #this line
    if (PSEL && PENABLE && PWRITE)
      begin
```

**Step 6)** PnR

**Step 9)** Performance (matrix multiplication A[4][8]*C[8][4])

Runtime on accelerator :    750 713 ps<br>
Runtime on core        : 23 240 000 ps

