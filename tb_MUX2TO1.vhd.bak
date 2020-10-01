library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_MUX2TO1 IS
END tb_MUX2TO1;

ARCHITECTURE behavior OF tb_MUX2TO1 IS

-- Component Declaration for the UUT

   COMPONENT MUX2TO1 is
   port ( in1     : in  std_logic_vector(3 downto 0);
          in2     : in  std_logic_vector(3 downto 0);
          s       : in  std_logic;
          mux_out : out std_logic_vector(3 downto 0) 
         );
   end COMPONENT;   

	
    signal   s                : std_logic ;
    signal   in1,in2, mux_out : std_logic_vector(3 downto 0);
    constant time_delay       : time := 20 ns;
    
    
    BEGIN
    -- Instantiate the Unit Under Test (UUT)
    
    uut: MUX2TO1 port map ( 
	        in1     => in1,
           in2     => in2,
           s       => s,
           mux_out => mux_out 
          );
 
            
    -- Stimulus process 
      stim_process: process -- this process, in testbench/simulation code, is different than in design code
      begin
		  assert false report "MUX2TO1 testbench started"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
		  wait for time_delay;
		  in1 <= "0000"; in2 <= "0000"; 
        wait for time_delay;
		  s <= '0'; 
		  wait for time_delay;
		  in1 <= "0101"; in2 <= "1010"; 
        wait for time_delay;
		  in1 <= "1010"; in2 <= "0101"; 
        wait for time_delay;
		  s <= '1'; 
		  wait for time_delay;
		  in1 <= "0101"; in2 <= "1010"; 
        wait for time_delay;
		  s <= '0'; 
		  wait for 10*time_delay; -- this extends the time by 10x the time_delay, for ease of veiwing waveforms
		  assert false report "MUX2TO1 testbench completed"; -- puts a note in the ModelSim transcript window (this line is just for convenience)
        wait;	-- this wait without any time parameters just stops the simulation, otherwise it would repeat forever starting back at the top  

	   end process;  
 
END;
