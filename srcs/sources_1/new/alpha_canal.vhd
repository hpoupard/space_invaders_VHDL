----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 12:19:00
-- Design Name: 
-- Module Name: alpha_canal - Behavioral
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

entity alpha_canal is
    Generic (   BITS_PER_PIXEL  : integer range 1 to 12;
                COLOR_TRANS     : integer range 0 to 4095 := 3085);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_i : in STD_LOGIC_VECTOR (0 downto 0);
           data_b : in STD_LOGIC_VECTOR (0 downto 0);
           data_out : out STD_LOGIC_VECTOR (0 downto 0));
end alpha_canal;

architecture Behavioral of alpha_canal is

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if reset = '0' then
            data_out <= std_logic_vector(to_unsigned(0, BITS_PER_PIXEL));
        elsif integer(unsigned(data_i)) = COLOR_TRANS then
            data_out <= data_b;
        else
            data_out <= data_i;
        end if;
    end if;
end process synchrone;

end Behavioral;
