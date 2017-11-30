----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2017 11:54:10
-- Design Name: 
-- Module Name: top_module - Behavioral
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

entity top_module is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           left : in STD_LOGIC;
           right :  in STD_LOGIC;
           h_sync : out STD_LOGIC;
           v_sync : out STD_LOGIC;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end top_module;

architecture Behavioral of top_module is

component charg_memoire is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           right : in STD_LOGIC;
           left : in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (18 downto 0);
           data : out STD_LOGIC_VECTOR (5 downto 0);
           data_write : out STD_LOGIC);
end component;

component vga_640_480 is
  generic(bit_per_pixel : integer range 1 to 12:=1;    -- number of bits per pixel
          grayscale     : boolean := false);           -- should data be displayed in grayscale
  port(clk          : in  std_logic;
       reset        : in  std_logic;
       VGA_hs       : out std_logic;   -- horisontal vga syncr.
       VGA_vs       : out std_logic;   -- vertical vga syncr.
       VGA_red      : out std_logic_vector(3 downto 0);   -- red output
       VGA_green    : out std_logic_vector(3 downto 0);   -- green output
       VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output

       ADDR         : in  std_logic_vector(18 downto 0);
       data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
       data_write   : in  std_logic;
       data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
end component;

signal data_write : STD_LOGIC;
signal addr : STD_LOGIC_VECTOR(18 downto 0);
signal data : STD_LOGIC_VECTOR(5 downto 0);

begin

cm : charg_memoire
port map(
    clk => clk,
    reset => reset,
    left => left,
    right => right,
    addr => addr,
    data => data,
    data_write => data_write
    );
    
vga : vga_640_480
generic map(
    bit_per_pixel => 6
    )
port map(
    clk => clk,
    reset => reset,
    VGA_hs => h_sync,
    VGA_vs => v_sync,
    VGA_red => red,
    VGA_green => green,
    VGA_blue => blue,
    ADDR => addr,
    data_in => data,
    data_write => data_write
    );

end Behavioral;
