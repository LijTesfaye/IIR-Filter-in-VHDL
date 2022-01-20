library IEEE;
use IEEE.std_logic_1164.all;
	
entity FullAdder is
	port (
	a		:	in	std_logic;
	b		:	in	std_logic;
	cin		:	in	std_logic;
	s		:	out 	std_logic;
	cout 		:	out 	std_logic
	);
end FullAdder;	

architecture arch of FullAdder is
begin
	s <= a xor b xor cin;
	cout <= (a and b) or (a and cin) or (b and cin);
end arch;