----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 19:34:05
-- Design Name: 
-- Module Name: gestion_tir - Behavioral
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

entity gestion_tir is
    Port ( clk : in STD_LOGIC;
           clk_tir : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_offset_tir : out STD_LOGIC_VECTOR (7 downto 0);
           y_offset_tir : out STD_LOGIC_VECTOR (6 downto 0));
end gestion_tir;

architecture Behavioral of gestion_tir is

begin


end Behavioral;
