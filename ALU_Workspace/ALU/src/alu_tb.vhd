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
	UUT : entity alu														 
		port map (r1 => r1, r2 => r2, r3 => r3, instrc => instrc, o => o);	

		process begin	
--generated random 128 numbers		 

r1 <= std_logic_vector(to_unsigned(20, 128));	 
r2 <= std_logic_vector(to_unsigned(30, 128));
r3 <= std_logic_vector(to_unsigned(40, 128));
--r1 <= "01011111100001111101100100000011110110000111101101100111001011001111000100100001100001010000110011111111111111111111111111111111";
--r2 <= "11011101100001000100110010111100010111110011101100001111010100111000000011110001110001000111100010111101110010000010100001010111";
--r3 <= "10110111001101010111111101101110010000000101001110001001101000110101001001011101101011100011011000110101101110100110101001101010";
--
--load im 	

instrc <= "0000011101001001001000000"; -- imm	0111010010010010 = hex 7492, position 0		
wait for clk;		 

 --testing for overflow
--r1 <= std_logic_vector(to_unsigned(4294967295, 128));	 
--r1 <= "01011111100001111101100100000011110110000111101101100111001011001111000100100001100001010000110011111111111111111111111111111111";
--r2 <= "01011111100001111101100100000011110110000111101101100111001011001111000100100001100001010000110011111111111111111111111111111111";
--r3 <= "01011111100001111101100100000011110110000111101101100111001011001111000100100001100001010000110011111111111111111111111111111111";		  

--r4 00


---r1 <= "01011111100001111101100100000011110110000111101101100111001011001111000100100001100001010000110001111111111111111111111111111111";
r2 <= "11011101100001000100110010111100010111110011101100001111010100111000000011110001110001000111100010111101110010000010100001010111";
r3 <= "10110111001101010111111101101110010000000101001110001001101000110101001001011101101011100011011000110101101110100110101001101010";

--All values for r1 16 bit fields are 10
r1(127 downto 112) := X"AA"; --to_stdlogicvector(10x"AA",16);
r1(111 downto 96) <= to_stdlogicvector(x"AA",16);
r1(95 downto 80) <= to_stdlogicvector(x"AA",16);
r1(79 downto 64) <= to_stdlogicvector(x"AA",16);
r1(63 downto 48) <= to_stdlogicvector(x"AA",16);
r1(47 downto 32) <= to_stdlogicvector(x"AA",16);
r1(31 downto 16) <= to_stdlogicvector(x"AA",16);
r1(15 downto 0) <= to_stdlogicvector(x"AA",16);

--All values for r2 16 bit fields are F2
r1(127 downto 112) <= to_stdlogicvector(x"F2",16);
r1(111 downto 96) <= to_stdlogicvector(x"F2",16);
r1(95 downto 80) <= to_stdlogicvector(x"F2",16);
r1(79 downto 64) <= to_stdlogicvector(x"F2",16);
r1(63 downto 48) <= to_stdlogicvector(x"F2",16);
r1(47 downto 32) <= to_stdlogicvector(x"F2",16);
r1(31 downto 16) <= to_stdlogicvector(x"F2",16);
r1(15 downto 0) <= to_stdlogicvector(x"F2",16);


instrc <= "1000000000000000000000000"; -- 32 bit Signed Integer Multiply-Add Low with Saturation
wait for clk;							


--r4 00
instrc <= "1000100000000000000000000"; -- 32 bit Signed Integer Multiply-Add high with Saturation
wait for clk;																			 

--r4 00
instrc <= "1001000000000000000000000"; -- 32 bit Signed Integer Multiply-Add high with Saturation
wait for clk;	


instrc <= "1001100000000000000000000"; -- 32 bit Signed Integer Multiply-Add high with Saturation
wait for clk;	


	std.env.finish;
		
	end process;	  
	
end tb;
			 	
		
		
		
		
		
