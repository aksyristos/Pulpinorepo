# Tcl to store inputs, outputs, and registers stored into separate variables
set inp   [all_inputs -no_clocks]
set outp  [all_outputs]
set icgs  [filter_collection [all_registers] "is_integrated_clock_gating_cell == true"]
set regs  [remove_from_collection [all_registers -edge_triggered] $icgs]
set allregs  [all_registers]

# Create IO Path Groups
group_path   -name In2Reg       -from  $inp -to $allregs
group_path   -name Reg2Out      -from $allregs -to $outp

#Create REG Path Groups
group_path   -name Reg2Reg      -from $regs -to $regs
