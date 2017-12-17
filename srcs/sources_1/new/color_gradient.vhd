----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2017 14:09:08
-- Design Name: 
-- Module Name: color_gradient - Behavioral
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

entity color_gradient is
    Generic (   SIZE_X  : integer range 1 to 12 := 8;
                SIZE_Y  : integer range 1 to 12 := 8;
                BITS_PER_PIXEL : integer range 1 to 12 := 12;
                INCR    : integer range 1 to 1000 := 7);               
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pix_x : in STD_LOGIC_VECTOR(SIZE_X-1 downto 0);
           pix_y : in STD_LOGIC_VECTOR (SIZE_Y-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (BITS_PER_PIXEL-1 downto 0));
end color_gradient;

architecture Behavioral of color_gradient is

signal pixel : integer range 0 to 2**BITS_PER_PIXEL-1;

begin

synchrone : process(clk, reset)
begin
    if reset = '0' then
        pixel <= 0;
    elsif rising_edge(clk) then
        pixel <= (to_integer(unsigned(pix_x))+to_integer(unsigned(pix_y)))*INCR;
    end if;
end process synchrone;

data_out <= std_logic_vector(to_unsigned(pixel, BITS_PER_PIXEL));

end Behavioral;
