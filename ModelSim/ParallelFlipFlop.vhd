library IEEE;
use IEEE.std_logic_1164.all;

entity parallelFlipFlop is   
		generic(Nbit : integer); 
		port(
                        clk     : in 	std_logic;   
			d       : in 	std_logic_vector(Nbit - 1 downto 0);  
			q       : out 	std_logic_vector(Nbit - 1 downto 0);  
			rst_l 	: in 	std_logic   
		);
end parallelFlipFlop;

architecture behavioral of parallelFlipFlop is 	 

begin

	parallel_dff_proc : process(clk, rst_l) 	
	begin
		if(rst_l = '0') then 					
			q <= (others => '0'); 

		elsif (rising_edge(clk)) then 			
			q <= d; 					
		end if;
	end process;

end behavioral;
