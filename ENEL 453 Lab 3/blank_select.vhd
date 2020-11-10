library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity blank_select is
    Port (
				num1       	: in  STD_LOGIC_VECTOR(3 downto 0);
				num2     	: in  STD_LOGIC_VECTOR(3 downto 0);
				blank_out	: out STD_LOGIC_VECTOR(5 downto 0)
          );
end blank_select;


architecture behavioural of blank_select is
begin 

		blank_out <= 	"111100" when (num1 = "0000" and num2 = "0000") else
							"111000" when (num1 = "0000" and num2 /= "0000") else
							"110000";
end behavioural;