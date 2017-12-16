----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2017 19:54:37
-- Design Name: 
-- Module Name: test_module_affichage - Behavioral
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

entity test_module_affichage is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           h_sync : out STD_LOGIC;
           v_sync : out STD_LOGIC;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end test_module_affichage;

architecture Behavioral of test_module_affichage is

component module_affichage is
    Generic (   SIZE_X  : integer range 1 to 10 := 8;
                SIZE_Y  : integer range 1 to 10 := 8;
                SCREEN_X    : integer range 0 to 1023 := 320;
                SCREEN_Y    : integer range 0 to 1023 := 200;
                SIZE_ADDR   : integer range 1 to 20 := 16;
                BITS_PER_PIXEL : integer range 1 to 12 := 12;
                TAILLE_E_X  : integer range 1 to 128 := 16;
                TAILLE_E_Y  : integer range 1 to 128 := 16;
                TAILLE_P_X  : integer range 1 to 128 := 16;
                TAILLE_P_Y  : integer range 1 to 128 := 16;
                SIZE_E_X  : integer range 1 to 8 := 4;
                SIZE_E_Y  : integer range 1 to 8 := 4;
                SIZE_P_X  : integer range 1 to 8 := 4;
                SIZE_P_Y  : integer range 1 to 8 := 4;
                INTER   : integer range 1 to 128 := 8;
                ROW_E   : integer range 1 to 30 := 4;
                LINE_E  : integer range 1 to 30 := 4;
                IMG_BACK    : string := "images/background.bin";
                IMG_PLAYER  : string := "images/player.bin";
                IMG_ENEMIES : string := "images/enemies.bin";
                TEST_MODE   : boolean := false;
                TOGGLE_BACKGROUND : boolean := false;
                COLOR_TRANS : integer range 0 to 4095 := 3085);
    Port (      clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                off_p : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                off_x_e : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                off_y_e : in STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
                alive : in STD_LOGIC_VECTOR (ROW_E*LINE_E - 1 downto 0);
                red : out STD_LOGIC_VECTOR(BITS_PER_PIXEL/3 - 1 downto 0);
                green : out STD_LOGIC_VECTOR(BITS_PER_PIXEL/3 - 1 downto 0);
                blue : out STD_LOGIC_VECTOR(BITS_PER_PIXEL/3 - 1 downto 0);
                h_sync : out STD_LOGIC;
                v_sync : out STD_LOGIC);
end component;

begin

affichage : module_affichage
Generic map (   
    SIZE_X  => 9,
    SIZE_Y  => 8,
    SCREEN_X => 320,
    SCREEN_Y => 200,
    SIZE_ADDR => 16,
    BITS_PER_PIXEL => 12,
    TAILLE_E_X  => 16,
    TAILLE_E_Y  => 16,
    TAILLE_P_X  => 32,
    TAILLE_P_Y  => 16,
    SIZE_E_X  => 4,
    SIZE_E_Y  => 4,
    SIZE_P_X  => 5,
    SIZE_P_Y  => 4,
    INTER   => 8,
    ROW_E   => 4,
    LINE_E  => 4,
    TEST_MODE => false,
    TOGGLE_BACKGROUND => true)
Port map (      
    clk => clk,
    reset => reset,
    off_p => std_logic_vector(to_unsigned(100, 9)),
    off_x_e => std_logic_vector(to_unsigned(100, 9)),
    off_y_e => std_logic_vector(to_unsigned(50, 8)),
    alive => "0111111111111111",
    red => red,
    green => green,
    blue => blue,
    h_sync => h_sync,
    v_sync => v_sync);

end Behavioral;
