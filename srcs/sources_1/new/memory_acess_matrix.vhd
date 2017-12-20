----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 11:31:52
-- Design Name: 
-- Module Name: memory_acess_matrix - Behavioral
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

entity memory_acess_matrix is
    Generic (   NMB_ROW : integer range 1 to 20;
                SIZE_X  : integer range 1 to 10;
                SIZE_Y  : integer range 1 to 10;
                LIMIT_X : integer range 1 to 1024;
                LIMIT_Y : integer range 1 to 1024);
    Port (      clk     : in STD_LOGIC;
                reset   : in STD_LOGIC;
                incr    : in STD_LOGIC;
                reset_cmp : in STD_LOGIC;
                x       : out STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                y       : out STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0));
end memory_acess_matrix;

architecture Behavioral of memory_acess_matrix is

signal cmp_x : integer range 0 to LIMIT_X-1;
signal cmp_y : integer range 0 to LIMIT_Y-1;
signal cmp_row : integer range 0 to NMB_ROW-1;

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if reset = '0' or reset_cmp = '1' then
            cmp_x <= 0;
            cmp_y <= 0;
            cmp_row <= 0;
        elsif incr = '1' then
            if cmp_y = LIMIT_Y-1 and cmp_x = LIMIT_X-1 and cmp_row = NMB_ROW-1 then
                cmp_x <= 0;
                cmp_y <= 0;
                cmp_row <= 0;
            elsif cmp_x = LIMIT_X-1 then
                if cmp_row = NMB_ROW-1 then
                    cmp_x <= 0;
                    cmp_y <= cmp_y + 1;
                    cmp_row <= 0;
                else
                    cmp_x <= 0;
                    cmp_row <= cmp_row + 1;
                end if;
            else
                cmp_x <= cmp_x + 1;
            end if;
        end if;
    end if;
end process synchrone;

x <= std_logic_vector(to_unsigned(cmp_x, SIZE_X));
y <= std_logic_vector(to_unsigned(cmp_y, SIZE_Y));

end Behavioral;
