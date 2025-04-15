# ALL values are in picosecond

set PERIOD 5000
set ClkTop $DESIGN
set ClkDomain $DESIGN
set ClkName clk
set ClkLatency 25
set ClkRise_uncertainty 500
set ClkFall_uncertainty 500
set ClkSlew 500
set InputDelay 2500
set OutputDelay 2500

# Remember to change the -port ClkxC* to the actual name of clock port/pin in your design

define_clock -name $ClkName -period $PERIOD -design $ClkTop -domain $ClkDomain [find / -port clk*]

set_attribute clock_network_late_latency "5 1000" $ClkName
set_attribute clock_source_late_latency "2.5 500" $ClkName 

set_attribute clock_setup_uncertainty 500 $ClkName
set_attribute clock_hold_uncertainty 250 $ClkName 

set_attribute slew_rise $ClkRise_uncertainty $ClkName 
set_attribute slew_fall $ClkFall_uncertainty $ClkName
 
external_delay -input $InputDelay  -clock [find / -clock $ClkName] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName] -name out_con [find /des* -port ports_out/*]

# SPI Slave clock
set PERIOD_SPI 100000
set ClkDomainSPI SPI
set ClkName_SPI spi_clk
set ClkLatencySPI 500
set ClkRise_uncertaintySPI 10000
set ClkFall_uncertaintySPI 10000
set ClkSlewSPI 10000
set InputDelaySPI 50000
set OutputDelaySPI 50000

define_clock -name $ClkName_SPI -period $PERIOD_SPI -design $ClkTop -domain $ClkDomainSPI [find / -port spi_clk*]

set_attribute clock_network_late_latency "100 20000" $ClkName_SPI
set_attribute clock_source_late_latency "50 10000" $ClkName_SPI 

set_attribute clock_setup_uncertainty 10000 $ClkName_SPI
set_attribute clock_hold_uncertainty 5000 $ClkName_SPI 

set_attribute slew_rise $ClkRise_uncertaintySPI $ClkName_SPI 
set_attribute slew_fall $ClkFall_uncertaintySPI $ClkName_SPI
 
external_delay -input $InputDelaySPI  -clock [find / -clock $ClkName_SPI] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelaySPI -clock [find / -clock $ClkName_SPI] -name out_con [find /des* -port ports_out/*]

# JTAG clock
set PERIOD_JTAG 100000
set ClkDomainJTAG JTAG
set ClkName_JTAG jtag_clk
set ClkLatencyJTAG 500
set ClkRise_uncertaintyJTAG 10000
set ClkFall_uncertaintyJTAG 10000
set ClkSlewJTAG 10000
set InputDelayJTAG 50000
set OutputDelayJTAG 50000

define_clock -name $ClkName_JTAG -period $PERIOD_JTAG -design $ClkTop -domain $ClkDomainJTAG [find / -port jtag_clk*]

set_attribute clock_network_late_latency "100 20000" $ClkName_JTAG
set_attribute clock_source_late_latency "50 10000" $ClkName_JTAG 

set_attribute clock_setup_uncertainty 10000 $ClkName_JTAG
set_attribute clock_hold_uncertainty 5000 $ClkName_JTAG 

set_attribute slew_rise $ClkRise_uncertaintyJTAG $ClkName_JTAG 
set_attribute slew_fall $ClkFall_uncertaintyJTAG $ClkName_JTAG
 
external_delay -input $InputDelayJTAG  -clock [find / -clock $ClkName_JTAG] -name in_con  [find /des* -port ports_in/*]
external_delay -output $OutputDelayJTAG -clock [find / -clock $ClkName_JTAG] -name out_con [find /des* -port ports_out/*]

set_clock_groups -asynchronous -group $ClkName -group $ClkName_SPI -group $ClkName_JTAG
