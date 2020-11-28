library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity module is
		Generic ( width : integer := 13);

			Port    ( reset_n    : in  STD_LOGIC;
						 clk        : in  STD_LOGIC;
						 distance : in  STD_LOGIC_VECTOR (width-1 downto 0);
						 inverted_pwm_out    : out STD_LOGIC
						);
end module;

architecture Behavioral of module is
	signal period : integer;
	signal downcounter_output : STD_LOGIC;

component downcounter is
			Port ( clk     : in  STD_LOGIC; -- clock to be divided
					 reset_n : in  STD_LOGIC; -- active-high reset
				  	 enable  : in  STD_LOGIC; -- active-high enable
					 zero    : out STD_LOGIC;  -- creates a positive pulse every time current_count hits zero
					 period  : integer
					 );
end component;

component PWM_SEVENSEG is
			Port ( reset_n    : in  STD_LOGIC;
					 clk        : in  STD_LOGIC;
					 duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
					 inverted_pwm_out    : out STD_LOGIC
					 );
end component;

begin
		denis : process(clk) begin
		if (rising_edge(clk)) then
			if (to_integer(unsigned(distance)) <= 400) then		-- min frequency ~4cm
				period <= 50000000/(16384*10);
			elsif (to_integer(unsigned(distance)) >= 3000) then
				period <= 50000000/(16384*1);
			else 	-- eqn = -9x/2600 + 148/15
				period <= 50000000/(16384*(-9*(to_integer(unsigned(distance)))/2600)+(148/15));
			end if;
		end if;
end process;
		
downcounter_instantiation : downcounter
						Port Map(clk => clk,
									period => period,
									enable => '1',
									reset_n => reset_n,
									zero => downcounter_output
									);
PWM_SEVENSEG_instantiation : PWM_SEVENSEG
						Port Map(clk => downcounter_output,
									reset_n => reset_n,
									duty_cycle => "0100000000000",
									inverted_pwm_out => inverted_pwm_out
									);
   

end Behavioral;
























						