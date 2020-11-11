-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 10.11.2020 18:45:19 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_blank_select is
end tb_blank_select;

architecture tb of tb_blank_select is

    component blank_select
        port (num1      : in std_logic_vector (3 downto 0);
              num2      : in std_logic_vector (3 downto 0);
              blank_out : out std_logic_vector (5 downto 0));
    end component;

    signal num1      : std_logic_vector (3 downto 0);
    signal num2      : std_logic_vector (3 downto 0);
    signal blank_out : std_logic_vector (5 downto 0);

begin

    dut : blank_select
    port map (num1      => num1,
              num2      => num2,
              blank_out => blank_out);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        num1 <= (others => '0');
        num2 <= (others => '0');
		  wait for 1000 ns;
		  num2 <= (others => '1');
		  wait for 1000 ns;
		  num1 <= (others => '1');

        -- EDIT Add stimuli here

        wait for 1000 ns;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_blank_select of tb_blank_select is
    for tb
    end for;
end cfg_tb_blank_select;