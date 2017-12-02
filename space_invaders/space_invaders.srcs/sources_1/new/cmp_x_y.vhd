----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2017 20:57:15
-- Design Name: 
-- Module Name: cmp_x_y - Behavioral
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

entity cmp_x_y is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           cmp_x : out STD_LOGIC_VECTOR (9 downto 0);
           cmp_y : out STD_LOGIC_VECTOR (8 downto 0));
end cmp_x_y;

architecture Behavioral of cmp_x_y is

signal comp_x : integer range 0 to 639;
signal comp_y : integer range 0 to 479;

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if reset = '0' then
            comp_x <= 0;
            comp_y <= 0;
        elsif comp_x = 639 then
            comp_x <= 0;
            comp_y <= comp_y + 1;
        elsif comp_y = 479 then
            comp_x <= 0;
            comp_y <= 0;
        else
            comp_x <= comp_x + 1;
        end if;
    end if;
end process synchrone;

cmp_x <= std_logic_vector(to_unsigned(comp_x, 10));
cmp_y <= std_logic_vector(to_unsigned(comp_y, 9));

end Behavioral;
