library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_10bits is	
	port(
		clk	: in 	std_logic;
		D		: in 	std_logic_vector(9 downto 0);
		Q		: out	std_logic_vector(9 downto 0)
	);
end Register_10bits; -- can also be written as "end entity;" or just "end;"

architecture BEHAVIOR of Register_10bits is
	begin
		process(clk)
		begin
			if rising_edge(clk) then
				Q <= D;
			end if;
		end process;
		
end BEHAVIOR; -- can also be written as "end;"