----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2017 18:49:35
-- Design Name: 
-- Module Name: gest_ennemis - Behavioral
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

entity gest_ennemis is
	Generic ( SIZE_X : integer range 0 to 10 := 8;
			  SIZE_X_SCREEN : integer range 160 to 640 := 320);
    Port ( clk : in STD_LOGIC;
           clk_e : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_offset_e : out STD_LOGIC_VECTOR ((SIZE_X - 1) downto 0);
           y_offset_e : out STD_LOGIC_VECTOR ((SIZE_X - 1) downto 0));
end gest_ennemis;

architecture Behavioral of gest_ennemis is

signal offset_x : unsigned ((SIZE_X - 1) downto 0);
signal offset_y : unsigned ((SIZE_X - 1) downto 0);
signal droite, gauche : boolean;

begin

synchrone : process (clk)
begin
    if (rising_edge(clk)) then
        if reset = '0' then
            offset_x <= to_unsigned(0, SIZE_X);
            offset_y <= to_unsigned(0, SIZE_X);
            droite <= true;
            gauche <= false;
        elsif clk_e = '1' then
            if (offset_x = (SIZE_X_SCREEN/2) and droite = true) then
                offset_y <= offset_y + 5;
                droite <= false;
                gauche <= true;
            elsif (offset_x = 0 and gauche = true) then
                offset_y <= offset_y + 5;
                droite <= true;
                gauche <= false;
            elsif (offset_x > 0 and gauche = true) then
                offset_x <= offset_x - 1;
            elsif (offset_x < (SIZE_X_SCREEN/2) and droite = true) then
                offset_x <= offset_x + 1;
            end if;
        end if;
    end if;
end process synchrone;

x_offset_e <= STD_LOGIC_VECTOR(offset_x);
y_offset_e <= STD_LOGIC_VECTOR(offset_y);

end Behavioral;
