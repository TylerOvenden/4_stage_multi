library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity alu_tb is
end alu_tb;


architecture tb of alu_tb is
	signal r1, r2, r3, o : std_logic_vector(127 downto 0);
	signal instrc : std_logic_vector(24 downto 0);
	constant clk : time := 5us;
begin
	UUT : entity ALU														 
		port map (r1 => r1, r2 => r2, r3 => r3, instrc => instrc, o => o);	

		process begin	
--generated random 128 numbers
r1 <= "01011111100001111101100100000011110110000111101101100111001011001111000100100001100001010000110010111010101001111011010101000011";
r2 <= "11011101100001000100110010111100010111110011101100001111010100111000000011110001110001000111100010111101110010000010100001010111";
r3 <= "10110111001101010111111101101110010000000101001110001001101000110101001001011101101011100011011000110101101110100110101001101010";

--load im 	

instrc <= "0000011101001001001000000"; -- imm	0111010010010010 = hex 7492, position 0		
wait for clk;


	std.env.finish;
		
	end process;	  
	
end tb;
			 	
		
		
		