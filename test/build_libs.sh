vlib ./MEMORY
vmap MEMORY ./MEMORY
vlog -work MEMORY /usr/local-eit/cad2/cmpstm/oldmems/mem2010/SPHDL100909-40446@1.0/behaviour/verilog/SPHDL100909.v

vlib ./PADS
vmap PADS ./PADS
vlog -work PADS /usr/local-eit/cad2/cmpstm/dicp18/lu_pads_65nm/PADS_Jun2013.v

vlib ./CLOCK65LPLVT
vmap CLOCK65LPLVT ./CLOCK65LPLVT
vlog -work CLOCK65LPLVT /usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPLVT_3.1/behaviour/verilog/CLOCK65LPLVT.v

vlib ./CORE65LPLVT
vmap CORE65LPLVT ./CORE65LPLVT
vlog -work CORE65LPLVT /usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPLVT_5.1/behaviour/verilog/CORE65LPLVT.v
