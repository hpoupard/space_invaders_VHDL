----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2017 08:21:54
-- Design Name: 
-- Module Name: detect_pos - Behavioral
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

entity detect_pos is
    Generic (   SIZE_X  : integer range 1 to 10 := 9;
                SIZE_Y  : integer range 1 to 10 := 8;
                SCREEN_X    : integer range 0 to 1023 := 320;
                SCREEN_Y    : integer range 0 to 1023 := 200;
                TAILLE_E_X  : integer range 1 to 128 := 16;
                TAILLE_E_Y  : integer range 1 to 128 := 16;
                TAILLE_P_X  : integer range 1 to 128 := 16;
                TAILLE_P_Y  : integer range 1 to 128 := 16;
                TAILLE_TIR_X : integer range 1 to 16 := 2;
                TAILLE_TIR_Y : integer range 1 to 16 := 2;
                INTER   : integer range 1 to 128 := 8;
                ROW_E   : integer range 1 to 30 := 4;
                LINE_E  : integer range 1 to 30 := 4);       
    Port (      clk     : in STD_LOGIC;
                addr : STD_LOGIC_VECTOR(15 downto 0);
                reset   : in STD_LOGIC;
                pix_x   : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                pix_y   : in STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
                off_p   : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                off_x_e : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                off_y_e : in STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
                alive   : in STD_LOGIC_VECTOR (ROW_E*LINE_E - 1 downto 0);
                tir     : in STD_LOGIC;
                tir_x   : in STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
                tir_y   : in STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
                incr_p  : out STD_LOGIC;
                incr_e  : out STD_LOGIC;
                reset_cmp : out STD_LOGIC;
                mult    : out STD_LOGIC_VECTOR (3 downto 0));
end detect_pos;

architecture Behavioral of detect_pos is

    type state is (BACKGROUND, PLAYER, ENEMIES, SHOT);
    
    signal s_mult   : integer range 0 to 63;
    signal s_alive  : STD_LOGIC_VECTOR (ROW_E*LINE_E - 1 downto 0);
    signal s_x, s_off_x_e, s_off_p, s_tir_x  : integer range 0 to 2**SIZE_X-1;
    signal s_y, s_off_y_e, s_tir_y           : integer range 0 to 2**SIZE_Y-1;
    signal etat : state;
    signal senemies, salive, splayer, stir : boolean;

begin

--Rajouter la clock de FRAME !
synchrone : process(clk, reset)
begin
    if reset = '0' then
        reset_cmp   <= '0';
        etat        <= BACKGROUND;
        s_x         <= 0;
        s_y         <= 0;
        s_off_x_e   <= 0;
        s_off_y_e   <= 0;
        s_off_p     <= 0;
        s_tir_x     <= 0;
        s_tir_y     <= 0;
        s_alive     <= std_logic_vector(to_unsigned(0, ROW_E*LINE_E));
    elsif rising_edge(clk) then
        s_x <= to_integer(unsigned(pix_x));
        s_y <= to_integer(unsigned(pix_y));
        
        if addr = std_logic_vector(to_unsigned(0, 16)) then
            reset_cmp   <= '1';
            s_off_x_e   <= to_integer(unsigned(off_x_e));
            s_off_y_e   <= to_integer(unsigned(off_y_e));
            s_off_p     <= to_integer(unsigned(off_p));
            s_tir_x     <= to_integer(unsigned(tir_x));
            s_tir_y     <= to_integer(unsigned(tir_y));
            s_alive     <= alive;
        else
            reset_cmp <= '0';
        end if;
        
        if salive = true then
            incr_e <= '1';
        else
            incr_e <= '0';
        end if;
        if splayer = true then
            incr_p <= '1';
        else
            incr_p <= '0';
        end if;
        
        if stir = true then
            etat <= SHOT;
        elsif senemies = true then
            etat <= ENEMIES;
        elsif splayer = true then
            etat <= PLAYER;
        else
            etat <= BACKGROUND;
        end if;
    end if;
end process synchrone;

--Detection de l'image a afficher
asynchrone : process(s_x, s_y, s_off_p, s_off_x_e, s_off_y_e, alive, tir, s_tir_x, s_tir_y)
    variable det_enemies : boolean := false;
    variable det_enemies_alive : boolean := false;
    variable det_player : boolean := false;
begin
    det_enemies := false;
    det_player := false;
    det_enemies_alive := false;
    
    if (s_x >= s_off_p and s_x < TAILLE_P_X + s_off_p) and (s_y >= SCREEN_Y - TAILLE_P_Y) then
        det_player := true;
    end if;
    
    if (s_x >= s_tir_x and s_x < TAILLE_TIR_X + s_tir_x) and (s_y >= s_tir_y and s_y < s_tir_y + TAILLE_TIR_Y and tir = '1') then
        stir <= true;
    else
        stir <= false;
    end if;
    
    for I in 0 to ROW_E-1 loop
        for J in 0 to LINE_E-1 loop
            if (s_x >= I*(TAILLE_E_X+INTER) + s_off_x_e) and (s_x < I*(TAILLE_E_X+INTER) + s_off_x_e + TAILLE_E_X)
                 and (s_y >= J*(TAILLE_E_Y+INTER) + s_off_y_e) and (s_y < J*(TAILLE_E_Y+INTER) + s_off_y_e + TAILLE_E_Y)
                 then
                det_enemies_alive := true;
                if alive(I+J*ROW_E) = '1' then
                    det_enemies := true;
                end if;
            end if;
        end loop;
    end loop;

    if det_enemies = true then
        senemies <= true;
    else
        senemies <= false;
    end if;
    
    if det_enemies_alive = true then
        salive <= true;
    else
        salive <= false;
    end if;
    
    if det_player = true then
        splayer <= true;
    else
        splayer <= false;
    end if;

end process asynchrone;

fsm : process(etat)
begin
    case(etat) is
        when PLAYER     => s_mult <= 1;
        when ENEMIES    => s_mult <= 2;
        when SHOT       => s_mult <= 3;
        when others     => s_mult <= 0;
    end case;
end process fsm;

mult <= std_logic_vector(to_unsigned(s_mult, 4));

end Behavioral;
