
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

Pad: PGND1              N CPAD_S_74x50u_GND
Pad: spi_mode_pad1_inst N CPAD_S_74x50u_OUT
Pad: spi_mode_pad2_inst N CPAD_S_74x50u_OUT
Pad: spi_sdo_pad1_inst  N CPAD_S_74x50u_OUT
Pad: spi_sdo_pad2_inst  N CPAD_S_74x50u_OUT
Pad: spi_sdo_pad3_inst  N CPAD_S_74x50u_OUT
Pad: spi_sdo_pad4_inst  N CPAD_S_74x50u_OUT
Pad: PGND2              N CPAD_S_74x50u_GND

# # ------------------------------------------------ #
# # WEST 
# # ------------------------------------------------ #
Pad: spi_clk_pad_inst   W CPAD_S_74x50u_IN
Pad: spi_cs_pad_inst    W CPAD_S_74x50u_IN
Pad: spi_sdi_pad1_inst  W CPAD_S_74x50u_IN
Pad: spi_sdi_pad2_inst  W CPAD_S_74x50u_IN
Pad: spi_sdi_pad3_inst  W CPAD_S_74x50u_IN
Pad: spi_sdi_pad4_inst  W CPAD_S_74x50u_IN
Pad: rst_pad_inst       W CPAD_S_74x50u_IN
Pad: clk_pad_inst       W CPAD_S_74x50u_IN
# # ------------------------------------------------ #
# # SOUTH
# # ------------------------------------------------ #

Pad: PVDD1              S CPAD_S_74x50u_VDD
Pad: fetch_pad_inst     S CPAD_S_74x50u_IN
Pad: PGND3              S CPAD_S_74x50u_GND
Pad: trstn_pad_inst     S CPAD_S_74x50u_IN
Pad: tms_pad_inst       S CPAD_S_74x50u_IN
Pad: tdi_pad_inst       S CPAD_S_74x50u_IN
Pad: tdo_pad_inst       S CPAD_S_74x50u_OUT
Pad: PVDD2              S CPAD_S_74x50u_VDD

# # ------------------------------------------------ #
# # EAST 
# # ------------------------------------------------ #

Pad: tck_pad_inst       E CPAD_S_74x50u_IN
Pad: uart_rx_pad_inst   E CPAD_S_74x50u_IN
Pad: uart_cts_pad_inst  E CPAD_S_74x50u_IN
Pad: uart_dsr_pad_inst  E CPAD_S_74x50u_IN
Pad: uart_tx_pad_inst   E CPAD_S_74x50u_OUT
Pad: uart_rts_pad_inst  E CPAD_S_74x50u_OUT
Pad: uart_dtr_pad_inst  E CPAD_S_74x50u_OUT
Pad: gpio_pad_inst      E CPAD_S_74x50u_OUT

