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
    Generic (   SIZE_X : integer range 1 to 10;
                SIZE_Y : integer range 1 to 10;
                LIMIT_X : integer range 1 to 1023;
                LIMIT_Y : integer range 1 to 1023;
                SIZE_ADDR : integer range 1 to 20);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           cmp_x : out STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
           cmp_y : out STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
           addr : out STD_LOGIC_VECTOR(SIZE_ADDR - 1 downto 0));
end cmp_x_y;

architecture Behavioral of cmp_x_y is

signal comp_x : integer range 0 to LIMIT_X-1;
signal comp_y : integer range 0 to LIMIT_Y-1;
signal saddr : integer range 0 to LIMIT_X*LIMIT_Y-1;

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if reset = '0' then
            comp_x <= 0;
            comp_y <= 0;
            saddr <= 0;
        elsif comp_x = LIMIT_X-1 and comp_y = LIMIT_Y-1 then
            comp_x <= 0;
            comp_y <= 0;
            saddr <= 0;
        elsif comp_x = LIMIT_X-1 then
            comp_x <= 0;
            comp_y <= comp_y + 1;
            saddr <= saddr + 1;
        else
            comp_x <= comp_x + 1;
            saddr <= saddr + 1;
        end if;
    end if;
end process synchrone;

cmp_x <= std_logic_vector(to_unsigned(comp_x, SIZE_X));
cmp_y <= std_logic_vector(to_unsigned(comp_y, SIZE_Y));
addr <= std_logic_vector(to_unsigned(saddr, SIZE_ADDR));

end Behavioral;
