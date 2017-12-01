----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 19:23:16
-- Design Name: 
-- Module Name: clock_tir - Behavioral
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

entity clock_tir is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_tir : out STD_LOGIC);
end clock_tir;

architecture Behavioral of clock_tir is

signal compteur : integer range 0 to 1000000;

begin

clock_tir : process(clk)
begin
    if(rising_edge(clk)) then
        if reset = '0' then
            clk_tir <= '0';
            compteur <= 0;
        elsif compteur = 999999 then
            clk_tir <= '1';
            compteur <= 0;
        else
            compteur <= compteur + 1;
        end if;
    end if;
end process clock_tir;

end Behavioral;
