# Modified by: Fuad Mammadzada
# Date: 27.01.2025
# 
# Modifications:
# 	* It includes building the libraries (CORE, CLOCK, MEMORY, PADS)
# 	* On top of launching the post-synthesis simulation, it can also launch 
# 	RTL simulation
# 	* More comments to explain the Makefile code for students to understand
# 	and modify it to their own needs.
#
#
# =========================================================================================================
# This Makefile is designed as a template to make QuestaSim compilation and simulation process automated
# run "make" command to run comp+sim for post-synth
# run "make rtl" to run comp+sim for RTL simulation
# edit paths and commands according to your needs, this is meant to be just a template

THISDIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Post-synthesis netlist file
PS_NETLIST_RTL = ../synthesis/outputs/pulpino_top_wPADS.sv

# Source files for RTL simulation 
#DESIGN_RTL = \
#	../hdl/my_awesome_design.vhd \
#	../hdl/sram_wrapper.vhd

# Testbench source files
SOURCES_TB =  \
	../pulpino/tb/tb_pads.sv  \
	../pulpino/tb/uart.sv  
#	../pulpino/tb/tb_jtag_pkg.sv  \
#	../pulpino/tb/tb_spi_pkg.sv



# Post-synthesis SDF file output
SDF_FILE = ../synthesis/outputs/pulpino_top_wPADS.sdf
ANNOTATE_WITH_SDF = -sdfmax :tb:top_i=$(SDF_FILE) +sdf_iopath_to_prim_ok

# OPTIMIZATION = -vopt
OPTIMIZATION = -novopt


## TARGETS
default: ps

echo_this_dir:
	echo $(THISDIR)

# Compilation 
compile_libs:
	./build_libs.sh

compile_rtl:
	vcom -work work $(DESIGN_RTL) # QuestaSim compiler for VHDL is "vcom"

compile_ps:
	vlog -work work $(PS_NETLIST_RTL) # QuestaSim compiler for Verilog is "vlog"

compile_tb:
	vlog -work work +incdir+../pulpino/rtl/includes $(SOURCES_TB)

# Simulation 
# vsim is the command to launch the QuestaSim window and set-up the simulation (it doesn't start running the simulation) 
ps: compile_libs compile_ps compile_tb
	export MODELSIM=$(THISDIR)/modelsim.ini && vsim +notimingchecks -L CLOCK65LPLVT -L CORE65LPLVT -L MEMORY -L PADS -L work -L work work.tb $(ANNOTATE_WITH_SDF) $(OPTIMIZATION)

# rtl is dependent on compile_libs, compile_rtl and compiles_tb, so running "make rtl" will actually run those targets as well 
rtl: compile_libs compile_rtl compile_tb
	export MODELSIM=$(THISDIR)/modelsim.ini && vsim -L CLOCK65LPLVT -L CORE65LPLVT -L MEMORY -L PADS -L work work.tb

clean:
	@cd $(THISDIR) && rm -rf $(THISDIR)/work
	@cd $(THISDIR) && rm -rf vsim.wlf
	@cd $(THISDIR) && rm -rf transcript
