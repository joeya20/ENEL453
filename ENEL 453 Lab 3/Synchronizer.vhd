library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Synchronizer is
    Port ( clk  	: in  STD_LOGIC;
				A		: in	STD_LOGIC_VECTOR(9 downto 0);
				G		: out	STD_LOGIC_VECTOR(9 downto 0)
          );
end Synchronizer;

architecture Behavioural of Synchronizer is

-- signals
signal E: 	STD_LOGIC_VECTOR(9 downto 0);

-- Components
Component Register_10bits IS
	PORT(
		clk		: in 	std_logic;
		D			: in 	std_logic_vector(9 downto 0);
		Q			: out	std_logic_vector(9 downto 0)
	);
END Component;			

begin

Register_10bits_ins0 : Register_10bits 
				PORT MAP(
							clk		=> clk,
							D			=> A,
							Q			=> E
						);

Register_10bits_ins1 : Register_10bits 
				PORT MAP(
							clk		=> clk,
							D			=> E,
							Q			=> G
						);
end Behavioural;