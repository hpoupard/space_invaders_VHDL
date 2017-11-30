----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2017 14:05:57
-- Design Name: 
-- Module Name: test_charg_image - Behavioral
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

entity test_charg_image is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           v_synch : out STD_LOGIC;
           h_synch : out STD_LOGIC;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0));
end test_charg_image;

architecture Behavioral of test_charg_image is

component vga_160_100 is
  generic(bit_per_pixel : integer range 1 to 12:= 1;    -- number of bits per pixel
          grayscale     : boolean := false);           -- should data be displayed in grayscale
  port(clk          : in  std_logic;
       reset        : in  std_logic;
       VGA_hs       : out std_logic;   -- horisontal vga syncr.
       VGA_vs       : out std_logic;   -- vertical vga syncr.
       VGA_red      : out std_logic_vector(3 downto 0);   -- red output
       VGA_green    : out std_logic_vector(3 downto 0);   -- green output
       VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output

       ADDR         : in  std_logic_vector(13 downto 0);
       data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
       data_write   : in  std_logic;
       data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
end component;

component cmp_x_y is
    Generic (   SIZE_X : integer range 1 to 8;
                SIZE_Y : integer range 1 to 8;
                LIMIT_X : integer range 1 to 256;
                LIMIT_Y : integer range 1 to 256);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           cmp_x : out STD_LOGIC_VECTOR (SIZE_X-1 downto 0);
           cmp_y : out STD_LOGIC_VECTOR (SIZE_Y-1 downto 0);
           addr : out STD_LOGIC_VECTOR(13 downto 0));
end component;

component mem_image is
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
end component;

signal cmp_x : std_logic_vector(7 downto 0);
signal cmp_y : std_logic_vector(6 downto 0);
signal addr : std_logic_vector(13 downto 0);
signal data : std_logic_vector(11 downto 0);

signal simpul_y : std_logic;

begin

vga : vga_160_100
generic map (
    bit_per_pixel => 12)
port map (
    clk => clk,
    reset => reset,
    VGA_hs => h_synch,
    VGA_vs => v_synch,
    VGA_red => red,
    VGA_green => green,
    VGA_blue => blue,
    ADDR => addr,
    data_in => data,
    data_write => '1');

icmp_x_y : cmp_x_y
generic map (   SIZE_X => 8,
                SIZE_Y => 7,
                LIMIT_X => 160,
                LIMIT_Y => 100)
port map (
    clk => clk,
    reset => reset,
    cmp_y => cmp_y,
    cmp_x => cmp_x,
    addr => addr);

mem : mem_image
generic map (
    BITS_PER_COLOR => 4,
    SIZE_X => 160,
    SIZE_Y => 100,
    MEM_X => 8,
    MEM_Y => 7,
    IMAGE_NAME => "images/test.bin",
    TEST_MODE => true,
    TEST_COLOR => 2048)
port map (
    clk => clk,
    addr_x => cmp_x,
    addr_y => cmp_y,
    data_out => data);

end Behavioral;
