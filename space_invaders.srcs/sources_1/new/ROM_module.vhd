----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2017 22:28:09
-- Design Name: 
-- Module Name: ROM_module - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use std.textio.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_module is
    Generic (SIZE_X : integer range 1 to 1024;
             SIZE_Y : integer range 1 to 1024;
             BIT_PER_PIXEL : integer 1 to 12);
    Port ( clk      : in STD_LOGIC;
           addr     : in STD_LOGIC_VECTOR (0 downto 0);
           data_out : in STD_LOGIC_VECTOR (0 downto 0));
end ROM_module;

architecture Behavioral of ROM_module is

variable MEM_X : integer 1 to 

type GRAM is array (0 to (2**MEM_X)*(2**MEM_Y) - 1) of BIT_vector(BITS_PER_COLOR*3 - 1 downto 0);

impure function ram_function_name (ram_file_name : in string) return GRAM is                                                   
   FILE ram_file      : text is in ram_file_name;
   variable line_name : line;
   variable ram_name  : GRAM;
 begin                                                        
   for I in 0 to SIZE_X*SIZE_Y-1 loop                                  
       readline (ram_file, line_name);                             
       read (line_name, ram_name((I mod SIZE_X) + I/SIZE_Y*(2**MEM_X)));                                  
   end loop;                                                    
   return ram_name;                                                  
end function;

begin


end Behavioral;
