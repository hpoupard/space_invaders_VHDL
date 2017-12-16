----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2017 23:11:57
-- Design Name: 
-- Module Name: universal_delay - Behavioral
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

entity universal_delay is
    Generic (   SIZE_DATA   : integer range 1 to 20 := 12;
                DELAY       : integer range 1 to 50 := 10);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (SIZE_DATA-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (SIZE_DATA-1 downto 0));
end universal_delay;

architecture Behavioral of universal_delay is

type MEMORY is array (0 to DELAY-2) of std_logic_vector(SIZE_DATA - 1 downto 0);
signal mem : MEMORY;

begin

synchrone : process(clk, reset)
begin
    if reset = '0' then
        for I in 0 to DELAY-2 loop
            mem(I) <= std_logic_vector(to_unsigned(0, SIZE_DATA));
        end loop;
        data_out <= std_logic_vector(to_unsigned(0, SIZE_DATA));
    elsif rising_edge(clk) then
        if DELAY = 1 then
            data_out <= data_in;
        else
            data_out <= mem(DELAY-2);
                for I in 1 to DELAY-2 loop
                    mem(I) <= mem(I-1);
                end loop;
            mem(0) <= data_in;
        end if;
    end if;
end process synchrone;

end Behavioral;
