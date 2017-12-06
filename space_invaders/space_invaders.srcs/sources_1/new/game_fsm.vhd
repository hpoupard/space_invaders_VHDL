----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2017 12:44:24
-- Design Name: 
-- Module Name: game_fsm - Behavioral
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

entity game_fsm is
    Generic ( BIT_PER_COORDINATES : integer range 0 to 9 := 8);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_offset : in STD_LOGIC_VECTOR (BIT_PER_COORDINATES downto 0);
           x_offset_e : in STD_LOGIC_VECTOR (BIT_PER_COORDINATES downto 0);
           y_offset_e : in STD_LOGIC_VECTOR (BIT_PER_COORDINATES downto 0);
           x_offset_tir : in STD_LOGIC_VECTOR (BIT_PER_COORDINATES downto 0);
           y_offset_tir : in STD_LOGIC_VECTOR (BIT_PER_COORDINATES downto 0);
           game_over : out STD_LOGIC;
           bloc_touched : out STD_LOGIC;
           increase : out STD_LOGIC);
end game_fsm;

architecture Behavioral of game_fsm is

begin

--gestion_collision : process(clk)
--begin
--    if (rising_edge(clk)) then
--        if reset = '0' then
--            increase <= '0';
--            game_over <= '0';
--            bloc_touched <= '0';
--        elsif blablavka then
--        end if;
--    end if;
--end process gestion_collision;

end Behavioral;
