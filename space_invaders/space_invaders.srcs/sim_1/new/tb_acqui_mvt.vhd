library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity acqui_mvt_tb is
end;

architecture bench of acqui_mvt_tb is

  component acqui_mvt
      Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             btn_left : in STD_LOGIC;
             btn_right : in STD_LOGIC;
             left : out STD_LOGIC;
             right : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal btn_left: STD_LOGIC;
  signal btn_right: STD_LOGIC;
  signal left: STD_LOGIC;
  signal right: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: acqui_mvt port map ( clk       => clk,
                            reset     => reset,
                            btn_left  => btn_left,
                            btn_right => btn_right,
                            left      => left,
                            right     => right );

  stimulus: process
  begin
  
    reset <= '0';
    wait for clock_period;
    reset <= '1';
    wait for clock_period;
    btn_left <= '1';
    wait for 50000*clock_period;
    btn_right <= '1';
    wait for 200000*clock_period;

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