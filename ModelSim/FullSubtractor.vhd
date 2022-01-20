library IEEE;
use IEEE.std_logic_1164.all;
	
entity FullSubtractor is
	port (
	a		:	in	std_logic;
	b		:	in	std_logic;
	cin		:	in	std_logic;
	s		:	out 	std_logic;
	cout 		:	out 	std_logic
	);
end FullSubtractor;	

architecture arch of FullSubtractor is

component FullAdder
	port (
		a		:	in	std_logic;
		b		:	in	std_logic;
		cin		:	in	std_logic;
		s		:	out 	std_logic;
		cout 		:	out 	std_logic
	);
end component;

signal connection : std_logic;
begin
	internalFullAdder: FullAdder
	port map(
		a		=>	connection,
		b		=>	b,
		cin		=>	cin,
		s		=>	s,
		cout		=>	cout
	);					
	
 connection<= not(a);
	
end arch;