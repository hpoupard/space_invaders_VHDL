library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cmp_x_y_tb is
end;

architecture bench of cmp_x_y_tb is

  component cmp_x_y
      Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             cmp_x : out STD_LOGIC_VECTOR (9 downto 0);
             cmp_y : out STD_LOGIC_VECTOR (8 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal cmp_x: STD_LOGIC_VECTOR (9 downto 0);
  signal cmp_y: STD_LOGIC_VECTOR (8 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: cmp_x_y port map ( clk   => clk,
                          reset => reset,
                          cmp_x => cmp_x,
                          cmp_y => cmp_y );

  stimulus: process
  begin
  
    reset <= '0';
    wait for clock_period;
    reset <= '1';
    wait for 640*480*clock_period;

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
  