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
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	


entity instruction_buffer is
generic (			 
n : integer := 6; -- 2^6 = 64 values for pc
buffer_size : integer := 64;	 
width : integer := 2;	
inst_size : integer := 25
--subtype instr is std_logic_vector(24 downto 0);
--type instr_buffer is array (0 to 63 ) of instr; 


);
port (
clk : in std_logic; -- system clock
clr_bar : in std_logic; -- synchrounous counter clear
rst_bar: in std_logic; -- synchronous reset		  
write: in std_logic;	--write signal
pc : in std_logic_vector(n-1 downto 0);
instr_in : in std_logic_vector(width-1 downto 0);
instr_out : out std_logic_vector(width-1 downto 0)

);

end instruction_buffer;

			 
architecture behaviorhal of instruction_buffer is	

type InstBuff is array (0 to buffer_size-1) of std_logic_vector(24 downto 0);

signal ins : InstBuff;
--variable temp : integer;
begin
	process (clk)
	begin
--	if rising_edge(clk) then   -- every cycle output pc+1 instr
--		if(to_integer(unsigned(pc))<63) then
--		pc <= pc + 1;  
--		temp := to_integer(unsigned(pc));
--		instr_out <= counter(temp);
--		elsif then
--		pc <= 0;  
--		temp := to_integer(unsigned(pc));
--		instr_out <= counter(temp)
--		end if;
--		end if;
--	end process;	
if rising_edge(clk)		 then 		 
	if write = '1' then						
			ins(to_integer(unsigned(pc))) <= instr_in;	
		end if;
		instr_out <= ins(to_integer(unsigned(pc)));
	end if;

end process;
end behaviorhal;	
	
