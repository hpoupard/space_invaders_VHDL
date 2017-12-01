----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2017 09:08:27
-- Design Name: 
-- Module Name: testbench_clk_ennemis - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity tb_clk_ennemis is
end tb_clk_ennemis;

architecture tb of tb_clk_ennemis is

    component clk_ennemis
        port (clk      : in std_logic;
              reset    : in std_logic;
              increase : in std_logic;
              clk_e    : out std_logic);
    end component;

    signal clk      : std_logic;
    signal reset    : std_logic;
    signal increase : std_logic;
    signal clk_e    : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : clk_ennemis
    port map (clk      => clk,
              reset    => reset,
              increase => increase,
              clk_e    => clk_e);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        increase <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 10000 ns;
        increase <= '1';
        wait for 10000000*TbPeriod;
        increase <= '0';

        -- EDIT Add stimuli here
        wait for 100000000*TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_clk_ennemis of tb_clk_ennemis is
    for tb
    end for;
end cfg_tb_clk_ennemis;
