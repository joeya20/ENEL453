library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4TO1 is	
	port( 
		in0     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	hex
		in1     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	bcd
		in2     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	stored
		in3     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	5A5A
		s       : in  std_logic_vector( 1 downto 0); -- 2 bit select input
		mux_out : out std_logic_vector(15 downto 0) -- notice no semi-colon 
	);
end MUX4TO1; -- can also be written as "end entity;" or just "end;"

architecture BEHAVIOR of MUX4TO1 is
	begin
		with s select
			mux_out <= 	in0 when "00",
							in1 when "01",
							in2 when "10",
							in3 when others;
end BEHAVIOR; -- can also be written as "end;"
