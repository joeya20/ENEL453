library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2TO1 is
port ( bin     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits
       hex     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits
       s       : in  std_logic;
       mux_out : out std_logic_vector(15 downto 0) -- notice no semi-colon 
      );
end MUX2TO1; -- can also be written as "end entity;" or just "end;"

architecture BEHAVIOR of MUX2TO1 is
	begin
		with s select
			mux_out <= bin when '0', -- when s is '0' then mux_out becomes in1
			           hex when others;
end BEHAVIOR; -- can also be written as "end;"
