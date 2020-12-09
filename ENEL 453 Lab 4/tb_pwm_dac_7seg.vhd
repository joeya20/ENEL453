-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 9.12.2020 00:47:35 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_PWM_SEVENSEG is
end tb_PWM_SEVENSEG;

architecture tb of tb_PWM_SEVENSEG is

    component PWM_SEVENSEG
        port (reset_n          : in std_logic;
              clk              : in std_logic;
              duty_cycle       : in std_logic_vector (12 downto 0);
              pwm_enable       : in std_logic;
              inverted_pwm_out : out std_logic);
    end component;

    signal reset_n          : std_logic;
    signal clk              : std_logic;
    signal duty_cycle       : std_logic_vector (12 downto 0);
    signal pwm_enable       : std_logic;
    signal inverted_pwm_out : std_logic;

    constant TbPeriod : time := 20 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_SEVENSEG
    port map (reset_n          => reset_n,
              clk              => clk,
              duty_cycle       => duty_cycle,
              pwm_enable       => pwm_enable,
              inverted_pwm_out => inverted_pwm_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        duty_cycle <= (others => '0');
        pwm_enable <= '1';

        -- Reset generation
        -- EDIT: Check that reset_n is really your reset signal
        reset_n <= '0';
        wait for 100 ns;
        reset_n <= '1';
        wait for 100 ns;

     duty_cycle <= "0000110010000";  wait for 10000 * TbPeriod;
	  pwm_enable <= '0'; wait for 10000 * TbPeriod;
	  duty_cycle <= "0111110100000";  wait for 10000 * TbPeriod;
	  duty_cycle <= "0111111111111";  wait for 10000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PWM_SEVENSEG of tb_PWM_SEVENSEG is
    for tb
    end for;
end cfg_tb_PWM_SEVENSEG;