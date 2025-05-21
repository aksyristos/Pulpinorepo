#!/bin/tcsh
source ${PULP_PATH}/./vsim/vcompile/setup.csh

##############################################################################
# Settings
##############################################################################

set IP=apb_timer

##############################################################################
# Check settings
##############################################################################

# check if environment variables are defined
if (! $?MSIM_LIBS_PATH ) then
  echo "${Red} MSIM_LIBS_PATH is not defined ${NC}"
  exit 1
endif

if (! $?IPS_PATH ) then
  echo "${Red} IPS_PATH is not defined ${NC}"
  exit 1
endif

set LIB_NAME="${IP}_lib"
set LIB_PATH="${MSIM_LIBS_PATH}/${LIB_NAME}"
set IP_PATH="${IPS_PATH}/apb/apb_timer"
set RTL_PATH="${RTL_PATH}"

##############################################################################
# Preparing library
##############################################################################

echo "${Green}--> Compiling ${IP}... ${NC}"

rm -rf $LIB_PATH

vlib $LIB_PATH
vmap $LIB_NAME $LIB_PATH

##############################################################################
# Compiling RTL
##############################################################################

echo "${Green}Compiling component: ${Brown} apb_timer ${NC}"
echo "${Red}"

#example#vcom -quiet  -work ${LIB_PATH}   ${IP_PATH}/coefficients.vhd              || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/complete_controller.vhd       || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/control_unit.vhd              || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/input_control.vhd             || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/input_matrix.vhd              || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/main_module.vhd               || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/multiplier1.vhd               || goto error
#unused#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/output_registers.vhd          || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/ram_ctrl.vhd                  || goto error
#example#vcom -quiet  -work ${LIB_PATH}  ${IP_PATH}/sram_wrapper.vhd              || goto error
#example#vlog -quiet -sv -suppress 2583 -work ${LIB_PATH} ${IP_PATH}/SPHD110420.v           || goto error
#example#vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/apb_mmu.sv || goto error
    #vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/apb_timer.sv || goto error
    #vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/tmr.sv       || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/apb_convolver_wrapper.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/main_module_c.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/kernel.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/ctrl_unit.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/control_signals.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/result_register.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/wrapper_sram.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}     ${IP_PATH}/SPHS_151013.v || goto error

echo "${Cyan}--> ${IP} compilation complete! ${NC}"
exit 0

##############################################################################
# Error handler
##############################################################################

error:
echo "${NC}"
exit 1
