----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2017 09:56:48
-- Design Name: 
-- Module Name: clk_module - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_module is
    Generic (   NMB_CLK : integer range 1 to 100000000);
    Port (      clk     : in STD_LOGIC;
                reset   : in STD_LOGIC;
                clk_out : out STD_LOGIC);
end clk_module;

architecture Behavioral of clk_module is

signal cmp : integer range 0 to NMB_CLK - 1;

begin

synchrone : process(clk, reset)
begin
    if reset = '0' then
        cmp <= 0;
        clk_out <= '0';
    elsif rising_edge(clk) then
        if cmp = NMB_CLK - 1 then
            clk_out <= '1';
            cmp <= 0;
        else
            clk_out <= '0';
            cmp <= cmp + 1;
        end if;
    end if;
end process synchrone;

end Behavioral;
