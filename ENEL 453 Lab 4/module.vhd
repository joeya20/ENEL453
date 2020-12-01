library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity module is
			Generic (A : integer := 2000;
						B : integer := 9;
						C : integer := 1600;
						D : integer := 49;
						E : integer := 4;
						max_f : integer := 10;
						min_f : integer := 1
						);
			Port    ( reset_n    : in  STD_LOGIC;
						 clk        : in  STD_LOGIC;
						 distance : in  STD_LOGIC_VECTOR (12 downto 0);
						 output    : out STD_LOGIC
						);
end module;

architecture Behavioral of module is
	signal period : integer;
	signal enable, output_pwm: STD_LOGIC;
	signal downcounter_output : STD_LOGIC;
	signal max_flag,min_flag : STD_LOGIC;
	signal temp_period : integer;
	signal s : STD_LOGIC_VECTOR(1 downto 0);
	signal w : STD_LOGIC_VECTOR(1 downto 0);
	signal temp_enable : STD_LOGIC;

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
			max_flag <= '1' when (to_integer(unsigned(distance)) <= 400) else '0';
			min_flag <= '1' when(to_integer(unsigned(distance)) >= A
			) else '0';
			
			s <= max_flag & min_flag;
			
			with s select 
				temp_period <= 50000000/(max_f) when "10",--max
									50000000/(min_f) when "01", --min
									50000000/(((-B*(to_integer(unsigned(distance)))/C)+(D/E))) when "00",
									0 when others;
									
			with s select 
				temp_enable <= '1' when "10",--max
									'0' when "01", --min
									'1' when "00",
									'0' when others;
									
			assignvalues: process(clk) begin
				if(rising_edge(clk)) then
					period <= temp_period;
					enable <= temp_enable;
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








			
