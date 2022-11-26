-------------------------------------------------------------------------------
--
-- Title       :   instruction_buffer
-- Design      : instruction_buffer
-- Author      :  Tyler Ovenden 112122685
-- Company     : SUNY Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\Lab11\lab11\src\ tc514cntrl.vhd
-- Generated   : 4/04/2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-------------------------------------------------------------------------------			   


--Using this to build array of instr
--https://stackoverflow.com/questions/30651269/synthesizable-multidimensional-arrays-in-vhdl	 

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
clr : in std_logic; -- synchrounous counter clear		  
write: in std_logic;	--write signal	   
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
	