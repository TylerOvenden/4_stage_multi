-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Robert Bacigalupo
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : B:\Stony Brook\ESE345\Project\ESE345Project\ALU\src\ALU.vhd
-- Generated   : Sun Oct  2 17:41:31 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ALU} architecture {ALU_Behavior}}

library IEEE;
use IEEE.std_logic_1164.all;   
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
variable tempRes: signed (64 downto 0);	   --need to be 64 for possible overflow

constant max16 : std_logic_vector(15 downto 0) := "0111111111111111";
constant min16 : std_logic_vector(15 downto 0) := "1000000000000000"; 	
constant max32: std_logic_vector(31 downto 0):= X"7FFFFFFF"; 
constant min32: std_logic_vector(31 downto 0) := X"80000000";
constant max64: std_logic_vector(63 downto 0):= X"7FFFFFFFFFFFFFFF"; 
constant min64: std_logic_vector(63 downto 0) := X"8000000000000000";	
variable counter: integer:=0; 		--counter for counting ones
variable tempPos : integer;  	
	
	
	
	begin  		
		
		o <= r1;
		--load immeditate
		if instrc(24) = '0' then	
			
			--convert load index into a multiple of 16
			index := to_integer(unsigned(instrc(23 downto 21))) * 16; 	
			
			--load immeditate 
			o(index + 15 downto index) <= instrc(20 downto 5);
			
			
			--r4	
		elsif 	(instrc(24 downto 23) = "10") then 	
			
			--Signed Integer Multiply-Add Low with Saturation
			--y low 16-bit-fields for rs3, rs2
			if (instrc(22 downto 20) = "000")	then 
				tempRes := signed(r1(31 downto 0))+signed(r2(15 downto 0))*signed(r3(15 downto 0));
				if(tempRes > max32) then 
					o(31 downto 0):= std_logic_vector(max32); 
				elsif(tempRes < min32) then 
					o(31 downto 0):= std_logic_vector(min32); 
				else 	
				   output(31 downto 0):=  tempRes(31 downto 0);
	
							
				end if;
				
					tempRes := signed(r1(63 downto 32))+signed(r2(47 downto 32))*signed(r3(47 downto 32));
				if(tempRes > max32) then 
					o(63 downto 32):= std_logic_vector(max32); 
				elsif(tempRes < min32) then 
					o(63 downto 32):= std_logic_vector(min32); 
				else 	
				   output(63 downto 32):=  tempRes(31 downto 0);		
				   
				   
				   tempRes := signed(r1(95 downto 64))+signed(r2(79 downto 64))*signed(r3(79 downto 64));
				if(tempRes > max32) then 
					o(95 downto 64):= std_logic_vector(max32); 
				elsif(tempRes < min32) then 
					o(95 downto 64):= std_logic_vector(min32); 
				else 	
				   output(95 downto 64):=  tempRes(31 downto 0);
	
							
				end if;
				
					tempRes := signed(r1(127 downto 96))+signed(r2(111 downto 96))*signed(r3(111 downto 96));
				if(tempRes > max32) then 
					o(127 downto 96):= std_logic_vector(max32); 
				elsif(tempRes < min32) then 
					o(127 downto 96):= std_logic_vector(min32); 
				else 	
				   output(127 downto 96):=  tempRes(31 downto 0);
				   
				   
	
							
				end if;
			
				
				--r3 instructions
				elsif 	(instrc(24 downto 23) = "11") then 	
				 	if instruction(18 downto 15) = "0000" then  --nop
						 
						 Null; --? what should nop do		
						 
						 
						
						 
					elsif (instruction(18 downto 15) = "0010") then
						o(31 downto 0):= std_logic_vector(unsigned(r1(31 downto 0)) + unsigned(r2(31 downto 0)));  
						o(63 downto 32):= std_logic_vector(unsigned(r1(63 downto 32)) + unsigned(r2(63 downto 32)));   
						o(95 downto 64):= std_logic_vector(unsigned(r1(95 downto 64)) + unsigned(r2(95 downto 64)));   
						o(127 downto 96):= std_logic_vector(unsigned(r1(127 downto 96)) + unsigned(r2(127 downto 96)));
						
					elsif (instruction(18 downto 15) = "0011") then  --add half word 	  
						o(15 downto 0):= std_logic_vector(unsigned(r1(15 downto 0)) + unsigned(r2(15 downto 0)));  
						o(31 downto 16):= std_logic_vector(unsigned(r1(31 downto 16)) + unsigned(r2(31 downto 16)));   
						o(47 downto 32):= std_logic_vector(unsigned(r1(47 downto 32)) + unsigned(r2(47 downto 32)));   
						o(63 downto 48):= std_logic_vector(unsigned(r1(63 downto 48)) + unsigned(r2(63 downto 48)));
						o(79 downto 64):= std_logic_vector(unsigned(r1(79 downto 64)) + unsigned(r2(79 downto 64)));  
						o(95 downto 80):= std_logic_vector(unsigned(r1(95 downto 80)) + unsigned(r2(95 downto 80)));   
						o(111 downto 96):= std_logic_vector(unsigned(r1(111 downto 96)) + unsigned(r2(111 downto 96)));   
						o(127 downto 112):= std_logic_vector(unsigned(r1(127 downto 112)) + unsigned(r2(127 downto 112)));	
						
						
						
					elsif (instruction(18 downto 15) = "0101") then	--and r1 r2
						o := r1 and r2;	 
						
						
					elsif (instruction(18 downto 15) = "1011") then	--and r1 r2
						o := r1 or r2;												   
						
					elsif (instruction(18 downto 15) = "1100") then		--counts 1s in word
					
						for i in 0 to 3 loop
							tempPos := 32 * i;
							counter := 0;	 	 
							for j in 0 to 31 loop
								if r1(j + tempPos) = '1' then 
									counter := counter + 1;	
								end if;
							end loop;
						o((31 + tempPos) downto (0 + tempPos)) <= std_logic_vector(to_unsigned(counter,32));
						
					end loop;		
					
					elsif (instruction(18 downto 15) = "0001") then --leading zeros		
					
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
						o((31 + tempPos) downto (0 + tempPos)) <= std_logic_vector(to_unsigned(counter,32));
						
					end loop;	
						 
						 
				
		end if;	
	
	end process;
end ALU_Behavior;
