----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2017 18:59:46
-- Design Name: 
-- Module Name: acqui_mvt - Behavioral
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

entity acqui_mvt is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           btn_left : in STD_LOGIC;
           btn_right : in STD_LOGIC;
           left : out STD_LOGIC;
           right : out STD_LOGIC);
end acqui_mvt;

architecture Behavioral of acqui_mvt is

signal comp_left : integer range 0 to 99999;
signal comp_right : integer range 0 to 99999;

begin

synchrone : process(clk)
begin
if rising_edge(clk) then
    if reset = '0' then
        comp_left <= 0;
        comp_right <= 0;
    elsif btn_left = '1' and comp_left = 0 then
        left <= '1';
        right <= '0';
        comp_left <= 99999;
    elsif btn_right = '1' and comp_right = 0 then
        left <= '0';
        right <= '1';
        comp_right <= 99999;
    elsif comp_left > 0 then
        left <= '0';
        right <= '0';
        if comp_right > 0 then
            comp_left <= comp_left - 1;
            comp_right <= comp_right - 1;
        else
            comp_left <= comp_left - 1;
        end if;
    elsif comp_right > 0 then
        left <= '0';
        right <= '0';
        comp_right <= comp_right - 1;
    else
        left <= '0';
        right <= '0';
    end if;
end if;
end process synchrone;

end Behavioral;
