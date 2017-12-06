----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2017 11:38:11
-- Design Name: 
-- Module Name: gest_command - Behavioral
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

entity gest_command is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           left : in STD_LOGIC;
           right : in STD_LOGIC;
           shot : in STD_LOGIC;
           enable_shot : in STD_LOGIC;
           x_offset : out STD_LOGIC_VECTOR (7 downto 0);
           launch_shot : out STD_LOGIC);
end gest_command;

architecture Behavioral of gest_command is

signal offset_x : unsigned(7 downto 0);
signal compteur : integer range 0 to 299999;

begin

mouvement : process(clk)
    begin
        if (rising_edge(clk)) then
            if reset = '0' then
                offset_x <= to_unsigned(60, 8);
                compteur <= 0;
            elsif (left = '1' and compteur = 0 and offset_x > 0) then
                offset_x <= offset_x - 1;
                compteur <= 299999;
            elsif (right = '1' and compteur = 0 and offset_x < 149) then
                offset_x <= offset_x + 1;
                compteur <= 299999;
            else
                compteur <= compteur - 1;               
            end if;
        end if;
    end process mouvement;
    
    shot_process : process(clk)
    begin
        if (rising_edge(clk)) then
            if reset = '0' then
                launch_shot <= '0';
            elsif shot = '1' then
                if enable_shot ='1' then
                    launch_shot <= '1';
                else
                    launch_shot <= '0';
                end if;
            else
                launch_shot <= '0';
            end if;
        end if;
    end process shot_process;

x_offset <= STD_LOGIC_VECTOR(offset_x);


end Behavioral;
