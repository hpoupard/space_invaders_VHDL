----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2017 09:38:42
-- Design Name: 
-- Module Name: module_affichage - Behavioral
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

entity module_affichage is
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
                TOGGLE_BACKGROUND : boolean := true;
                COLOR_TRANS : integer range 0 to 4095 := 3855);
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
end module_affichage;

architecture Behavioral of module_affichage is

component VGA_bitmap_320x200 is
  generic(bit_per_pixel : integer range 1 to 12:=1;    -- number of bits per pixel
          grayscale     : boolean := false);           -- should data be displayed in grayscale
  port(clk          : in  std_logic;
       reset        : in  std_logic;
       VGA_hs       : out std_logic;   -- horisontal vga syncr.
       VGA_vs       : out std_logic;   -- vertical vga syncr.
       VGA_red      : out std_logic_vector(3 downto 0);   -- red output
       VGA_green    : out std_logic_vector(3 downto 0);   -- green output
       VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output

       ADDR         : in  std_logic_vector(15 downto 0);
       data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
       data_write   : in  std_logic;
       data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
end component;

component detect_pos is
    Generic (   SIZE_X  : integer range 1 to 10 := 9;
                SIZE_Y  : integer range 1 to 10 := 8;
                SCREEN_X    : integer range 0 to 1023 := 320;
                SCREEN_Y    : integer range 0 to 1023 := 200;
                TAILLE_E_X  : integer range 1 to 128 := 16;
                TAILLE_E_Y  : integer range 1 to 128 := 16;
                TAILLE_P_X  : integer range 1 to 128 := 16;
                TAILLE_P_Y  : integer range 1 to 128 := 16;
                INTER   : integer range 1 to 128 := 8;
                ROW_E   : integer range 1 to 30 := 4;
                LINE_E  : integer range 1 to 30 := 4);       
    Port (      clk     : in STD_LOGIC;
                reset   : in STD_LOGIC;
                pix_x   : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                pix_y   : in STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
                off_p   : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                off_x_e : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                off_y_e : in STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
                alive   : in STD_LOGIC_VECTOR (ROW_E*LINE_E - 1 downto 0);
                incr_p  : out STD_LOGIC;
                incr_e  : out STD_LOGIC;
                mult    : out STD_LOGIC_VECTOR (3 downto 0));
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

component alpha_canal is
    Generic (   BITS_PER_PIXEL  : integer range 1 to 12 := 12;
                COLOR_TRANS     : integer range 0 to 4095 := 3855);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_i : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
           data_b : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
           data_out : out STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0));
end component;

component mux_pixel is
    Generic (   BITS_PER_PIXEL  : integer range 1 to 12 := 12;
                COLOR_TRANS     : integer range 0 to 4095 := 3085);
    Port (      data1   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data2   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data3   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data4   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data5   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data6   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                data7   : in STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0);
                selec   : in STD_LOGIC_VECTOR (3 downto 0);
                data_out : out STD_LOGIC_VECTOR (BITS_PER_PIXEL - 1 downto 0));
end component;

component memory_acess_matrix is
    Generic (   NMB_ROW : integer range 1 to 20;
                SIZE_X  : integer range 1 to 10;
                SIZE_Y  : integer range 1 to 10;
                LIMIT_X : integer range 1 to 1024;
                LIMIT_Y : integer range 1 to 1024);
    Port (      clk     : in STD_LOGIC;
                reset   : in STD_LOGIC;
                incr    : in STD_LOGIC;
                x       : out STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                y       : out STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0));
end component;

component memory_acess_image is
    Generic (   SIZE_X  : integer range 1 to 10;
                SIZE_Y  : integer range 1 to 10;
                LIMIT_X : integer range 1 to 1024;
                LIMIT_Y : integer range 1 to 1024);
    Port (      clk     : in STD_LOGIC;
                reset   : in STD_LOGIC;
                incr    : in STD_LOGIC;
                x       : out STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                y       : out STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0));
end component;

component cmp_x_y is
    Generic (   SIZE_X : integer range 1 to 10;
                SIZE_Y : integer range 1 to 10;
                LIMIT_X : integer range 1 to 1023;
                LIMIT_Y : integer range 1 to 1023;
                SIZE_ADDR : integer range 1 to 20);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           cmp_x : out STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
           cmp_y : out STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
           addr : out STD_LOGIC_VECTOR(SIZE_ADDR - 1 downto 0));
end component;

component universal_delay is
    Generic (   SIZE_DATA   : integer range 1 to 20;
                DELAY       : integer range 1 to 50);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (SIZE_DATA-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (SIZE_DATA-1 downto 0));
end component;

signal s_addr, sd_addr : STD_LOGIC_VECTOR(SIZE_ADDR - 1 downto 0);  -- Signal contenant l'adresse du bit a afficher
signal pix_x : STD_LOGIC_VECTOR(SIZE_X - 1 downto 0);               -- Signal des coordonne en pixel
signal pix_y : STD_LOGIC_VECTOR(SIZE_Y - 1 downto 0);              

signal x_e : STD_LOGIC_VECTOR(SIZE_E_X - 1 downto 0);               -- Coordonne du pixel a aller chercher dnas la memoire
signal y_e : STD_LOGIC_VECTOR(SIZE_E_Y - 1 downto 0);
signal x_p : STD_LOGIC_VECTOR(SIZE_P_X - 1 downto 0);
signal y_p : STD_LOGIC_VECTOR(SIZE_P_Y - 1 downto 0);

signal data_e, data_p, data_b, ddata_b, data_out, data_vga : STD_LOGIC_VECTOR(BITS_PER_PIXEL - 1 downto 0);

signal smux, d_smux : STD_LOGIC_VECTOR(3 downto 0);

signal incr_e, incr_p : STD_LOGIC;

begin

det : detect_pos
Generic map (
    SIZE_X      => SIZE_X,
    SIZE_Y      => SIZE_Y,
    SCREEN_X    => SCREEN_X,
    SCREEN_Y    => SCREEN_Y,
    TAILLE_E_X  => TAILLE_E_X,
    TAILLE_E_Y  => TAILLE_E_Y,
    TAILLE_P_X  => TAILLE_P_X,
    TAILLE_P_Y  => TAILLE_P_Y,
    INTER       => INTER,
    ROW_E       => ROW_E,
    LINE_E      => LINE_E)
Port map (
    clk     => clk,
    reset   => reset,
    pix_x   => pix_x,
    pix_y   => pix_y,
    off_p   => off_p,
    off_x_e => off_x_e,
    off_y_e => off_y_e,
    alive   => alive,
    incr_p  => incr_p,
    incr_e  => incr_e,
    mult    => smux);

mem_acess_e : memory_acess_matrix
Generic map (
    NMB_ROW => ROW_E,
    SIZE_X  => SIZE_E_X,
    SIZE_Y  => SIZE_E_Y,
    LIMIT_X => TAILLE_E_X,
    LIMIT_Y => TAILLE_E_Y)
Port map (
    clk     => clk,
    reset   => reset,
    incr    => incr_e,
    x       => x_e,
    y       => y_e);
    
mem_acess_p : memory_acess_image
Generic map (   
    SIZE_X  => SIZE_P_X,
    SIZE_Y  => SIZE_P_Y,
    LIMIT_X => TAILLE_P_X,
    LIMIT_Y => TAILLE_P_Y)
Port map (      
    clk     => clk,
    reset   => reset,
    incr    => incr_p,
    x       => x_p,
    y       => y_p);
    
mem_player : mem_image
Generic map (
    BITS_PER_COLOR  => BITS_PER_PIXEL/3,
    MEM_X           => SIZE_P_X,
    MEM_Y           => SIZE_P_Y,
    SIZE_X          => TAILLE_P_X,
    SIZE_Y          => TAILLE_P_Y,
    IMAGE_NAME      => IMG_PLAYER,
    TEST_MODE       => TEST_MODE,
    TEST_COLOR      => 1000)
Port map (
    clk         => clk,
    addr_x      => x_p,
    addr_y      => y_p,
    data_out    => data_p);
    
mem_enemies : mem_image
Generic map (
    BITS_PER_COLOR  => BITS_PER_PIXEL/3,
    MEM_X           => SIZE_E_X,
    MEM_Y           => SIZE_E_Y,
    SIZE_X          => TAILLE_E_X,
    SIZE_Y          => TAILLE_E_Y,
    IMAGE_NAME      => IMG_ENEMIES,
    TEST_MODE       => TEST_MODE,
    TEST_COLOR      => 1000)
Port map (
    clk         => clk,
    addr_x      => x_e,
    addr_y      => y_e,
    data_out    => data_e);
        
mem_background : mem_image
Generic map (
    BITS_PER_COLOR  => BITS_PER_PIXEL/3,
    MEM_X           => SIZE_X,
    MEM_Y           => SIZE_Y,
    SIZE_X          => SCREEN_X,
    SIZE_Y          => SCREEN_Y,
    IMAGE_NAME      => IMG_BACK,
    TEST_MODE       => TOGGLE_BACKGROUND,
    TEST_COLOR      => 0)
Port map (
    clk         => clk,
    addr_x      => pix_x,
    addr_y      => pix_y,
    data_out    => data_b);
    
multiplex : mux_pixel
Generic map (
    BITS_PER_PIXEL  => BITS_PER_PIXEL,
    COLOR_TRANS     => COLOR_TRANS)
Port map (      
    data1   => data_p,
    data2   => data_e,
    data3   => std_logic_vector(to_unsigned(COLOR_TRANS, BITS_PER_PIXEL)),
    data4   => std_logic_vector(to_unsigned(COLOR_TRANS, BITS_PER_PIXEL)),
    data5   => std_logic_vector(to_unsigned(COLOR_TRANS, BITS_PER_PIXEL)),
    data6   => std_logic_vector(to_unsigned(COLOR_TRANS, BITS_PER_PIXEL)),
    data7   => std_logic_vector(to_unsigned(COLOR_TRANS, BITS_PER_PIXEL)),
    selec   => d_smux, 
    data_out => data_out); 

transparence : alpha_canal
Generic map (
    BITS_PER_PIXEL => BITS_PER_PIXEL,
    COLOR_TRANS => COLOR_TRANS)
Port map (
    clk => clk,
    reset => reset,
    data_i => data_out,
    data_b => ddata_b,
    data_out => data_vga);

vga : VGA_bitmap_320x200
Generic map (
    bit_per_pixel => BITS_PER_PIXEL)    -- number of bits per pixel
Port map (
    clk          => clk,
    reset        => reset,
    VGA_hs       => h_sync,
    VGA_vs       => v_sync,
    VGA_red      => red,
    VGA_green    => green,
    VGA_blue     => blue,
    
    ADDR         => sd_addr,
    data_in      => data_vga,
    data_write   => '1');

cmpx_y : cmp_x_y
Generic map (
    SIZE_X  => SIZE_X,
    SIZE_Y  => SIZE_Y,
    LIMIT_X => SCREEN_X,
    LIMIT_Y => SCREEN_Y,
    SIZE_ADDR => SIZE_ADDR)
Port map ( 
    clk     => clk,
    reset   => reset, 
    cmp_x   => pix_x,
    cmp_y   => pix_y,
    addr    => s_addr);
    
delay_mult : universal_delay
Generic map (
    SIZE_DATA   => 4,
    DELAY       => 1)
Port map (
    clk         => clk,
    reset       => reset,
    data_in     => smux,
    data_out    => d_smux);

delay_data_b : universal_delay
Generic map (
    SIZE_DATA   => BITS_PER_PIXEL,
    DELAY       => 2)
Port map (
    clk         => clk,
    reset       => reset,
    data_in     => data_b,
    data_out    => ddata_b);
    
delay_addr : universal_delay
    Generic map (
        SIZE_DATA   => SIZE_ADDR,
        DELAY       => 4)
    Port map (
        clk         => clk,
        reset       => reset,
        data_in     => s_addr,
        data_out    => sd_addr);

end Behavioral;
