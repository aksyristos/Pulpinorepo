library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_module is
	Port(clock,reset,start: in  std_logic;
	     activation:in unsigned(7 downto 0);
	     weights:in unsigned(71 downto 0);
		 P_out : out std_logic_vector (8 downto 0);
		 finish : out std_logic
		 );
end main_module;

architecture Behavioral of main_module is


component convolver is
  Port (clk,global_rst,ce:in std_logic;
        activation:in unsigned(7 downto 0);
        weight1:in unsigned(71 downto 0);
        conv_op:out unsigned(17 downto 0);
	valid_conv,end_conv:out std_logic);
end component;


component ram_ctrl is
  Port (    clk: in std_logic;
    rst: in std_logic;
    load: in std_logic;
    start_read: in std_logic;
    read_data_sram: in std_logic_vector(31 downto 0);
    ready_sram: in std_logic;
    product: in unsigned(17 downto 0);
    dataRAM: out std_logic_vector(31 downto 0);
    read_data_out: out std_logic_vector(8 downto 0);
    addressRAM: out std_logic_vector(10 downto 0);
    web: out std_logic;
    load_done: out std_logic);
end component;

component sram_wrapper is
    Port (clk: in std_logic;
        cs_n: in std_logic;  -- Active Low
        we_n: in std_logic;  --Active Low
        address: in std_logic_vector(10 downto 0);
        ry: out std_logic;
        write_data: in std_logic_vector(31 downto 0);
        read_data: out std_logic_vector(31 downto 0)
    );
end component;


signal output:unsigned(17 downto 0);
signal valid,endc: std_logic;

signal web: std_logic;
signal cs_n: std_logic;
signal addressRAM: std_logic_vector(10 downto 0);
signal dataRAM: std_logic_vector(31 downto 0);
--signal loadRAM : STD_LOGIC;
signal load_done:  std_logic;
signal readysram: std_logic;
signal read_ram_data: std_logic_vector(31 downto 0);

begin

cs_n<='0';
--calc_fall<='0';
--calc<='0';

input:convolver
port map(
         clk=>clock,
         global_rst=>reset,
         ce=>start,
         valid_conv=>valid,
         end_conv=>endc,
         activation=>activation,
	 weight1=>weights,
	 conv_op=>output
         );

 

ram_state:ram_ctrl
port map (
            clk => clock,
            rst => reset,
            product => output,
            dataRAM => dataRAM,
            addressRAM => addressRAM,
            web => web,
            load => valid,
            start_read => endc,
            read_data_sram => read_ram_data,
            read_data_out => P_out,
            ready_sram => readysram,
            load_done => load_done 
            );
            
SRAM: sram_wrapper
        port map(
            clk => clock,
            cs_n => cs_n,
            we_n => web,
            address => addressRAM,
            ry => readysram,
            write_data => dataRAM,
            read_data => read_ram_data          
        );

finish <= endc;

end Behavioral;
