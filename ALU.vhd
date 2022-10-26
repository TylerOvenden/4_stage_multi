-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Robert Bacigalupo and Tyler Ovenden
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
variable temp_int1:integer:=0;
variable temp_int2:integer:=0;	
variable tempRes128: signed (127 downto 0);	
variable testMult: std_logic_vector(127 downto 0);
variable rd: std_logic_vector(127 downto 0);

constant max16 : std_logic_vector(15 downto 0) := "0111111111111111";
constant min16 : std_logic_vector(15 downto 0) := "1000000000000000"; 	
constant max32: std_logic_vector(31 downto 0):= X"7FFFFFFF"; 
constant min32: std_logic_vector(31 downto 0) := X"80000000";
constant max64: std_logic_vector(63 downto 0):= X"7FFFFFFFFFFFFFFF"; 
constant min64: std_logic_vector(63 downto 0) := X"8000000000000000";


variable counter: integer:=0; 		--counter for counting ones
variable tempPos : integer;  	
variable temp : integer; -- general temp variable, currently using in ROTW	
	
	
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
					testMult(tempPos+31 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+15 downto tempPos))* signed(r2(tempPos+15 downto tempPos)), 32));
					
					o(tempPos+31 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+31 downto tempPos))+ signed(r1(tempPos+31 downto tempPos)), 32)); 
					
				
				end loop;	
					 
					  
				elsif (instrc(22 downto 20) = "001")	then 		  
					for i in 0 to 3 loop
						tempPos := 32 * i;	 
						testMult(tempPos+31 downto tempPos) := std_logic_vector(resize(signed(r2(tempPos+31 downto tempPos+15))* signed(r3(tempPos+31 downto tempPos+15)), 32));
					
						o(tempPos+31 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+31 downto tempPos))+ signed(r1(tempPos+31 downto tempPos)), 32)); 
					
					
					--tempRes := signed(r1(tempPos+31 downto tempPos))+signed(r2(tempPos+31 downto tempPos+15))*signed(r3(tempPos+31 downto tempPos+15));	
--					if(tempRes > max32) then 
--						o(tempPos+31 downto tempPos)<=  std_logic_vector(max32); 
--					elsif(tempRes < min32) then 
--						o(tempPos+31 downto tempPos)<=  std_logic_vector(min32); 
--					else 	
--					   o(tempPos+31 downto tempPos)<=   std_logic_vector(tempRes(tempPos+31 downto tempPos)); 	   
--					   
--					end if;
				end loop;	
				
				elsif (instrc(22 downto 20) = "010")	then 		  
					for i in 0 to 3 loop
						tempPos := 32 * i;	 
					testMult(tempPos+31 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+15 downto tempPos))* signed(r2(tempPos+15 downto tempPos)), 32));
					
					o(tempPos+31 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+31 downto tempPos))- signed(r1(tempPos+31 downto tempPos)), 32)); 
					
				--	
--					if(tempRes > max32) then 
--						o(tempPos+31 downto tempPos):= std_logic_vector(max32); 
--					elsif(tempRes < min32) then 
--						o(tempPos+31 downto tempPos):= std_logic_vector(min32); 
--					else 	
--					   o(tempPos+31 downto tempPos):=  std_logic_vector(tempRes(tempPos+31 downto tempPos));	   
--					
				--	end if;
				end loop;	
					   
				elsif (instrc(22 downto 20) = "011")	then 		  
					for i in 0 to 3 loop
							tempPos := 32 * i;	 
						testMult(tempPos+31 downto tempPos) := std_logic_vector(resize(signed(r2(tempPos+31 downto tempPos+15))* signed(r3(tempPos+31 downto tempPos+15)), 32));
					
						o(tempPos+31 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+31 downto tempPos))- signed(r1(tempPos+31 downto tempPos)), 32)); 
				end loop;	  
					   
					   
				elsif (instrc(22 downto 20) = "100")	then
						for i in 0 to 3 loop
					tempPos := 64 * i;
					testMult(tempPos+63 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos))* signed(r2(tempPos+31 downto tempPos)), 64));
					
					o(tempPos+63 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+63 downto tempPos))+ signed(r1(tempPos+63 downto tempPos)), 64)); 
					
				--	tempRes128 := signed(r1(tempPos+63 downto tempPos))+signed(r2(tempPos+31 downto tempPos))*signed(r3(tempPos+31 downto tempPos));	
--					if(tempRes > max64) then 
--						o(tempPos+63 downto tempPos):= std_logic_vector(max64); 
--					elsif(tempRes < min64) then 
--						o(tempPos+63 downto tempPos):= std_logic_vector(min64); 
--					else 								  
--					   o(tempPos+63 downto tempPos):=  std_logic_vector(tempRes128(tempPos+63 downto tempPos)); 
--					  end if;
				end loop;	 
					   
				elsif (instrc(22 downto 20) = "101")	then
						for i in 0 to 3 loop
					tempPos := 64 * i;		 
					
				
					testMult(tempPos+63 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+63 downto tempPos+31))* signed(r2(tempPos+63 downto tempPos+31)), 64));
					
					o(tempPos+63 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+63 downto tempPos))+ signed(r1(tempPos+63 downto tempPos)), 64)); 
				--	tempRes128 := signed(r1(tempPos+63 downto tempPos))+signed(r2(tempPos+63 downto tempPos+31))*signed(r3(tempPos+63 downto tempPos+31));	
--					
--					
--					if(tempRes > max64) then 
--						o(tempPos+63 downto tempPos):= std_logic_vector(max64); 
--					elsif(tempRes < min64) then 
--						o(tempPos+63 downto tempPos):= std_logic_vector(min64); 
--					else 	
--					   o(tempPos+63 downto tempPos):=  std_logic_vector(tempRes128(tempPos+63 downto tempPos)); 
--					   end if;
				end loop;	
					   
				elsif (instrc(22 downto 20) = "110")	then
						for i in 0 to 3 loop
					tempPos := 64 * i;	  
					testMult(tempPos+63 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+31 downto tempPos))* signed(r2(tempPos+31 downto tempPos)), 64));
					
					o(tempPos+63 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+63 downto tempPos))- signed(r1(tempPos+63 downto tempPos)), 64)); 
					tempRes128 := signed(r1(tempPos+63 downto tempPos))-signed(r2(tempPos+31 downto tempPos))*signed(r3(tempPos+31 downto tempPos));	
			
				end loop;	
				
				elsif (instrc(22 downto 20) = "111")	then
						for i in 0 to 3 loop
					tempPos := 64 * i;
					
					testMult(tempPos+63 downto tempPos) := std_logic_vector(resize(signed(r3(tempPos+63 downto tempPos+31))* signed(r2(tempPos+63 downto tempPos+31)), 64));
					
					o(tempPos+63 downto tempPos)<= std_logic_vector(resize(signed(testMult(tempPos+63 downto tempPos))- signed(r1(tempPos+63 downto tempPos)), 64)); 
					
				end loop;	
				   	
		
			
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
								
							--	o(31 downto 0):= std_logic_vector(unsigned(r1(31 downto 0)) + unsigned(r2(31 downto 0)));  
							--	o(63 downto 32):= std_logic_vector(unsigned(r1(63 downto 32)) + unsigned(r2(63 downto 32)));   
							--	o(95 downto 64):= std_logic_vector(unsigned(r1(95 downto 64)) + unsigned(r2(95 downto 64)));   
							--	o(127 downto 96):= std_logic_vector(unsigned(r1(127 downto 96)) + unsigned(r2(127 downto 96)));
								
							elsif (instrc(18 downto 15) = "0011") then  --add half word 	  
								for i in 0 to 7 loop
									tempPos := 16 * i;
									o(tempPos+15 downto tempPos)<=  std_logic_vector(unsigned(r1(tempPos+15 downto tempPos)) + unsigned(r2(tempPos+15 downto tempPos))); 
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
									temp_int2 := to_integer(signed(r1(tempPos+32 downto tempPos)));
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
									temp_int2 := to_integer(signed(r1(tempPos+32 downto tempPos)));
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
							
							--elsif (instrc (18 downto 15) = "1101") then  --ROTW rotate bits in word 
--							--	tempPos := 	to_integer(instrc(14 downto 10));
----								temp_int1 := to_integer(signed(r1(tempPos+31 downto tempPos)));  --r1
----								tempPos := 	to_integer(instrc (9 downto 5));					 
----								temp_int2 := to_integer(signed(r2(tempPos+32 downto tempPos)));	 --r2
----								temp := to_integer(temp_int2 (5 downto 0));	  --- number to rotate 
----								o <=  temp ror temp;
								
							elsif (instrc(18 downto 15) = "1110") then		--sub word
									for i in 0 to 3 loop
										tempPos := 32 * i;
										o(tempPos+31 downto tempPos)<=  std_logic_vector(unsigned(r1(tempPos+31 downto tempPos)) - unsigned(r2(tempPos+31 downto tempPos))); 
									end loop;
						
							 
				
		end if;	 
		end if;
		end if;
	end process;
end ALU_Behavior;
