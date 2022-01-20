library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;


entity IIR_Impulse_tb is
end IIR_Impulse_tb;

architecture arch of IIR_Impulse_tb is	

component IIR  
	
	port (
		clk		:	in	std_logic;
		rst_l		:	in	std_logic;
		X		:	in	std_logic_vector(15 downto 0);	
		Y		:	out	std_logic_vector(15 downto 0)
	);
end component;

	constant T_CLK 		: 	time := 22676 ns; 	
	signal clk		: 	std_logic	:= '0';
	signal rst_l 		: 	std_logic;
	signal X_tb		:	std_logic_vector(15 downto 0);	
	signal Y_tb		:	std_logic_vector(15 downto 0);
	signal enable		:	std_logic	:=	'1';
	signal expected	 	:	std_logic_vector(15 downto 0);

	file file_INPUT : text;
 	file file_OUTPUT : text;
 

begin
	
	Filter: IIR
	port map(
		clk		=>	clk,
 		rst_l		=>	rst_l,
 		X		=>	X_tb,
		y		=>	Y_tb
        );
	
	
	clk <= not clk and enable after T_CLK / 2; 
	
	
	process

	variable v_ILINE     : line;
	variable v_OLINE     : line;
	variable v_ADD_TERM1 : std_logic_vector(15 downto 0);
 	variable v_ADD_TERM2 : std_logic_vector(15 downto 0);
	variable i		: integer:=0;
	
	
	begin
		
	file_open(file_INPUT, "C:\Users\KB\Desktop\iir-audio-filter-fpga-master\db\tb\impulse_in.txt",  read_mode);
    	file_open(file_OUTPUT, "C:\Users\KB\Desktop\iir-audio-filter-fpga-master\db\tb\impulse_out.txt", read_mode);
 
		rst_l <= '0';
		wait until clk'event and clk='1';
		rst_l <= '1';
		
		while not endfile(file_INPUT) and not endfile(file_OUTPUT) loop
			i:=i+1;
			readline(file_INPUT, v_ILINE);
			read(v_ILINE, v_ADD_TERM1);
			readline(file_OUTPUT, v_OLINE);
			read(v_OLINE, v_ADD_TERM2);
			X_tb <= v_ADD_TERM1;
			expected <= v_ADD_TERM2;
			
			
			wait until clk'event and clk='1'; 
			assert (Y_tb = expected)
			report "Inconsistency at line number : " & integer'image(i)
			severity error;
			
		end loop;

	file_close(file_INPUT);
	file_close(file_OUTPUT);	 
		
		enable <= '0';
		end process;

end arch;