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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_tir is
    Port ( clk : in STD_LOGIC;
           clk_tir : in STD_LOGIC;
           reset : in STD_LOGIC;
           launch_shot : in STD_LOGIC;
           bloc_touched : in STD_LOGIC;
           x_offset : in STD_LOGIC_VECTOR (7 downto 0);
           x_offset_tir : out STD_LOGIC_VECTOR (7 downto 0);
           y_offset_tir : out STD_LOGIC_VECTOR (7 downto 0);
           enable_shot : out STD_LOGIC);
end gestion_tir;

architecture Behavioral of gestion_tir is

signal tir_en_cours : boolean ;
signal offset_x_tir, offset_y_tir : unsigned(7 downto 0);

begin

synchrone : process(clk)
begin
    if (rising_edge(clk)) then
        if reset = '0' then
            tir_en_cours <= false;
            offset_x_tir <= unsigned(x_offset);
            offset_y_tir <= to_unsigned(0, 8);
            enable_shot <= '1';
        elsif (tir_en_cours = false) then
            if launch_shot = '1' then
                enable_shot <= '0';
                tir_en_cours <= true;
                offset_x_tir <= unsigned(x_offset);
                offset_y_tir <= to_unsigned(0, 8);
            else
                enable_shot <= '1';
                offset_x_tir <= unsigned(x_offset);
                offset_y_tir <= to_unsigned(0, 8);
            end if;
        elsif (tir_en_cours = true) then
            enable_shot <= '0';
            if(bloc_touched = '1') then
                offset_x_tir <= unsigned(x_offset);
                offset_y_tir <= to_unsigned(0, 8);
                tir_en_cours <= false;
                enable_shot <= '1';
            elsif (clk_tir = '1') then
                offset_x_tir <= offset_x_tir;
                offset_y_tir <= offset_y_tir + 1;
            else
                offset_x_tir <= offset_x_tir;
                offset_y_tir <= offset_y_tir;
            end if;
        end if;
    end if;
end process synchrone;

x_offset_tir <= std_logic_vector(offset_x_tir);
y_offset_tir <= std_logic_vector(offset_y_tir);

end Behavioral;
