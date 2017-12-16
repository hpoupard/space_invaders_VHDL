----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 12:01:13
-- Design Name: 
-- Module Name: mux_pixel - Behavioral
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

entity mux_pixel is
    Generic (   BITS_PER_PIXEL  : integer range 1 to 12 := 12;
                COLOR_TRANS     : integer range 0 to 4095 := 3855);
    Port (      data1   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data2   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data3   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data4   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data5   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data6   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data7   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                selec   : in STD_LOGIC_VECTOR (3 downto 0);
                data_out : out STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0));
end mux_pixel;

architecture Behavioral of mux_pixel is

begin

asynchrone : process(selec, data1, data2, data3, data4, data5, data6, data7)
begin
    case selec is
        when "0001" => data_out <= data1;
        when "0010" => data_out <= data2;
        when "0011" => data_out <= data3;
        when "0100" => data_out <= data4;
        when "0101" => data_out <= data5;
        when "0111" => data_out <= data6;
        when "1000" => data_out <= data7;
        when others => data_out <= std_logic_vector(to_unsigned(COLOR_TRANS, BITS_PER_PIXEL));
    end case;
end process asynchrone;

end Behavioral;
