
version: 3

Orient: R270
Pad: PcornerLL SW PADSPACE_C_74x74u_CH
Orient: R0x3
Pad: PcornerLR SE PADSPACE_C_74x74u_CH
Orient: R90
Pad: PcornerUR NE PADSPACE_C_74x74u_CH
Orient: R180
Pad: PcornerUL NW PADSPACE_C_74x74u_CH


# # ------------------------------------------------ #
# # NORTH
# # ------------------------------------------------ #

Pad: PGND1         N CPAD_S_74x50u_IN
Pad: spi_mode_pad1 N CPAD_S_74x50u_IN
Pad: spi_mode_pad2 N CPAD_S_74x50u_IN
Pad: spi_sdo_pad1  N CPAD_S_74x50u_IN
Pad: spi_sdo_pad2  N CPAD_S_74x50u_VDD
Pad: spi_sdo_pad3  N CPAD_S_74x50u_VDD
Pad: spi_sdo_pad4  N CPAD_S_74x50u_IN
Pad: PGND2         N CPAD_S_74x50u_IN

# # ------------------------------------------------ #
# # WEST 
# # ------------------------------------------------ #
Pad: spi_clk_pad   W CPAD_S_74x50u_IN
Pad: spi_cs_pad    W CPAD_S_74x50u_IN
Pad: spi_sdi_pad1  W CPAD_S_74x50u_IN
Pad: spi_sdi_pad2  W CPAD_S_74x50u_IN
Pad: spi_sdi_pad3  W CPAD_S_74x50u_IN
Pad: spi_sdi_pad4  W CPAD_S_74x50u_IN
Pad: rst_pad       W CPAD_S_74x50u_IN
Pad: clk_pad       W CPAD_S_74x50u_IN
# # ------------------------------------------------ #
# # SOUTH
# # ------------------------------------------------ #

Pad: PVDD1         S CPAD_S_74x50u_OUT
Pad: fetch_pad     S CPAD_S_74x50u_OUT
Pad: testmode_pad  S CPAD_S_74x50u_OUT
Pad: trstn_pad     S CPAD_S_74x50u_OUT
Pad: tms_pad       S CPAD_S_74x50u_GND
Pad: tdi_pad       S CPAD_S_74x50u_GND
Pad: tdo_pad       S CPAD_S_74x50u_OUT
Pad: PVDD2         S CPAD_S_74x50u_OUT

# # ------------------------------------------------ #
# # EAST 
# # ------------------------------------------------ #

Pad: tck_pad       E CPAD_S_74x50u_IN
Pad: uart_rx_pad   E CPAD_S_74x50u_IN
Pad: uart_cts_pad  E CPAD_S_74x50u_IN
Pad: uart_dsr_pad  E CPAD_S_74x50u_OUT
Pad: uart_tx_pad   E CPAD_S_74x50u_OUT
Pad: uart_rts_pad  E CPAD_S_74x50u_OUT
Pad: uart_dtr_pad  E CPAD_S_74x50u_OUT
Pad: gpio_pad      E CPAD_S_74x50u_OUT


