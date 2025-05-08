# ALL values are in picosecond

set PERIOD 5000
set ClkTop $DESIGN
set ClkDomain $DESIGN
set portin "uart_dsrp uart_ctsp uart_rxp fetch_enable_ip rst_np"
set portout "gpiop uart_dtrp uart_rtsp uart_txp"
set ClkName clk
set ClkLatency 250
set ClkRise_uncertainty 100
set ClkFall_uncertainty 100
set ClkSlew 25
set InputDelay 25
set OutputDelay 25

# Remember to change the -port ClkxC* to the actual name of clock port/pin in your design

define_clock -name $ClkName -period $PERIOD -design $ClkTop -domain $ClkDomain [find / -port clk*]

set_attribute clock_network_late_latency $ClkLatency $ClkName
set_attribute clock_source_late_latency  $ClkLatency $ClkName 

set_attribute clock_setup_uncertainty $ClkLatency $ClkName
set_attribute clock_hold_uncertainty $ClkLatency $ClkName 

set_attribute slew_rise $ClkRise_uncertainty $ClkName 
set_attribute slew_fall $ClkFall_uncertainty $ClkName
 
external_delay -input $InputDelay  -clock [find / -clock $ClkName] -name in_con1  [list $portin]
external_delay -output $OutputDelay -clock [find / -clock $ClkName] -name out_con1 [list $portout]

# SPI Slave clock
set PERIOD_SPI 100000
set ClkDomainSPI SPI
set portSPIin "spi_sdi3_ip spi_sdi2_ip spi_sdi1_ip spi_sdi0_ip spi_cs_ip"
set portSPIout "spi_mode_op[0] \ spi_mode_op[1] \ spi_sdo3_op spi_sdo2_op spi_sdo1_op spi_sdo0_op"
set ClkName_SPI spi_clk
set ClkLatencySPI 5000
set ClkRise_uncertaintySPI 500
set ClkFall_uncertaintySPI 500
set ClkSlewSPI 500
set InputDelaySPI 500
set OutputDelaySPI 500

define_clock -name $ClkName_SPI -period $PERIOD_SPI -design $ClkTop -domain $ClkDomainSPI [find / -port spi_clk*]

set_attribute clock_network_late_latency $ClkLatencySPI $ClkName_SPI
set_attribute clock_source_late_latency  $ClkLatencySPI $ClkName_SPI 

set_attribute clock_setup_uncertainty $ClkLatencySPI $ClkName_SPI
set_attribute clock_hold_uncertainty $ClkLatencySPI $ClkName_SPI 

set_attribute slew_rise $ClkRise_uncertaintySPI $ClkName_SPI 
set_attribute slew_fall $ClkFall_uncertaintySPI $ClkName_SPI
 
external_delay -input $InputDelaySPI  -clock [find / -clock $ClkName_SPI] -name in_con2  [list $portSPIin]
external_delay -output $OutputDelaySPI -clock [find / -clock $ClkName_SPI] -name out_con2 [list $portSPIout]

# JTAG clock
set PERIOD_JTAG 100000
set ClkDomainJTAG JTAG
set ClkName_JTAG jtag_clk
set portJTAGin "tdi_ip tms_ip trstn_ip"
set portJTAGout "tdo_op"
set ClkLatencyJTAG 5000
set ClkRise_uncertaintyJTAG 500
set ClkFall_uncertaintyJTAG 500
set ClkSlewJTAG 500
set InputDelayJTAG 500
set OutputDelayJTAG 500

define_clock -name $ClkName_JTAG -period $PERIOD_JTAG -design $ClkTop -domain $ClkDomainJTAG [find / -port jtag_clk*]

set_attribute clock_network_late_latency $ClkLatencyJTAG $ClkName_JTAG
set_attribute clock_source_late_latency  $ClkLatencyJTAG $ClkName_JTAG 

set_attribute clock_setup_uncertainty $ClkLatencyJTAG $ClkName_JTAG
set_attribute clock_hold_uncertainty $ClkLatencyJTAG $ClkName_JTAG

set_attribute slew_rise $ClkRise_uncertaintyJTAG $ClkName_JTAG 
set_attribute slew_fall $ClkFall_uncertaintyJTAG $ClkName_JTAG
 
external_delay -input $InputDelayJTAG  -clock [find / -clock $ClkName_JTAG] -name in_con3  [list $portJTAGin]
external_delay -output $OutputDelayJTAG -clock [find / -clock $ClkName_JTAG] -name out_con3 [list $portJTAGout]

set_clock_groups -asynchronous -group $ClkName -group $ClkName_SPI -group $ClkName_JTAG
