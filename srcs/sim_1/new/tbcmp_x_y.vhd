library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cmp_x_y_tb is
end;

architecture bench of cmp_x_y_tb is

  component cmp_x_y
      Generic (   SIZE_X : integer range 1 to 8;
                  SIZE_Y : integer range 1 to 8;
                  LIMIT_X : integer range 1 to 256;
                  LIMIT_Y : integer range 1 to 256);
      Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             cmp_x : out STD_LOGIC_VECTOR (SIZE_X - 1 downto 0);
             cmp_y : out STD_LOGIC_VECTOR (SIZE_Y - 1 downto 0);
             addr : out STD_LOGIC_VECTOR(13 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal cmp_x: STD_LOGIC_VECTOR (3 downto 0);
  signal cmp_y: STD_LOGIC_VECTOR (3 downto 0);
  signal addr: STD_LOGIC_VECTOR(13 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: cmp_x_y generic map ( SIZE_X  => 4,
                             SIZE_Y  => 4,
                             LIMIT_X => 16,
                             LIMIT_Y =>  16)
                  port map ( clk     => clk,
                             reset   => reset,
                             cmp_x   => cmp_x,
                             cmp_y   => cmp_y,
                             addr    => addr );

  stimulus: process
  begin
  
    reset <= '0';
    wait for clock_period;
    reset <= '1';
    wait for 16*17*clock_period;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;