-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2017 11:54:10
-- Design Name: 
-- Module Name: logic_module - Behavioral
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

entity module_logique is
	Generic ( SIZE_X : integer range 0 to 10 := 8;
			  SIZE_Y : integer range 0 to 10 := 8;
			  ROW_E : integer range 0 to 30 := 4;
			  LINE_E : integer range 0 to 30 := 4;
			  TAILLE_E_X : integer range 1 to 128 := 16;
			  TAILLE_E_Y : integer range 1 to 128 := 16;
			  TAILLE_P_X : integer range 1 to 128 := 16;
			  TAILLE_P_Y : integer range 1 to 128 := 16;
			  SIZE_X_SCREEN : integer range 160 to 640 := 320;
			  INTER : integer range 1 to 128 := 16);
    Port (    clk : in STD_LOGIC;
              reset : in STD_LOGIC;
			  sndRec : in  STD_LOGIC;
			  DIN : in  STD_LOGIC_VECTOR (7 downto 0);
              MISO : in  STD_LOGIC;
              SS : out  STD_LOGIC;
              SCLK : out  STD_LOGIC;
              MOSI : out  STD_LOGIC;
		      x_offset : out STD_LOGIC_VECTOR((SIZE_X - 1) downto 0);
              x_offset_tir : out STD_LOGIC_VECTOR((SIZE_X - 1) downto 0);
		      y_offset_tir : out STD_LOGIC_VECTOR((SIZE_Y - 1) downto 0);
		      x_offset_e : out STD_LOGIC_VECTOR((SIZE_X - 1) downto 0);
		      y_offset_e : out STD_LOGIC_VECTOR((SIZE_Y - 1) downto 0);
		      alive : out STD_LOGIC_VECTOR((ROW_E*LINE_E - 1) downto 0));
end module_logique;

architecture Behavioral of module_logique is

component PmodJSTK is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           sndRec : in  STD_LOGIC;
           DIN : in  STD_LOGIC_VECTOR (7 downto 0);
           MISO : in  STD_LOGIC;
           SS : out  STD_LOGIC;
           SCLK : out  STD_LOGIC;
           MOSI : out  STD_LOGIC;
           x_val    : out  STD_LOGIC_VECTOR (9 downto 0);
           y_val    : out  STD_LOGIC_VECTOR (9 downto 0);
           button_1 : out  STD_LOGIC;
           button_2 : out  STD_LOGIC
           );
end component;

component gest_command is
	Generic ( TAILLE_P_X : integer range 1 to 128 := 16;
			  SIZE_X : integer range 0 to 10 := 8;
			  SIZE_X_SCREEN : integer range 160 to 640 := 320);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_val : in STD_LOGIC_VECTOR (9 downto 0);
           shot : in STD_LOGIC;
           enable_shot : in STD_LOGIC;
           x_offset : out STD_LOGIC_VECTOR ((SIZE_X - 1) downto 0);
           launch_shot : out STD_LOGIC);
end component;

component clk_ennemis is
    generic ( NMB_ENNEMIS : integer range 0 to 20 := 20;
              VITESSE_MAX : integer range 0 to 10000000;
              VITESSE_MIN : integer range 0 to 10000000;  
              SIZE_X : integer range 160 to 640 := 320);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           increase : in STD_LOGIC;
           clk_e : out STD_LOGIC);
end component;

component gest_ennemis is
	Generic ( SIZE_X : integer range 0 to 10 := 8;
			  SIZE_X_SCREEN : integer range 160 to 640 := 320);
    Port ( clk : in STD_LOGIC;
           clk_e : in STD_LOGIC;
           reset : in STD_LOGIC;
           x_offset_e : out STD_LOGIC_VECTOR (7 downto 0);
           y_offset_e : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component gestion_tir is
	Generic ( SIZE_X : integer range 0 to 10 := 8);
    Port ( clk : in STD_LOGIC;
           clk_tir : in STD_LOGIC;
           reset : in STD_LOGIC;
           launch_shot : in STD_LOGIC;
           bloc_touched : in STD_LOGIC;
           x_offset : in STD_LOGIC_VECTOR (7 downto 0);
           x_offset_tir : out STD_LOGIC_VECTOR (7 downto 0);
           y_offset_tir : out STD_LOGIC_VECTOR (7 downto 0);
           enable_shot : out STD_LOGIC);
end component;

component clock_tir is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_tir : out STD_LOGIC);
end component;

signal clk_e, clk_tir : STD_LOGIC;
signal increase, enable_shot, launch_shot, shot : STD_LOGIC;
signal s_x_offset : STD_LOGIC_VECTOR ((SIZE_X - 1) downto 0);
signal x_val : STD_LOGIC_VECTOR (9 downto 0);

begin

joystick : PmodJSTK
port map (
		CLK => clk,
		RST => reset,
		sndRec =>sndRec,
	    DIN => DIN,
        MISO => MISO,
        SS => SS,
		SCLK => SCLK,
        MOSI => MOSI,
        x_val => x_val,
        button_1 => shot
		);

commande : gest_command
generic map (
		TAILLE_P_X => TAILLE_P_X,
		SIZE_X => SIZE_X,
		SIZE_X_SCREEN => SIZE_X_SCREEN
		)
port map(
        clk => clk,
        reset => reset,
        x_val => x_val,
        shot => shot,
        enable_shot => enable_shot,
        launch_shot => launch_shot,
        x_offset => s_x_offset
        );

clock_e : clk_ennemis
generic map(
      NMB_ENNEMIS  => ROW_E*LINE_E,
      VITESSE_MAX => 5*100000000/(SIZE_X_SCREEN/2),
      VITESSE_MIN => 1*100000000/(SIZE_X_SCREEN/2), 
      SIZE_X => SIZE_X_SCREEN
      )
port map (
     clk => clk,
     reset => reset,
     increase => increase,
     clk_e => clk_e
     );

gestion_ennemis : gest_ennemis
generic map (
		SIZE_X => SIZE_X,
		SIZE_X_SCREEN => SIZE_X_SCREEN
		)
 port map (
      clk => clk,
      clk_e => clk_e,
      reset => reset,
      x_offset_e => x_offset_e,
      y_offset_e => y_offset_e
      );

gest_tir : gestion_tir
generic map ( SIZE_X => SIZE_X
	)
 port map (
        clk => clk,
        clk_tir => clk_tir,
        reset => reset,
        launch_shot => launch_shot,
        bloc_touched => '0',
        x_offset => s_x_offset,
        x_offset_tir => x_offset_tir,
        y_offset_tir => y_offset_tir,
        enable_shot => enable_shot
        );
        
clock_tir_e : clock_tir
 port map (
    clk => clk,
    reset => reset,
    clk_tir => clk_tir
    );
	
alive <= STD_LOGIC_VECTOR(to_unsigned(2**(ROW_E*LINE_E) - 1, ROW_E*LINE_E));
x_offset <= s_x_offset;

end Behavioral;



