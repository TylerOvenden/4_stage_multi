library IEEE;
use IEEE.std_logic_1164.all;	 
use ieee.numeric_std.all;


package instr_pack is 
	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
end package;




	
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	



package regfile_pack is 	
	
	type regFile is array (0 to 31) of std_logic_vector(127 downto 0);
----	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
end package;






library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	
use work.instr_pack.all;



entity instruction_buffer is
--generic (	
--in_buffer: in InstBuff;
--n : integer := 6; -- 2^6 = 64 values for pc
--buffer_size : integer := 64;	 
--width : integer := 2;	
--inst_size : integer := 25
----subtype instr is std_logic_vector(24 downto 0);
----type instr_buffer is array (0 to 63 ) of instr; 
--
--
--);
port (
clk : in std_logic; -- system clock
reset : in std_logic; -- synchrounous counter clear		  
--write: in std_logic;	--write signal	   
 in_buffer: in InstBuff;
--pc : in std_logic_vector(n-1 downto 0);
instr_in : in std_logic_vector(24 downto 0);	

instr_out : out std_logic_vector(24 downto 0)
--pc : out std_logic_vector(n-1 downto 0)
);

end instruction_buffer;

			 
architecture behaviorhal of instruction_buffer is	

--type InstBuff is array (0 to buffer_size-1) of std_logic_vector(24 downto 0);

--signal ins : InstBuff;

--variable temp : integer;
begin
	process (clk)
		variable pc : integer range 0 to 63 := 0;
	begin	
		
		
		
		
if rising_edge(clk)		 then 		 
						  
	
	
	instr_out <= in_buffer(pc);	  
	--in_buffer(pc) <=  std_logic_vector(to_unsigned(0, 25));
	--			
	if(pc = 63) then  
		pc := 0;
	else 		
	pc := pc + 1;
		 end if;
end if;
 --pc := std_logic_vector(to_unsigned(count));
end process;						   

end behaviorhal;	




library ieee;
use ieee.std_logic_1164.all; 




entity IF_ID is
	port(
	clk : in std_logic;
	instr_in : in std_logic_vector(24 downto 0);
	instr_out : out std_logic_vector(24 downto 0)
	);
end IF_ID;

architecture behavioral of IF_ID is
begin
	process (clk)
	begin
		if rising_edge(clk) then
	
			instr_out <= instr_in;
		end if;
	end process;
end behavioral;	   




library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	
	
	
	
	
entity register_file is
generic (n : integer := 128; --constant for bits
registers : integer := 32;	 
length_instr : integer := 25	


);
port (clk : in std_logic; -- system clock	
write : out std_logic; --write signal	

reset :  in std_logic;
 

instrc : in std_logic_vector(length_instr-1 downto 0);	   


--rd_address: in std_logic_vector(4 downto 0);

rs1_data : out std_logic_vector(n-1 downto 0);	  
rs2_data : out std_logic_vector(n-1 downto 0);	
rs3_data : out std_logic_vector(n-1 downto 0);
rd_data : in std_logic_vector(n-1 downto 0)	




);				 


end register_file;

			 
architecture behaviorhal of register_file is 

	type regFile is array (0 to registers-1) of std_logic_vector(n-1 downto 0);
	signal regs  : regFile;

begin  
	process(clk) 
	begin	  
	
		if rising_edge(clk) then	
			
			if(reset = '1')then 
		  
		
				regs(0) <= "11111111000000010000110011001011100001101100000001000001100010100010111111101110111111111011010101100111100100011100011111001000";
				
				regs(1) <= "01100000000011100010101010110100110100110100101110111110011101101111011010110101111000011001101001111001000101101101110011101000";
				regs(2) <= "00011100010110010101000111100001101011100101010101011101000111000110101111010111100100101000100000000110111010001011100000010100";
				regs(3) <= "10111000110010011000011110100001111100101001011100100000000111011001110000011110011010000001001011100111010001101000001010001101";
				regs(4) <= "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
				regs(5) <= "11100011110010101001111100110011011100110101011001111000010010001011111000000101100001011001110110100001000110110000001001011110";
				regs(6) <= "10111110110000001111100000110111100011001011100101110101010111101100001100010110111000000110001011011111000000010101010011110101";
				regs(7) <= "10010011110010111110101010111101100000110011110010001111101001000110101010010110110111111110001100110000110000101101110110101100";
				regs(8) <= "11011111100100011100111111101110101100001000101010100011100100001010000110000110010011100000100010101110100111010001111010011001";
				
				regs(9) <= "10010111101010000010111111000001000100100101100010010000000010001001110101000010101011011101010001110101111101101110110001010000";
				regs(10) <= "01001000011001101111111110100100110011000011001000111100010100010110101111010011101110010010001000000001001101011100100000101110";
				regs(11) <= "01100011001011011100010000111110011001000000111001101010001111011100000101010000010010001011001111100000001111010110111100011101";
				regs(12) <= "10111000110010011000011110100001111100101001011100100000000111011001110000011110011010000001001011100111010001101000001010001101";

				regs(13) <= "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
				regs(14) <= "11101011110001010100111101011010000100110110111011010100101000001111001000111000100101000101001100101101110100100111000001110011";	
				regs(15) <= "01111101010010011100101000111001100111000101010111010011011000101101111101101011011001111000000101110111101010011100101110110010";	
				regs(16) <= "00010100100110100000100100111001001010110011011010010010010011111100111111011100101001001010100011101100101011100100100001101111";	
				regs(17) <= "01001100110001110100010000101110000110101101000010011101000100001111001100100011110011111110010011011011010001011010111111110011";
				regs(18) <= "01000000001001101110111001100111011000100110101000011000000000111010111001101111111110011000100100000001111011110100011000001111";
				regs(19) <= "00000100101101010011010110011111010111011010111111011010110000101001111000010101000011101110100000000011000111111010101101010010";
				regs(20) <= "10100101101100111111001110111110010010001000110011111010001111001011110111111010110011010110011011011100101010011100111010010100";
				regs(21) <= "00100100010000001001110000011100000010110011101001110101110111100010010001011111100101110001110111101110001011010111100001001000";
				regs(22) <= "11001011001101010111110011100000110110111111101001010110101011111010010011001010101000101010010010010001000111101010100110000100";
				regs(23) <= "00010110010100101101111001000011010110111100101101111111011110000001100101000111010000111000000111011011111000100010100111100001";
				regs(24) <= "00001010110101110111111001001010111001001010010101101100110001001000110110110010001010011011111101000100111010100110101000010100";
				regs(25) <= "11001001011101111010010110111100000010011001001010101000001110110001100101111110000000101110110000110010110110110010001010000011";
				regs(26) <= "00100100001100010000100000011010111000010010101101101011001110110000011101001111100001111001011110011001100001110101101111001111";
				regs(27) <= "10100000101001000110011110011010111101011101011010101100110000101010001111010111001101101001110100011111110010101111000010100000";
				regs(28) <= "00001101000010010111001100110110111001010100011110011111100101010011001011001001000011000001000101111010100010101010111000111010";
				regs(29) <= "11001000110010111010111010101110011011010101011001010101010010100011111100000011110111010111101011010100011110100000010001010011";
				regs(30) <= "11101111100010010110111110100100000100110100000110001000111001011100010110000100110001100111010110111111011001011011111000111011";
				regs(31) <= "11010000000110000110000110111000100111000001111001011100011011001100100011101101000110010010001010001100100010001101101000110101";		  
				
				--run load immadiate 
				
				
			
			end if;	
				
				write <= '1';
			--r4 instructions	
			elsif 	(instrc(24 downto 23) = "10") then 	  
				rs1_data <= regs(to_integer(unsigned(instrc(19 downto 15))));
				rs2_data <= regs(to_integer(unsigned(instrc(14 downto 10))));
				rs3_data <= regs(to_integer(unsigned(instrc(9 downto 5))));	 
				
	
				--write
				regs(to_integer(unsigned(instrc(4 downto 0)))) <= rd_data;
				
				
				
				
			elsif 	(instrc(24 downto 23) = "11") then 	
				rs1_data <= regs(to_integer(unsigned(instrc(19 downto 15))));
				rs2_data <= regs(to_integer(unsigned(instrc(14 downto 10))));
				
				
				--if(write = '1') then	
					if instrc(18 downto 15) = "0000" then 
						write <= '0';	
						
				else 		
						
				
					
				regs(to_integer(unsigned(instrc(4 downto 0)))) <= rd_data;	
					
				
			
		end if;
		
	
		--load immidate 
	    elsif (instrc(24 downto 23) = "1") then 
			regs(to_integer(unsigned(instrc(4 downto 0)))) <= rd_data;	
			
 
					end if;
				
		
	 
	end process;
	
	
end behaviorhal;	
	




library ieee;
use ieee.std_logic_1164.all;

entity IF_EX is
	port(
	clk : in std_logic;
	instr_in : in std_logic_vector(24 downto 0);  
	
	rs1_data_in : in std_logic_vector(127 downto 0);	  
	rs2_data_in : in std_logic_vector(127 downto 0);	
	rs3_data_in : in std_logic_vector(127 downto 0);
	rd_data_in : in std_logic_vector(127 downto 0);		   
	
	
	
	rs1_data_out : out std_logic_vector(127 downto 0);	  
	rs2_data_out : out std_logic_vector(127 downto 0);	
	rs3_data_out : out std_logic_vector(127 downto 0);
	rd_data_out : out std_logic_vector(127 downto 0);
	
	
	
	
	
	
	instr_out : out std_logic_vector(24 downto 0)
	);
end IF_EX;

architecture behavioral of IF_EX is
begin
	process (clk)
	begin
		if rising_edge(clk) then	  
			
			
			rs1_data_out <=  rs1_data_in;	 
			rs2_data_out <=  rs2_data_in;
			rs3_data_out <=  rs3_data_in;
			rd_data_out <=  rd_data_in;
			
		
		end if;
	end process;
end behavioral;				  							  



--alu 

library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;

entity ALU is
	port(
		 
		 r1 : in STD_LOGIC_VECTOR(127 downto 0);
		 r2 : in STD_LOGIC_VECTOR(127 downto 0);
		 r3 : in STD_LOGIC_VECTOR(127 downto 0);
		 instrc: in STD_LOGIC_VECTOR(24 downto 0);
		 o : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU_Behavior of ALU is		

begin
process(r1, r2, r3, instrc)

	


variable index : integer;	--temp variable used for storing load index
variable tempRes: signed (63 downto 0);	   --need to be 64 for possible overflow   
variable temp_int0:integer:=0;
variable temp_int1:integer:=0;	
variable temp_int2:integer:=0;	
variable temp_int3:integer:=0;	 


variable tempRes128: signed (127 downto 0);		 



variable testMult: std_logic_vector(130 downto 0);	
variable testRes: std_logic_vector(130 downto 0);
variable testRes1: std_logic_vector(32 downto 0);		 	
variable testRes2: std_logic_vector(64 downto 0);	
variable testMult1: std_logic_vector(32 downto 0);	
variable testMult2: std_logic_vector(64 downto 0);	
variable rd: std_logic_vector(127 downto 0);

constant max16 : std_logic_vector(15 downto 0) := "0111111111111111";
constant min16 : std_logic_vector(15 downto 0) := "1000000000000000"; 	
constant max32: std_logic_vector(31 downto 0):= "01111111111111111111111111111111"; 	 
constant min32: std_logic_vector(31 downto 0) := X"80000000";
constant max64: std_logic_vector(63 downto 0):= X"7FFFFFFFFFFFFFFF"; 
constant min64: std_logic_vector(63 downto 0) := X"8000000000000000";	 


constant max16_int: integer:= 65535;
constant min16_int: integer:= -65536;
constant max32_int : integer := 2147483647; 
constant min32_int : integer :=  -2147483648; 




variable counter: integer:=0; 		--counter for counting ones
variable tempPos : integer;  	
variable temp : std_logic_vector(31 downto 0); -- general temp variable, currently using in ROTW	
	
	
	begin  		
		
		
		--load immeditate
		if instrc(24) = '0' then
			
			
			o <= r1;
			
			--convert load index into a multiple of 16
			index := to_integer(signed(instrc(23 downto 21))) * 16; 	
			
			--load immeditate 
			o(index + 15 downto index) <= instrc(20 downto 5);
			
			
			
			--r4	
				elsif 	(instrc(24 downto 23) = "10") then 	
			
					
					
					--Signed Integer Multiply-Add Low with Saturation
				--y low 16-bit-fields for rs3, rs2
				if (instrc(22 downto 20) = "000")	then 
					--using this to check overflow
					--		o(31 downto 0)<= std_logic_vector(resize(signed(r3(31 downto 0))+ signed(r1(31 downto 0)), 32));
				
					
					for i in 0 to 3 loop
					
						--example
					-- std_logic_vector(resize(signed(r1(31 downto 0))+ signed(r2(31 downto 0)), 32)); 
					tempPos := 32 * i;	 						
					
					
					testMult1(32 downto 0) := std_logic_vector(resize(signed(r3(tempPos+15 downto tempPos))* signed(r2(tempPos+15 downto tempPos)), 33));
			testRes1(32 downto 0) := std_logic_vector(resize(signed(testMult1(32 downto 0))+ signed(r1(tempPos+31 downto tempPos)), 33)); 
				--	testRes1(32 downto 0) := std_logic_vector(resize(signed(r1(tempPos+31 downto tempPos))+  (signed(r3(tempPos+15 downto tempPos))* signed(r2(tempPos+15 downto tempPos))), 33)); 
					
					if(signed(testRes1(32 downto 0)) >   signed( max32)) then		   
						
						
					--	if testRes1(32) = '1' then
						o(tempPos+31 downto tempPos)<= "01111111111111111111111111111111";		 
						
					elsif(signed(testRes1(32 downto 0)) <  signed( min32)) then
						o(tempPos+31 downto tempPos)<= "10000000000000000000000000000000";		
							   
					else											 
						
						o(tempPos+31 downto tempPos)<= testRes1(31 downto 0);
					
					 end if;
				end loop;						 
			--		o(31 downto 0) <= std_logic_vector(resize(signed(r3(15 downto 0))+ signed(r1(31 downto 0)), 32)); 
					
					 
   		  
				
				
				elsif (instrc(22 downto 20) = "001")	then 		  
					for i in 0 to 3 loop
						tempPos := 32 * i;	 					
						
						
		
						
					testMult1(32 downto 0) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos+16))* signed(r2(tempPos+31 downto tempPos+16)), 33));
					testRes1(32 downto 0) := std_logic_vector(resize(signed(testMult1(32 downto 0))+ signed(r1(tempPos+31 downto tempPos)), 33)); 
					
					
						if(signed(testRes1(32 downto 0)) >   signed( max32)) then		   
						
						
					--	if testRes1(32) = '1' then
						o(tempPos+31 downto tempPos)<= "01111111111111111111111111111111";		 
						
					elsif(signed(testRes1(32 downto 0)) <  signed( min32)) then
						o(tempPos+31 downto tempPos)<= "10000000000000000000000000000000";		
							   
					else											 
						
						o(tempPos+31 downto tempPos)<= testRes1(31 downto 0);
						
						
				
						end if;
					
					
				end loop;	
				
				
				
				
				elsif (instrc(22 downto 20) = "010")	then 
						
					--using this to check overflow
					--		o(31 downto 0)<= std_logic_vector(resize(signed(r3(31 downto 0))+ signed(r1(31 downto 0)), 32));
				
					
					for i in 0 to 3 loop
					
						--example
					-- std_logic_vector(resize(signed(r1(31 downto 0))+ signed(r2(31 downto 0)), 32)); 
					tempPos := 32 * i;	 						
					
					
					testMult(tempPos+32 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+15 downto tempPos))* signed(r2(tempPos+15 downto tempPos)), 33));
					testRes(tempPos+32 downto tempPos) := std_logic_vector(resize(signed(r1(tempPos+31 downto tempPos))- signed(testMult(tempPos+32 downto tempPos)), 33)); 
					
					
						if(signed(testRes(tempPos+32 downto tempPos)) >   signed( max32)) then
						o(tempPos+31 downto tempPos)<= "01111111111111111111111111111111";		 
						
					elsif(signed(testRes(tempPos+32 downto tempPos)) <  signed( min32)) then
						o(tempPos+31 downto tempPos)<= "10000000000000000000000000000000";		
							   
					else											 
						
						o(tempPos+31 downto tempPos)<= testRes(tempPos+31 downto tempPos);
					
					 end if;
				end loop;		
					
					
				--	for i in 0 to 3 loop
--						tempPos := 32 * i;	 
--					testMult(tempPos+31 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+15 downto tempPos))* signed(r2(tempPos+15 downto tempPos)), 32));
--					
--					o(tempPos+31 downto tempPos)<= std_logic_vector(resize(signed(r1(tempPos+31 downto tempPos))- signed(testMult(tempPos+31 downto tempPos)), 32)); 
--					
--				
--				end loop;	
					   
			elsif (instrc(22 downto 20) = "011")	then 	
									
					
	
				for i in 0 to 3 loop	  
					
						tempPos := 32 * i;	 					
						
						
					testMult(tempPos+32 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos+16))* signed(r2(tempPos+31 downto tempPos+16)), 33));
					testRes(tempPos+32 downto tempPos) := std_logic_vector(resize(signed(r1(tempPos+31 downto tempPos))- signed(testMult(tempPos+32 downto tempPos)), 33)); 
					
					
						if(signed(testRes(tempPos+32 downto tempPos)) >   signed( max32)) then
						o(tempPos+31 downto tempPos)<= "01111111111111111111111111111111";		 
						
					elsif(signed(testRes(tempPos+32 downto tempPos)) <  signed( min32)) then
						o(tempPos+31 downto tempPos)<= "10000000000000000000000000000000";			
							   
					else											 
						
						o(tempPos+31 downto tempPos)<= testRes(tempPos+31 downto tempPos);
						
						
					--	testMult(tempPos+31 downto tempPos) := std_logic_vector(resize(signed(r2(tempPos+31 downto tempPos+15))* signed(r3(tempPos+31 downto tempPos+15)), 32));
--					
--						o(tempPos+31 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+31 downto tempPos))+ signed(r1(tempPos+31 downto tempPos)), 32)); 
					end if;
					
					
					
					
					
					
						
				end loop;	  
					   
					   
			elsif (instrc(22 downto 20) = "100")	then	 
				
		

					for i in 0 to 1 loop		 
	
	
						tempPos := 64 * i;	 						
					
					
					testMult(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos))* signed(r2(tempPos+31 downto tempPos)), 65));
					testRes(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(testMult(tempPos+64 downto tempPos))+ signed(r1(tempPos+63 downto tempPos)), 65)); 
					
						if(signed(testRes(tempPos+64 downto tempPos)) >   signed( max64)) then
						o(tempPos+63 downto tempPos)<= "0111111111111111111111111111111111111111111111111111111111111111";			 
						
					elsif(signed(testRes(tempPos+64 downto tempPos)) <  signed( min64)) then
						o(tempPos+63 downto tempPos)<= "1000000000000000000000000000000000000000000000000000000000000000";		
					
						   
					else											 
						
						o(tempPos+63 downto tempPos)<= testRes(tempPos+63 downto tempPos);
					
					end if;
					

								
				end loop;	 
					   
				elsif (instrc(22 downto 20) = "101")	then
						for i in 0 to 1 loop		 
	
	
						tempPos := 64 * i;	 						
					
					
					testMult(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+63 downto tempPos+32))* signed(r2(tempPos+63 downto tempPos+32)), 65));
					testRes(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(testMult(tempPos+64 downto tempPos))+ signed(r1(tempPos+63 downto tempPos)), 65)); 
					
					
					if(signed(testRes(tempPos+64 downto tempPos)) >   signed( max64)) then
						o(tempPos+63 downto tempPos)<= "0111111111111111111111111111111111111111111111111111111111111111";			 
						
					elsif(signed(testRes(tempPos+64 downto tempPos)) <  signed( min64)) then
						o(tempPos+63 downto tempPos)<= "1000000000000000000000000000000000000000000000000000000000000000";		
				
							   
					else											 
						
						o(tempPos+63 downto tempPos)<= testRes(tempPos+63 downto tempPos);
					
					end if;
					
					
		
		
				end loop;	
					   
				elsif (instrc(22 downto 20) = "110")	then  
						for i in 0 to 1 loop		 
	
	
						tempPos := 64 * i;	 						
					
					
					testMult(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos))* signed(r2(tempPos+31 downto tempPos)), 65));
					testRes(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(r1(tempPos+63 downto tempPos))- signed(testMult(tempPos+64 downto tempPos)), 65)); 
					
					
					if(signed(testRes(tempPos+64 downto tempPos)) >   signed( max64)) then
						o(tempPos+63 downto tempPos)<= "0111111111111111111111111111111111111111111111111111111111111111";			 
						
					elsif(signed(testRes(tempPos+64 downto tempPos)) <  signed( min64)) then
						o(tempPos+63 downto tempPos)<= "1000000000000000000000000000000000000000000000000000000000000000";		
					
							   
					else											 
						
						o(tempPos+63 downto tempPos)<= testRes(tempPos+63 downto tempPos);
					
					end if;
					
					
	              --
--					tempPos := 64 * i;
--					testMult(tempPos+63 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos))* signed(r2(tempPos+31 downto tempPos)), 64));
--					
--					o(tempPos+63 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+63 downto tempPos))+ signed(r1(tempPos+63 downto tempPos)), 64)); 
								
				end loop;
					
					
			



				elsif (instrc(22 downto 20) = "111")	then 
							for i in 0 to 1 loop		 
	
	
						tempPos := 64 * i;	 						
					
					
					testMult(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+63 downto tempPos+32))* signed(r2(tempPos+63 downto tempPos+32)), 65));
					testRes(tempPos+64 downto tempPos) := std_logic_vector(resize(signed(r1(tempPos+63 downto tempPos))- signed(testMult(tempPos+64 downto tempPos)), 65)); 
					
					
					if(signed(testRes(tempPos+64 downto tempPos)) >   signed( max64)) then
						o(tempPos+63 downto tempPos)<= "0111111111111111111111111111111111111111111111111111111111111111";			 
						
					elsif(signed(testRes(tempPos+64 downto tempPos)) <  signed( min64)) then
						o(tempPos+63 downto tempPos)<= "1000000000000000000000000000000000000000000000000000000000000000";		
				
							   
					else											 
						
						o(tempPos+63 downto tempPos)<= testRes(tempPos+63 downto tempPos);
					
					end if;
					
					
	              --
--					tempPos := 64 * i;
--					testMult(tempPos+63 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos))* signed(r2(tempPos+31 downto tempPos)), 64));
--					
--					o(tempPos+63 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+63 downto tempPos))+ signed(r1(tempPos+63 downto tempPos)), 64)); 
								
				end loop;
					
			end if;		
		
				   	
		
			
----------------------------------------------------------------------------------------
---------------------r3 instrcs----------------------------------------------------------------				
						
					elsif 	(instrc(24 downto 23) = "11") then 	
						 	if instrc(18 downto 15) = "0000" then  --nop
								 
								 
								 Null; --? what should nop do		
								 
							elsif (instrc(18 downto 15) = "0001") then --leading zeros		
							
								for i in 0 to 3 loop
									tempPos := 32 * i;
									counter := 0;	 	 								   
									
									for j in 0 to 31 loop
										if r1(j + tempPos) = '0' then 
											counter := counter + 1;
										else
											exit;
										end if;
									end loop;
								o((31 + tempPos) downto (tempPos)) <=  std_logic_vector(to_unsigned(counter,32));
								
							end loop;	
								 	 
								 
								
								 
							elsif (instrc(18 downto 15) = "0010") then		--add word
								for i in 0 to 3 loop
									tempPos := 32 * i;
									o(tempPos+31 downto tempPos)<=  std_logic_vector(unsigned(r1(tempPos+31 downto tempPos)) + unsigned(r2(tempPos+31 downto tempPos))); 
								end loop;
						
								
							elsif (instrc(18 downto 15) = "0011") then  --add half word 	  
								for i in 0 to 7 loop
									tempPos := 16 * i;
									o(tempPos+15 downto tempPos)<=  std_logic_vector(unsigned(r1(tempPos+15 downto tempPos)) + unsigned(r2(tempPos+15 downto tempPos))); 
								end loop;
							
								
								
							
							elsif(instrc(18 downto 15) = "0100") then 	 --add half word saturated
								
											for i in 0 to 7 loop
					
						tempPos := 16 * i;	 						
					
			
						testRes(tempPos+16 downto tempPos) := std_logic_vector(resize(signed(r2(tempPos+15 downto tempPos))+ signed(r1(tempPos+15 downto tempPos)), 17)); 
					
					
						if(signed(testRes(tempPos+16 downto tempPos)) >   signed(max16)) then
							o(tempPos+15 downto tempPos)<= "0111111111111111";		 
							
						elsif(signed(testRes(tempPos+16 downto tempPos))<   signed(min16)) then
							o(tempPos+15 downto tempPos)<= "10000000000000000";		
							   
						else											 
							
							o(tempPos+15 downto tempPos)<= testRes(tempPos+15 downto tempPos);
					
							 end if;
						end loop;
								
								
								
							elsif (instrc(18 downto 15) = "0101") then	--and r1 r2
								o <= r1 and r2;	 			
							
							elsif (instrc(18 downto 15) = "0110") then	--	broadcast word
									for i in 0 to 3 loop
									tempPos := 32 * i;
									o((31 + tempPos) downto (tempPos)) <=  r1(31 downto 0);
								--	o(31 downto 0) := r1(31 downto 0);
									end loop;
							
								
								
							elsif (instrc(18 downto 15) = "0111") then	--	max signed word
								for i in 0 to 3 loop   
									tempPos := 32 * i;
									temp_int1 := to_integer(signed(r1(tempPos+31 downto tempPos)));
									temp_int2 := to_integer(signed(r2(tempPos+31 downto tempPos)));
									if(temp_int1 > temp_int2) then 
										o((31 + tempPos) downto tempPos) <=   r1(tempPos+31 downto tempPos);
									else 	
										o((31 + tempPos) downto tempPos) <=   r2(tempPos+31 downto tempPos);
									end if;
								end loop;	
								
									
								
							elsif (instrc(18 downto 15) = "1000") then	--	min signed word
								for i in 0 to 3 loop   
									tempPos := 32 * i;
									temp_int1 := to_integer(signed(r1(tempPos+31 downto tempPos)));
									temp_int2 := to_integer(signed(r2(tempPos+31 downto tempPos)));
									if(temp_int1 < temp_int2) then 
										o((31 + tempPos) downto tempPos) <=   r1(tempPos+31 downto tempPos);
									else 	
										o((31 + tempPos) downto tempPos) <=   r2(tempPos+31 downto tempPos);
									end if;	
								end loop;	
								
							
							elsif (instrc(18 downto 15) = "1001") then	--multiply low bits of r1, r2
									for i in 0 to 3 loop
									tempPos := 32 * i;
									o((31 + tempPos) downto (tempPos)) <=  std_logic_vector(unsigned(r1((15 + tempPos) downto (tempPos))) * unsigned(r2((15 + tempPos) downto (tempPos))));
									end loop;
								
							elsif (instrc(18 downto 15) = "1010") then	--multiply by constant
									for i in 0 to 3 loop
									tempPos := 32 * i;
									--o((31 + tempPos) downto (tempPos)) <= std_logic_vector(unsigned(r1((15 + tempPos) downto (tempPos))) * resize(unsigned(instrc(14 downto 10)),16));
									--switch out if need to resize
									o((31 + tempPos) downto (tempPos)) <=  std_logic_vector(unsigned(r1((15 + tempPos) downto (tempPos))) * unsigned(instrc(14 downto 10)));
									end loop;
								
							elsif (instrc(18 downto 15) = "1011") then	--or r1 r2
								o <=  r1 or r2;												   
								
							elsif (instrc(18 downto 15) = "1100") then		--counts 1s in word
							
								for i in 0 to 3 loop
									tempPos := 32 * i;
									counter := 0;	 	 
									for j in 0 to 31 loop
										if r1(j + tempPos) = '1' then 
											counter := counter + 1;	
										end if;
									end loop;
								o((31 + tempPos) downto (tempPos)) <=  std_logic_vector(to_unsigned(counter,32));
								
							end loop;
							
							elsif (instrc (18 downto 15) = "1101") then  --ROTW rotate bits in word 
								for i in 0 to 3 loop
									tempPos := 32 * i;
									temp := r1(temppos + 31 downto temppos);
									temp_int1 := to_integer(unsigned(r2(temppos + 5 downto temppos)));
									o(temppos+31 downto temppos)<= std_logic_vector(unsigned(temp) ror temp_int1);
								
								end loop;
								
							elsif (instrc(18 downto 15) = "1110") then		--sub word 
							
								
								
									for i in 0 to 3 loop
										tempPos := 32 * i;
										o(tempPos+31 downto tempPos)<=  std_logic_vector(unsigned(r1(tempPos+31 downto tempPos)) - unsigned(r2(tempPos+31 downto tempPos))); 
									end loop;		 
									
									
							elsif(instrc(18 downto 15) = "1111") then 		--sub saturated
								
											for i in 0 to 7 loop
					
					
					tempPos := 16 * i;	 						
					
				
					testRes(tempPos+16 downto tempPos) := std_logic_vector(resize(signed(r2(tempPos+15 downto tempPos))- signed(r1(tempPos+15 downto tempPos)), 17)); 
					
					
						if(signed(testRes(tempPos+16 downto tempPos)) >   signed(max16)) then
							o(tempPos+15 downto tempPos)<= "0111111111111111";		 
							
						elsif(signed(testRes(tempPos+16 downto tempPos))<   signed(min16)) then
							o(tempPos+15 downto tempPos)<= "10000000000000000";		
							   
					else											 
						
						o(tempPos+15 downto tempPos)<= testRes(tempPos+15 downto tempPos);
					
					 end if;
				end loop;
						
							 
				 end if;
			end if;	 
		
	
					
	end process;
end ALU_Behavior;









library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	
use work.instr_pack.all;
use work.regfile_pack.all;
use work.all;

entity alu_model is

port (
	clk : in std_logic; -- system clock
-- synchrounous counter clear		  
write: in std_logic;	--write signal	   
reset : in std_logic;
 in_buffer: in InstBuff;
instr_in : in std_logic_vector(24 downto 0);	

instr_out : out std_logic_vector(24 downto 0);	  

rd_address: in std_logic_vector(4 downto 0);

rs1_data : out std_logic_vector(127 downto 0);	  
rs2_data : out std_logic_vector(127 downto 0);	
rs3_data : out std_logic_vector(127 downto 0);
rd_data : in std_logic_vector(127 downto 0);		

				   regs: in regFile



		);	   
		
		
		
		
		
		
----------------------------------------------------------------------------------------
--------------  top level model -------------------------------------------------------------			
		
		
		
		
		
end alu_model;


architecture behavior of alu_model is
		
	--signal cnten1_sig, up_sig, ld_bar_sig, cntr_zero_sig: std_logic;
	--signal clk_dvd_sig: std_logic;   	 
	
	signal writ: std_logic;
	
	signal ins: std_logic_vector(24 downto 0);		   
	signal rs1_save: std_logic_vector(127 downto 0);
	signal rs2_save: std_logic_vector(127 downto 0);
	signal rs3_save: std_logic_vector(127 downto 0);	  
	
	signal alu_output: std_logic_vector(127 downto 0);	  
	
	
begin
		
	
	u0: entity instruction_buffer port map (in_buffer => in_buffer, clk => clk, 
		reset=> reset, instr_out => ins, instr_in => instr_in);	
		
	u1: entity register_file port map (rs1_data => rs1_save,  rs2_data => rs2_save,
		rs3_data => rs3_save, clk => clk, rd_data => rd_data,
		reset=> reset, instrc => ins, write => writ);	
			
	
		
	u2: entity alu port map (r1 => rs1_save,  r2 => rs2_save,
		r3 => rs3_save, o =>  alu_output,
		 instrc => ins );			
		
	 
		
		


	
end architecture;	













	