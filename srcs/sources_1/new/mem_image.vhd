----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2017 22:18:56
-- Design Name: 
-- Module Name: mem_image - Behavioral
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
use std.textio.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_image is
    Generic (   BITS_PER_COLOR  : integer range 1 to 4 := 4;
                MEM_X           : integer range 1 to 10 := 8;
                MEM_Y           : integer range 1 to 10 := 8;           
                SIZE_X          : integer range 1 to 1024 := 160;
                SIZE_Y          : integer range 1 to 1024 := 100;
                IMAGE_NAME      : string := "images/test.bin";
                TEST_MODE       : boolean := false;
                TEST_COLOR      : integer range 0 to 4095 := 4095);
        
    Port (      clk         : in STD_LOGIC;
                addr_x      : in STD_LOGIC_VECTOR (MEM_X-1 downto 0);
                addr_y      : in STD_LOGIC_VECTOR (MEM_Y-1 downto 0);          
                data_out    : out STD_LOGIC_VECTOR (BITS_PER_COLOR*3 - 1 downto 0));
end mem_image;

architecture Behavioral of mem_image is

type GRAM is array (0 to (2**MEM_X)*(2**MEM_Y) - 1) of BIT_vector(BITS_PER_COLOR*3 - 1 downto 0);

impure function ram_function_name (ram_file_name : in string) return GRAM is                                                   
   FILE ram_file      : text is in ram_file_name;
   variable line_name : line;
   variable ram_name  : GRAM;
 begin                                                        
   for I in 0 to SIZE_X*SIZE_Y-1 loop
        if TEST_MODE = false then                                  
            readline (ram_file, line_name);                             
            read (line_name, ram_name((I mod SIZE_X) + I/SIZE_Y*(2**MEM_X)));
        end if;
   end loop;                                                    
   return ram_name;                                                  
end function;

signal memory : GRAM := ram_function_name(IMAGE_NAME);

begin

synchrone : process(clk)
begin
    if rising_edge(clk) then
        if TEST_MODE = false then
            data_out <= to_StdLogicVector(memory(to_integer(unsigned(addr_y))*(2**MEM_X) + to_integer(unsigned(addr_x))));
        else
            data_out <= std_logic_vector(to_unsigned(TEST_COLOR, 3*BITS_PER_COLOR));
        end if;
    end if;
end process synchrone;

end Behavioral;
