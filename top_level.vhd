library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
 
entity top_level is
    Port ( clk                           : in  STD_LOGIC;
           reset_n                       : in  STD_LOGIC;
			  SW                            : in  STD_LOGIC_VECTOR (9 downto 0);
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
          );
           
end top_level;

architecture Behavioral of top_level is

Signal Num_Hex0, Num_Hex1, Num_Hex2, Num_Hex3, Num_Hex4, Num_Hex5 : STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');   
Signal DP_in, Blank:  STD_LOGIC_VECTOR (5 downto 0);
Signal switch_inputs: STD_LOGIC_VECTOR (12 downto 0);
Signal bcd:           STD_LOGIC_VECTOR(15 DOWNTO 0);
signal mux_out:		 STD_LOGIC_VECTOR(15 DOWNTO 0);
signal mux_out0:		 STD_LOGIC_VECTOR(15 DOWNTO 0);
signal hex_in: 		 STD_LOGIC_VECTOR(15 DOWNTO 0); -- declaring intermediary signal to pad sw(7:0)
signal gnd:				 STD_LOGIC_VECTOR(15 DOWNTO 0);

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

Component MUX2TO1 IS
	PORT(
		in0     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits
		in1     : in  std_logic_vector(15 downto 0); -- changed input to 16 bits
		s       : in  std_logic;
		mux_out : out std_logic_vector(15 downto 0) -- notice no semi-colon 
		);
END Component;

begin
   Num_Hex0 <= mux_out(3  downto  0); 
   Num_Hex1 <= mux_out(7  downto  4);
   Num_Hex2 <= mux_out(11 downto  8);
   Num_Hex3 <= mux_out(15 downto 12);
   Num_Hex4 <= "0000";
   Num_Hex5 <= "0000";   
   DP_in    <= "000000"; -- position of the decimal point in the display (1=LED on,0=LED off)
   Blank    <= "110000"; -- blank the 2 MSB 7-segment displays (1=7-seg display off, 0=7-seg display on)
   hex_in	<= X"00" & sw(7 downto 0); -- appending sw(7:0) with zeros to make 16 bit mux input
	gnd		<= X"0000";
	
MUX2TO1_ins0 : MUX2TO1
				PORT MAP( 
					in0 		=> gnd,
					in1 		=> hex_in,
					s		   => reset_n,
					mux_out	=> mux_out0
				);
	
MUX2TO1_ins1 : MUX2TO1
					PORT MAP( 
						in0 		=> bcd(15 downto 0),
						in1 		=> mux_out0,
						s   		=> sw(9),
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
                                     
 
LEDR(9 downto 0) <= SW(9 downto 0); -- gives visual display of the switch inputs to the LEDs on board
switch_inputs <= "00000" & SW(7 downto 0);

binary_bcd_ins: binary_bcd                               
   PORT MAP(
      clk      => clk,                          
      reset_n  => reset_n,                                 
      binary   => switch_inputs,    
      bcd      => bcd         
      );
		
end Behavioral;