----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2024 03:06:20 PM
-- Design Name: 
-- Module Name: ram_ctrl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_ctrl is
Port (
    clk: in std_logic;
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
    load_done: out std_logic
    );
    
end ram_ctrl;

architecture Behavioral of ram_ctrl is
    type state_type is (s_idle, s_load, s_ram_reset, s_read);
    signal state_reg, state_next : state_type;
   
    signal address_reg, address_next: unsigned(10 downto 0);
    signal load_del,load_falling, load_rising: std_logic;
    signal read_out_reg, read_out_next: std_logic_vector(31 downto 0);

begin

    state_register: process(clk,rst)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state_reg <= s_ram_reset;
            else
                state_reg <= state_next;
            end if ;
        end if;       
    end process state_register;


    update_registers: process(clk,rst)
    begin
        if (rising_edge(clk)) then
            if (rst ='1') then
                address_reg <= (others => '0');
                read_out_reg <= (others => '0');
                load_del <= '0';
            else 
                address_reg <= address_next; 
                load_del <= load;  
                read_out_reg <= read_out_next;
            end if;    
        end if;
    end process update_registers;
        
    next_state_logic: process (start_read, state_reg, load, load_rising, load_falling, address_reg,
                               rst, read_data_sram, ready_sram, read_out_reg, product)
    begin
        state_next <= state_reg;
        address_next <= address_reg;
        read_out_next <= read_out_reg;
        load_done <= '0';
        dataRAM <= (others => '0');
        
        addressRAM <= std_logic_vector(address_reg);
        
        case state_reg is 
            
            when s_idle =>
                web  <= '1';
                dataRAM <= (others => '0');
                if (rst = '1') then
                    state_next <= s_ram_reset;
                elsif start_read = '1' then
                    address_next <= (others => '0');
                    state_next <= s_read;
                elsif load_rising = '1' then
                    state_next <= s_load;                
                else   
                    state_next <= s_idle;    
                end if;
                
            
            when s_load => 
                web <= '0';
                dataRAM <= "00000000000000" & std_logic_vector(product);
                address_next <= address_reg + 1;

                if start_read = '1' then
                    address_next <= (others => '0');
                    state_next <= s_read;  
                elsif load_falling = '1' then
                    state_next <= s_idle;             
                else   
                    state_next <= s_load;          
                end if;
                
            when s_ram_reset =>
                web <= '1';
                address_next <= address_reg + 1;          
                
                if (address_reg = 676) then
                    address_next <= (others => '0');
                    state_next <= s_idle;
                else
                    state_next <= s_ram_reset;
                end if;
                
            when s_read => 
                web <= '1';
                address_next <= address_reg + 1;
                if (ready_sram = '1') then
                    read_out_next <= read_data_sram;
                end if;
                
                if address_reg = 676 then		--changed from 319
                    state_next <= s_idle;
                else 
                    state_next <= s_read;
                end if;

        end case;
    end process next_state_logic;

    load_rising <= (not load_del) and load;
    load_falling <= load_del and (not load);
    read_data_out <= read_out_reg(8 downto 0);

end Behavioral;
