library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity top_level is
    Port ( clk                           : in  STD_LOGIC;
           reset_n                       : in  STD_LOGIC;
			  set 						        : in  STD_LOGIC;
           SW                            : in  STD_LOGIC_VECTOR (9 downto 0);
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
          );
           
end top_level;

architecture Behavioral of top_level is

-- signals
Signal Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');   
Signal DP_in, Blank:   	STD_LOGIC_VECTOR (5 downto 0);
Signal switch_inputs:  	STD_LOGIC_VECTOR(12 downto 0);
Signal bcd:        		STD_LOGIC_VECTOR(15 DOWNTO 0);
signal hex_mux_out:	 	STD_LOGIC_VECTOR(15 DOWNTO 0);
signal mux_out:		 	STD_LOGIC_VECTOR(15 DOWNTO 0);
signal hex_in: 		 	STD_LOGIC_VECTOR(15 DOWNTO 0); -- declaring intermediary signal to pad sw(7:0)
signal gnd:				 	STD_LOGIC_VECTOR(15 DOWNTO 0);
signal default:			STD_LOGIC_VECTOR(15 DOWNTO 0);
signal stored_number:	STD_LOGIC_VECTOR(15 DOWNTO 0);
signal sync_output:		STD_LOGIC_VECTOR (9 downto 0);
signal debounce_result:          STD_LOGIC;
-- Components
Component SevenSegment is
    Port( Num_Hex0,Num_Hex1,Num_Hex2,Num_Hex3,Num_Hex4,Num_Hex5 : in  STD_LOGIC_VECTOR (3 downto 0);
          Hex0,Hex1,Hex2,Hex3,Hex4,Hex5                         : out STD_LOGIC_VECTOR (7 downto 0);
          DP_in,Blank                                           : in  STD_LOGIC_VECTOR (5 downto 0)
			);
End Component ;

Component binary_bcd IS
   PORT(
      clk     : IN  STD_LOGIC;                      --system clock
      reset_n : IN  STD_LOGIC;                      --active low asynchronus reset_n
      binary  : IN  STD_LOGIC_VECTOR(12 DOWNTO 0);  --binary number to convert
      bcd     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)   --resulting BCD number
		);           
END Component;

Component debounce IS 
	PORT(
		clk               : in std_logic; 
		button  				: in std_logic;
		result            : out std_logic
	);
END Component;

Component MUX2TO1 IS
	PORT(
		in0     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits
		in1     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits
		s       : in  std_logic;
		mux_out : out std_logic_vector(15 downto 0) -- notice no semi-colon 
		);
END Component;

Component MUX4TO1 IS
	PORT(
		in0     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	hex
      in1     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	bcd
      in2     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	stored
      in3     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits	5A5A
      s       : in  std_logic_vector( 1 downto 0); -- 2 bit select input
      mux_out : out std_logic_vector(15 downto 0) -- notice no semi-colon 
      );
END Component;

Component Register_16bits IS
	PORT(
		clk		: in 	std_logic;
		reset_n	: in 	std_logic;
		enable   : in  std_logic;
		D			: in 	std_logic_vector(15 downto 0);
		Q			: out	std_logic_vector(15 downto 0)
	);
END Component;			

Component Synchronizer is
    Port ( clk  	: in  STD_LOGIC;
				A		: in	STD_LOGIC_VECTOR(9 downto 0);
				G		: out	STD_LOGIC_VECTOR(9 downto 0)
          );
end Component;
	
begin
   Num_Hex0 <= mux_out(3  downto  0); 
   Num_Hex1 <= mux_out(7  downto  4);
   Num_Hex2 <= mux_out(11 downto  8);
   Num_Hex3 <= mux_out(15 downto 12);
   Num_Hex4 <= "0000";
   Num_Hex5 <= "0000";   
   DP_in    <= "000000"; -- position of the decimal point in the display (1=LED on,0=LED off)
   Blank    <= "110000"; -- blank the 2 MSB 7-segment displays (1=7-seg display off, 0=7-seg display on)
   hex_in	<= X"00" & sync_output(7 downto 0); -- appending sw(7:0) with zeros to make 16 bit mux input
	gnd		<= X"0000";
	default 	<= X"5A5A";

btn_debounce : debounce 
					PORT MAP (
						clk      => clk,
						button   => set,
						result   => debounce_result
					);
	
Synchronizer_ins0 : Synchronizer
						PORT MAP(
							clk	=> clk,
							A		=> sw(9 downto 0),
							G		=> sync_output
						);
						
Number_storer: Register_16bits
						PORT MAP(
							clk		=> clk,
							reset_n	=> reset_n,
							enable	=> debounce_result,
							D			=> mux_out,
							Q			=> stored_number
						);
	
Hex_reset : MUX2TO1
						PORT MAP( 
							in0 		=> gnd,
							in1 		=> hex_in,
							s		   => reset_n,
							mux_out	=> hex_mux_out
						);
	
MUX4TO1_ins0 : MUX4TO1
						PORT MAP( 
							in0 		=> bcd(15 downto 0),
							in1 		=> hex_mux_out,
							in2		=> stored_number,
							in3		=> default,
							s   		=> sync_output(9 downto 8),
							mux_out	=> mux_out
						);
					
SevenSegment_ins: SevenSegment
                  PORT MAP( Num_Hex0 => Num_Hex0,
                            Num_Hex1 => Num_Hex1,
                            Num_Hex2 => Num_Hex2,
                            Num_Hex3 => Num_Hex3,
                            Num_Hex4 => Num_Hex4,
                            Num_Hex5 => Num_Hex5,
                            Hex0     => Hex0,
                            Hex1     => Hex1,
                            Hex2     => Hex2,
                            Hex3     => Hex3,
                            Hex4     => Hex4,
                            Hex5     => Hex5,
                            DP_in    => DP_in,
									 Blank    => Blank
                          );


binary_bcd_ins: binary_bcd                               
						PORT MAP(
							clk      => clk,                          
							reset_n  => reset_n,                                 
							binary   => switch_inputs,    
							bcd      => bcd         
							);
		
		
LEDR(9 downto 0) <= sync_output(9 downto 0); -- gives visual display of the switch inputs to the LEDs on board
switch_inputs <= "00000" & sync_output(7 downto 0);

end Behavioral;