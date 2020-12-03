library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.LUT_pkg.all;

entity module is
			Port    ( reset_n    : in  STD_LOGIC;
						 clk        : in  STD_LOGIC;
						 distance : in  STD_LOGIC_VECTOR (12 downto 0);
						 output    : out STD_LOGIC
						);
end module;

architecture Behavioral of module is
	signal period : integer;
	signal downcounter_output : STD_LOGIC;
	signal output_pwm: STD_LOGIC;
	signal enable: STD_LOGIC;

component downcounter is
			Port ( clk     : in  STD_LOGIC; -- clock to be divided
					 reset_n : in  STD_LOGIC; -- active-high reset
				  	 enable  : in  STD_LOGIC; -- active-high enable
					 zero    : out STD_LOGIC;  -- creates a positive pulse every time current_count hits zero
					 period  : in integer
					 );
end component;

component PWM_SEVENSEG is
			Generic (width : integer);
			Port ( reset_n    : in  STD_LOGIC;
					 clk        : in  STD_LOGIC;
					 duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
					 pwm_enable : in 	STD_LOGIC;
					 inverted_pwm_out    : out STD_LOGIC
					 );
end component;

begin

emma : process(distance) begin
	period <= d27seg_LUT(to_integer(unsigned(distance)));
	
	if to_integer(unsigned(distance)) >= 2000 then
		enable <= '0';
	else
		enable <= '1';
	end if;
end process;
		
downcounter_instantiation : downcounter
						Port Map(clk => clk,
									period => period,
									enable => enable,
									reset_n => reset_n,
									zero => downcounter_output
									);
PWM_SEVENSEG_instantiation : PWM_SEVENSEG
						Generic map (width => 2)
						Port Map(
									clk => clk,
									pwm_enable => downcounter_output,
									reset_n => reset_n,
									duty_cycle => "10",
									inverted_pwm_out => output_pwm
									);
   output <=  output_pwm;

end Behavioral;








			
