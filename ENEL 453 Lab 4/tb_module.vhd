-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 28.11.2020 20:54:37 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_module is
end tb_module;

architecture tb of tb_module is

    component module
        port (reset_n          : in std_logic;
              clk              : in std_logic;
              distance         : in std_logic_vector (13-1 downto 0);
              inverted_pwm_out : out std_logic);
    end component;

    signal reset_n          : std_logic;
    signal clk              : std_logic;
    signal distance         : std_logic_vector (13-1 downto 0);
    signal inverted_pwm_out : std_logic;

    constant TbPeriod : time := 20 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : module
    port map (reset_n          => reset_n,
              clk              => clk,
              distance         => distance,
              inverted_pwm_out => inverted_pwm_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        distance <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset_n is really your reset signal
        reset_n <= '0';
        wait for 100 ns;
        reset_n <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
		  
		  distance <= "0000111000010"; wait for 10000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_module of tb_module is
    for tb
    end for;
end cfg_tb_module;