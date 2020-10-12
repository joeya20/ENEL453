-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 6.10.2020 16:32:38 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

    component top_level
        port (clk     : in std_logic;
              reset_n : in std_logic;
              SW      : in std_logic_vector (9 downto 0);
              LEDR    : out std_logic_vector (9 downto 0);
              HEX0    : out std_logic_vector (7 downto 0);
              HEX1    : out std_logic_vector (7 downto 0);
              HEX2    : out std_logic_vector (7 downto 0);
              HEX3    : out std_logic_vector (7 downto 0);
              HEX4    : out std_logic_vector (7 downto 0);
              HEX5    : out std_logic_vector (7 downto 0));
    end component;

    signal clk     : std_logic;
    signal reset_n : std_logic;
    signal SW      : std_logic_vector (9 downto 0);
    signal LEDR    : std_logic_vector (9 downto 0);
    signal HEX0    : std_logic_vector (7 downto 0);
    signal HEX1    : std_logic_vector (7 downto 0);
    signal HEX2    : std_logic_vector (7 downto 0);
    signal HEX3    : std_logic_vector (7 downto 0);
    signal HEX4    : std_logic_vector (7 downto 0);
    signal HEX5    : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 20 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_level
    port map (clk     => clk,
              reset_n => reset_n,
              SW      => SW,
              LEDR    => LEDR,
              HEX0    => HEX0,
              HEX1    => HEX1,
              HEX2    => HEX2,
              HEX3    => HEX3,
              HEX4    => HEX4,
              HEX5    => HEX5);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SW <= (others => '0');
		  
        -- Reset generation
        -- EDIT: Check that reset_n is really your reset signal
        reset_n <= '0'; wait for 100 ns;
        reset_n <= '1'; wait for 100 ns; wait for 1000 * TbPeriod;

        -- EDIT Add stimuli here
		  sw <= "0000001001"; wait for 1000 * TbPeriod;
        sw <= "1000001001"; wait for 1000 * TbPeriod;
		  sw <= "0000001010"; wait for 1000 * TbPeriod;
		  sw <= "1000001010"; wait for 1000 * TbPeriod;
		  reset_n <= '0'; wait for 1000 * TbPeriod; 
        reset_n <= '1'; wait for 1000 * TbPeriod;
		  sw <= "0001000001"; wait for 1000 * TbPeriod;
		  sw <= "1001000001"; wait for 1000 * TbPeriod;
		  sw <= "0010000000"; wait for 1000 * TbPeriod;
		  reset_n <= '0';    wait for 100 ns; wait for 1000 * TbPeriod; 
        reset_n <= '1';    wait for 100 ns; wait for 1000 * TbPeriod; 
		  sw <= "1010000000"; wait for 1000 * TbPeriod;
		  sw <= "1011111111"; wait for 1000 * TbPeriod; 
		  wait for 1000 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
