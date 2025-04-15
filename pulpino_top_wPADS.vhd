library ieee;
use ieee.std_logic_1164.all;

entity pulpino_top_wPADS is
    Port (
        -- Clock and Reset
        clkp             : in  std_logic;
        rst_np           : in  std_logic;
        testmode_ip      : in  std_logic;
        fetch_enable_ip  : in  std_logic;

        -- SPI Slave
        spi_clk       : in  std_logic;
        spi_cs_ip        : in  std_logic;
        spi_sdi0_ip      : in  std_logic;
        spi_sdi1_ip      : in  std_logic;
        spi_sdi2_ip      : in  std_logic;
        spi_sdi3_ip      : in  std_logic;
        spi_mode_op      : out std_logic_vector(1 downto 0);
        spi_sdo0_op      : out std_logic;
        spi_sdo1_op      : out std_logic;
        spi_sdo2_op      : out std_logic;
        spi_sdo3_op      : out std_logic;

        -- UART
        uart_txp         : out std_logic;
        uart_rxp         : in  std_logic;
        uart_rtsp        : out std_logic;
        uart_dtrp        : out std_logic;
        uart_ctsp        : in  std_logic;
        uart_dsrp        : in  std_logic;

        -- GPIO
        gpiop            : out std_logic;

        -- JTAG
        jtag_clk           : in  std_logic;
        trstn_ip         : in  std_logic;
        tms_ip           : in  std_logic;
        tdi_ip           : in  std_logic;
        tdo_op           : out std_logic
    );
end pulpino_top_wPADS;

architecture Behavioral of pulpino_top_wPADS is

    -- PAD Components
    component CPAD_S_74x50u_IN is
        Port (
            COREIO : out std_logic;
            PADIO  : in  std_logic
        );
    end component;

    component CPAD_S_74x50u_OUT is
        Port (
            COREIO : in  std_logic;
            PADIO  : out std_logic
        );
    end component;

    component pulpino_top is
	Port (
        -- Clock and Reset
        clk            : in  std_logic;
        rst_n          : in  std_logic;
        testmode_i     : in  std_logic;
        fetch_enable_i : in  std_logic;

        -- SPI Slave
        spi_clk_i      : in  std_logic;
        spi_cs_i       : in  std_logic;
        spi_sdi0_i     : in  std_logic;
        spi_sdi1_i     : in  std_logic;
        spi_sdi2_i     : in  std_logic;
        spi_sdi3_i     : in  std_logic;
        spi_mode_o    : out std_logic_vector(1 downto 0);
        spi_sdo0_o     : out std_logic;
        spi_sdo1_o     : out std_logic;
        spi_sdo2_o     : out std_logic;
        spi_sdo3_o     : out std_logic;

        -- UART
        uart_tx        : out std_logic;
        uart_rx        : in  std_logic;
        uart_rts       : out std_logic;
        uart_dtr       : out std_logic;
        uart_cts       : in  std_logic;
        uart_dsr       : in  std_logic;

        -- GPIO
        gpio           : out std_logic;

        -- JTAG
        tck_i          : in  std_logic;
        trstn_i        : in  std_logic;
        tms_i          : in  std_logic;
        tdi_i          : in  std_logic;
        tdo_o          : out std_logic
    );
end component;


    signal clk_pad, rst_pad, testmode_pad, fetch_pad      : std_logic;
    signal spi_clk_pad, spi_cs_pad                        : std_logic;
    signal spi_sdi_pad1 : std_logic;
    signal spi_sdi_pad2 : std_logic;
    signal spi_sdi_pad3 : std_logic;
    signal spi_sdi_pad4 : std_logic;
    --signal spi_mode_pad1 : std_logic;
    --signal spi_mode_pad2 : std_logic;
    signal spi_sdo_pad1  : std_logic;
    signal spi_sdo_pad2  : std_logic;
    signal spi_sdo_pad3  : std_logic;
    signal spi_sdo_pad4  : std_logic;
    signal uart_rx_pad, uart_cts_pad, uart_dsr_pad        : std_logic;
    signal uart_tx_pad, uart_rts_pad, uart_dtr_pad        : std_logic;
    signal gpio_pad                                      : std_logic;
    signal tck_pad, trstn_pad, tms_pad, tdi_pad, tdo_pad : std_logic;
    signal spi_mode_pad : std_logic_vector(1 downto 0);

begin
    
    --spi_mode_pad <= spi_mode_pad2 & spi_mode_pad1;
    --testmode_pad <= '0';

    clk_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => clk_pad,
        PADIO  => clkp
    );

    rst_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => rst_pad,
        PADIO  => rst_np
    );

--    testmode_pad_inst: CPAD_S_74x50u_IN
--    port map(
--        COREIO => testmode_pad,
--        PADIO  => testmode_ip
--    );

    fetch_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => fetch_pad,
        PADIO  => fetch_enable_ip
    );

    spi_clk_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => spi_clk_pad,
        PADIO  => spi_clk
    );

    spi_cs_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => spi_cs_pad,
        PADIO  => spi_cs_ip
    );

   
    spi_sdi_pad1_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => spi_sdi_pad1,
        PADIO  => spi_sdi0_ip
    );

    spi_sdi_pad2_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => spi_sdi_pad2,
        PADIO  => spi_sdi1_ip
    );

    spi_sdi_pad3_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => spi_sdi_pad3,
        PADIO  => spi_sdi2_ip
    );

    spi_sdi_pad4_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => spi_sdi_pad4,
        PADIO  => spi_sdi3_ip
    );

    spi_sdo_pad1_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => spi_sdo_pad1,
        PADIO  => spi_sdo0_op
    );

    spi_sdo_pad2_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => spi_sdo_pad2,
        PADIO  => spi_sdo1_op
    );

    spi_sdo_pad3_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => spi_sdo_pad3,
        PADIO  => spi_sdo2_op
    );

    spi_sdo_pad4_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => spi_sdo_pad4,
        PADIO  => spi_sdo3_op
    );

    spi_mode_pad1_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => spi_mode_pad(0),
        PADIO  => spi_mode_op(0)
    );

    spi_mode_pad2_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => spi_mode_pad(1),
        PADIO  => spi_mode_op(1)
    );


    uart_rx_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => uart_rx_pad,
        PADIO  => uart_rxp
    );

    uart_cts_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => uart_cts_pad,
        PADIO  => uart_ctsp
    );

    uart_dsr_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => uart_dsr_pad,
        PADIO  => uart_dsrp
    );

    uart_tx_pad_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => uart_tx_pad,
        PADIO  => uart_txp
    );

    uart_rts_pad_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => uart_rts_pad,
        PADIO  => uart_rtsp
    );

    uart_dtr_pad_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => uart_dtr_pad,
        PADIO  => uart_dtrp
    );

    gpio_pad_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => gpio_pad,
        PADIO  => gpiop
    );

    tck_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => tck_pad,
        PADIO  => jtag_clk
    );

    trstn_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => trstn_pad,
        PADIO  => trstn_ip
    );

    tms_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => tms_pad,
        PADIO  => tms_ip
    );

    tdi_pad_inst: CPAD_S_74x50u_IN
    port map(
        COREIO => tdi_pad,
        PADIO  => tdi_ip
    );

    tdo_pad_inst: CPAD_S_74x50u_OUT
    port map(
        COREIO => tdo_pad,
        PADIO  => tdo_op
    );

    pulpino_inst: pulpino_top
    port map(
        clk            => clk_pad,
        rst_n          => rst_pad,
        testmode_i    => '0',
        fetch_enable_i => fetch_pad,

        spi_clk_i      => spi_clk_pad,
        spi_cs_i       => spi_cs_pad,
        spi_mode_o     => spi_mode_pad,
        spi_sdo0_o     => spi_sdo_pad1,
        spi_sdo1_o     => spi_sdo_pad2,
        spi_sdo2_o     => spi_sdo_pad3,
        spi_sdo3_o     => spi_sdo_pad4,

        spi_sdi0_i     => spi_sdi_pad1,
        spi_sdi1_i     => spi_sdi_pad2,
        spi_sdi2_i     => spi_sdi_pad3,
        spi_sdi3_i     => spi_sdi_pad4,

        uart_tx        => uart_tx_pad,
        uart_rx        => uart_rx_pad,
        uart_rts       => uart_rts_pad,
        uart_dtr       => uart_dtr_pad,

        uart_cts       => uart_cts_pad,
        uart_dsr       => uart_dsr_pad,
        gpio           => gpio_pad,

        tck_i          => tck_pad,
        trstn_i        => trstn_pad,
        tms_i          => tms_pad,
        tdi_i          => tdi_pad,
        tdo_o          => tdo_pad
    );

end Behavioral;
