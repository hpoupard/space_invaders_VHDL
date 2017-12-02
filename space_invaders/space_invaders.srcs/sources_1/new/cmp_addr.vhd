----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2017 13:56:31
-- Design Name: 
-- Module Name: cmp_addr - Behavioral
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

entity cmp_addr is
    Generic (
            SIZE_ADDR   : integer range 1 to 20 := 14;
            LIMIT_ADDR  : integer range 1 to 400000 := 16000);
    Port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            addr : out STD_LOGIC_VECTOR (SIZE_ADDR - 1 downto 0));
end cmp_addr;

architecture Behavioral of cmp_addr is

signal cmp : integer range 0 to LIMIT_ADDR - 1;

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if reset = '0' then
            cmp <= 0;
        else
            cmp <= cmp + 1;
        end if;
    end if;
end process synchrone;

addr <= std_logic_vector(to_unsigned(cmp, SIZE_ADDR));
            
end Behavioral;
