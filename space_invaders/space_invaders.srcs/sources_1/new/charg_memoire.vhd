----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2017 11:38:42
-- Design Name: 
-- Module Name: charg_memoire - Behavioral
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

entity charg_memoire is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_offset : in STD_LOGIC_VECTOR (7 downto 0);
           addr : out STD_LOGIC_VECTOR (13 downto 0);
           data : out STD_LOGIC_VECTOR (5 downto 0);
           data_write : out STD_LOGIC);
end charg_memoire;

architecture Behavioral of charg_memoire is

signal s_addr : unsigned (13 downto 0);
signal s_red, s_green, s_blue : unsigned (1 downto 0); 
signal x_pixel : integer range 0 to 159;
signal y_pixel : integer range 0 to 99;
signal x_comp, y_comp, x_abri, y_abri : boolean;
signal offset_x : integer := to_integer(unsigned(x_offset));
   
begin

    synchrone : process(clk)
    begin
        if (rising_edge(clk)) then
            if reset = '0' then
                x_pixel <= 0;
                y_pixel <= 0;
                s_addr <= to_unsigned(0, 14);
            elsif s_addr = 15999 then
                s_addr <= TO_UNSIGNED(0, 14);
                x_pixel <= 0;
                y_pixel <= 0;
            elsif x_pixel = 159 then
                x_pixel <= 0;
                y_pixel <= y_pixel + 1;
                s_addr <= s_addr + 1;
            elsif y_pixel = 99 then
                y_pixel <= 0;
                x_pixel <= 0;
                s_addr <= s_addr + 1;
            else
                s_addr <= s_addr + 1;
                x_pixel <= x_pixel + 1;
            end if;
        end if;
    end process synchrone;
    
    asynchrone : process(x_pixel, y_pixel)
    begin
        if (x_pixel > offset_x and x_pixel < (10 + offset_x)) then
            x_comp <= true;
        else
            x_comp <= false;
        end if;
        if(x_pixel > 0 and x_pixel < 10) then
            x_abri <= true;
        elsif(x_pixel > 50 and x_pixel < 60) then
            x_abri <= true;
        elsif(x_pixel > 100 and x_pixel < 110) then
            x_abri <= true;
        elsif(x_pixel > 150 and x_pixel < 160) then
            x_abri <= true;
        else
            x_abri <= false;
        end if;
        if (y_pixel > 90 and y_pixel < 100) then
            y_comp <= true;
        else
            y_comp <= false;
        end if;
        if (y_pixel > 50 and y_pixel < 60)then
            y_abri <= true;
        else            
            y_abri <= false;
        end if;
    end process asynchrone;
    
    sorties : process(x_comp, y_comp)
    begin
        if (x_comp = true) and (y_comp = true) then
                s_red <= to_unsigned(3, 2);
                s_green <= to_unsigned(3, 2);
                s_blue <= to_unsigned(3, 2);
        elsif (x_abri = true) and (y_abri = true) then
                s_red <= to_unsigned(3, 2);
                s_green <= to_unsigned(3, 2);
                s_blue <= to_unsigned(3, 2);
        else
                s_red <= to_unsigned(0, 2);
                s_green <= to_unsigned(0, 2);
                s_blue <= to_unsigned(0, 2);
        end if;
    end process sorties;
    
    addr <= STD_LOGIC_VECTOR(s_addr);
    data <= STD_LOGIC_VECTOR(s_red) & STD_LOGIC_VECTOR(s_green) & STD_LOGIC_VECTOR(s_blue);
    data_write <= '1';
    
end Behavioral;
