library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity memory_acess_image_tb is
end;

architecture bench of memory_acess_image_tb is

  component memory_acess_image
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

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal incr: STD_LOGIC;
  signal x: STD_LOGIC_VECTOR (3 downto 0);
  signal y: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: memory_acess_image generic map ( SIZE_X  => 4,
                                        SIZE_Y  => 4,
                                        LIMIT_X => 16,
                                        LIMIT_Y => 16 )
                             port map ( clk     => clk,
                                        reset   => reset,
                                        incr    => incr,
                                        x       => x,
                                        y       => y );

  stimulus: process
  begin
  
    reset <= '0';
    wait for clock_period;
    reset <= '1';
    wait for 10*clock_period;
    incr <= '1';
    wait for 16*17*clock_period;
    incr <= '0';
    wait for 10*clock_period;

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