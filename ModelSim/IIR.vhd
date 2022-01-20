library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity IIR is  
	port (
		clk		:	in	std_logic;	
		rst_l		:	in	std_logic;	
		X		:	in	std_logic_vector(15 downto 0); 
		Y		:	out	std_logic_vector(15 downto 0)  
	);
end IIR;	

architecture arch of IIR is	 

type samplesArray is array (0 to 4) of std_logic_vector(17 downto 0);


component parallelFlipFlop
	generic (Nbit : positive := 16);
	port (
		clk		:	in	std_logic; 	
		d		:	in	std_logic_vector(Nbit-1 downto 0);	
		q		:	out	std_logic_vector(Nbit-1 downto	0);	
                rst_l		:	in	std_logic	
	);
end component;


component RippleCarryAdder
	generic (Nbit : positive := 16);
	port (
		a		:	in	std_logic_vector(Nbit-1 downto 0);  
		b		:	in	std_logic_vector(Nbit-1 downto 0); 
		cin		:	in	std_logic;	
		cout		:	out	std_logic;	
		s		:	out	std_logic_vector(Nbit-1 downto 0)  
	);
end component;


component RippleCarrySubtractor
	generic (Nbit : positive := 16);
	port (
	a		:	in	std_logic_vector(Nbit-1 downto 0);  
	b		:	in	std_logic_vector(Nbit-1 downto 0);	
	cout		:	out	std_logic; 
	s		:	out	std_logic_vector(Nbit-1 downto 0)	
	);
end component;

signal sample	:	samplesArray;  
signal add_Out	:	std_logic_vector(17 downto 0); 
signal sub_Out	:	std_logic_vector(17 downto 0); 	
signal mul	:	std_logic_vector(17 downto 0);

begin
	
	mul <= X(15) & X(15) & X;
	sample(0) <=mul;	
	
	GEN: for i in 0 to 2 generate
		Delayer_x: parallelFlipFlop generic map(18) port map(clk, sample(i), sample(i+1),rst_l);
	end generate GEN;

	Adder: RippleCarryAdder
	generic map(18)
	port map (
		a		=>	sample(3),
		b		=>	sub_Out,
		cin		=>	'0',
		cout		=>	open,
		s		=>	add_Out
	);

	Delay_4: parallelFlipFlop
	generic map(18)
	port map (clk, add_Out, sample(4), rst_l);

	
	Substractor: RippleCarrySubtractor
	generic map(18)
	port map (
		a		=>	mul,
		b		=>	sample(4),
		cout		=>	open,
		s		=>	sub_Out
	);
	

	Y <=  sub_Out(15 downto 0);
	
end arch;