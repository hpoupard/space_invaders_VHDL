----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2017 16:21:45
-- Design Name: 
-- Module Name: clock_affichage - Behavioral
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

entity clock_affichage is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_aff : out STD_LOGIC);
end clock_affichage;

architecture Behavioral of clock_affichage is

signal compteur : unsigned(20 downto 0):= to_unsigned(0, 21);

begin

    clk_affichage : process(clk)
    begin
        if (rising_edge(clk)) then
            if reset = '1' then
                compteur <= to_unsigned(0, 21);
                clk_aff <= '0';
            elsif compteur = 1666667 then
                compteur <= to_unsigned(0, 21);
                clk_aff <= '1';
            else
                compteur <= compteur + 1;
                clk_aff <= '0';
            end if;
        end if;
    end process clk_affichage;
    
end Behavioral;
