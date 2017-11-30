----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2017 13:33:30
-- Design Name: 
-- Module Name: impul_y - Behavioral
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

entity impul_y is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           cmp_y : in STD_LOGIC_VECTOR (8 downto 0);
           impul_y : out STD_LOGIC);
end impul_y;

architecture Behavioral of impul_y is

signal mem1 : unsigned (8 downto 0);
signal mem2 : unsigned (8 downto 0);

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if reset = '0' then
            mem1 <= to_unsigned(0, 9);
            mem2 <= to_unsigned(0, 9);
        else
            mem1 <= unsigned(cmp_y);
            mem2 <= mem1;
        end if;
    end if;
end process synchrone;

asynchrone : process(mem1, mem2)
begin
    if mem1 /= mem2 then
        impul_y <= '1';
    else
        impul_y <= '0';
    end if;
end process asynchrone;

end Behavioral;
