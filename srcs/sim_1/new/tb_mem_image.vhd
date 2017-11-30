library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mem_image_tb is
end;

architecture bench of mem_image_tb is

  component mem_image
      Generic (   BITS_PER_COLOR  : integer range 1 to 4 := 4;
                  MEM_X           : integer range 1 to 10 := 4;
                  MEM_Y           : integer range 1 to 10 := 4;           
                  SIZE_X          : integer range 1 to 1024 := 16;
                  SIZE_Y          : integer range 1 to 1024 := 16;
                  IMAGE_NAME      : string);
      Port (      clk         : in STD_LOGIC;
                  addr_x      : in STD_LOGIC_VECTOR (MEM_X-1 downto 0);
                  addr_y      : in STD_LOGIC_VECTOR (MEM_Y-1 downto 0);          
                  data_out    : out STD_LOGIC_VECTOR (BITS_PER_COLOR*3 - 1 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal addr_x: STD_LOGIC_VECTOR (7 downto 0);
  signal addr_y: STD_LOGIC_VECTOR (7 downto 0);
  signal data_out: STD_LOGIC_VECTOR (11 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: mem_image generic map ( BITS_PER_COLOR => 4,
                               MEM_X          => 8,
                               MEM_Y          => 8,
                               SIZE_X         => 160,
                               SIZE_Y         => 100,
                               IMAGE_NAME     =>  "test.bin")
                    port map ( clk            => clk,
                               addr_x         => addr_x,
                               addr_y         => addr_y,
                               data_out       => data_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
    addr_x <= "00000000";
    addr_y <= "00000000";
    wait for clock_period;
    addr_x <= "00000001";
    addr_y <= "00000000";
    wait for clock_period;
    addr_x <= "00000000";
    addr_y <= "00000001";
    wait for 2*clock_period;    

    -- Put test bench stimulus code here

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