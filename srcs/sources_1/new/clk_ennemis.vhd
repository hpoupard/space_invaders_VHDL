----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 08:23:10
-- Design Name: 
-- Module Name: clk_ennemis - Behavioral
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

entity clk_ennemis is
    generic ( NMB_ENNEMIS : integer range 0 to 20 := 20;
              VITESSE_MAX : integer range 0 to 10000000;
              VITESSE_MIN : integer range 0 to 10000000; 
              SIZE_X : integer range 0 to 640 := 160);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           increase : in STD_LOGIC;
           clk_e : out STD_LOGIC);
end clk_ennemis;

architecture Behavioral of clk_ennemis is

signal compteur : integer range 0 to 9999999;
signal speed : integer range 0 to 20;
signal compteur_max : integer range 0 to 9999999;

begin

synchrone : process(clk)
begin
    if(rising_edge(clk)) then
        if reset = '0' then
            clk_e <= '0';
            compteur <= 0;
        elsif compteur >= compteur_max then
            clk_e <= '1';
            compteur <= 0;
        else
            compteur <= compteur + 1;
            clk_e <= '0';
        end if;
    end if;
end process synchrone;

var_speed : process(clk)
begin
    if (rising_edge(clk)) then
        if reset = '0' then
            speed <= 0;
        elsif increase = '1' then 
            speed <= speed + 1;
        else 
            speed <= speed;
        end if;
    end if;
end process var_speed;

comp_max : process(speed)
begin
    for i in 0 to NMB_ENNEMIS loop
        if (i = speed) then
            compteur_max <= (NMB_ENNEMIS - i)*(VITESSE_MIN - (VITESSE_MAX - VITESSE_MIN * NMB_ENNEMIS)/(1 - NMB_ENNEMIS)) + (VITESSE_MAX - VITESSE_MIN*NMB_ENNEMIS)/(1 - NMB_ENNEMIS);
        end if;
    end loop;
end process comp_max;

end Behavioral;
