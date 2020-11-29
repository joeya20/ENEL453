library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PWM_DAC is
   Generic ( width : integer := 13);

   Port    ( reset_n    : in  STD_LOGIC;
             clk        : in  STD_LOGIC;
             duty_cycle : in  STD_LOGIC_VECTOR (width-1 downto 0);
             inverted_pwm_out    : out STD_LOGIC
           );
end PWM_DAC;

architecture Behavioral of PWM_DAC is
   signal counter : unsigned (width-1 downto 0);
   signal pwm_out	: STD_LOGIC;
	constant max_length : integer := 4095;
	signal toCompare : unsigned (width-1 downto 0);
	
begin
	toCompare <= to_unsigned(max_length, toCompare'length) - unsigned(duty_cycle);
   count : process(clk,reset_n)
   begin
       if( reset_n = '0' ) then
           counter <= (others => '0');
       elsif (rising_edge(clk)) then
           counter <= counter + 1;
       end if;
   end process;
	
   compare : process(counter, toCompare)
   begin 
       if (counter < toCompare) then
           pwm_out <= '1';
       else 
           pwm_out <= '0';
       end if;
   end process;
  
  inverted_pwm_out <=  pwm_out;
  
end Behavioral;

