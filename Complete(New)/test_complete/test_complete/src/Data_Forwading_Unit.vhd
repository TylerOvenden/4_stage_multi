-------------------------------------------------------------------------------
--
-- Title       : Data_Forwading_Unit
-- Design      : Data Forwarding
-- Author      : CAD
-- Company     : CEAS
--
-------------------------------------------------------------------------------
--
-- File        : D:\4_stage_multi-main\ALU_Workspace\Data Forwarding\src\Data_Forwading_Unit.vhd
-- Generated   : Mon Nov 21 21:53:51 2022
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
--{entity {Data_Forwading_Unit} architecture {Data_Forwading_Unit}}

library IEEE;
use IEEE.std_logic_1164.all;

entity Data_Forwading_Unit is
	port(
		-- clk : in STD_LOGIC;	
		-- r1 : in STD_LOGIC_VECTOR(127 downto 0);
		-- r2 : in STD_LOGIC_VECTOR(127 downto 0);
		-- r3 : in STD_LOGIC_VECTOR(127 downto 0);
		 instr: in STD_LOGIC_VECTOR(24 downto 0);
		 next_instr: in STD_LOGIC_VECTOR(24 downto 0);
		 FWD_A : out STD_LOGIC;
		 FWD_B : out STD_LOGIC;
		 FWD_C : out STD_LOGIC
	     );
end Data_Forwading_Unit;

--}} End of automatically maintained section

architecture behavior of Data_Forwading_Unit is	


begin 

	process(instr, next_instr)  
	variable curr_rd : std_logic_vector(4 downto 0);
--variable next_rd : std_logic_vector(4 downto 0);
--variable rs1 : std_logic_vector(4 downto 0);
--variable rs2 : std_logic_vector(4 downto 0); 
--variable rs3 : std_logic_vector(4 downto 0);
begin
	curr_rd := instr(4 downto 0);
	if instr(24) = '0'  or next_instr(24) = '0' then   -- if load immediate function no forwarding
			FWD_A <= '0';
			FWD_B <= '0';
			FWD_C <= '0';
	elsif (instr(24 downto 23) = "11") then
		if instr(18 downto 15) = "0000" then	-- if  Nop no forwarding 
			FWD_A <= '0';
			FWD_B <= '0';
			FWD_C <= '0';
		end if;
	else	
	
	if( next_instr(24 downto 23) = "11") then	 -- if r3 instruction (not nop)
		FWD_C <= '0';
		if curr_rd = next_instr(14 downto 10) then 
			FWD_B <= '1';
		else
			FWD_B <= '0';
		end if;	
		if curr_rd = next_instr(9 downto 5) then 
			FWD_A <= '1';
		else 
			FWD_A <= '0';
		end if;	
	end if;
	

	if( next_instr(24 downto 23) = "10") then	 -- if r4 instruction
		if curr_rd = next_instr(19 downto 15) then 		 -- rs3
			FWD_C <= '1';
		else 
			FWD_C <= '0';
		end if;
		if curr_rd = next_instr(14 downto 10) then 		 --rs2
			FWD_B <= '1';
		else
			FWD_B <= '0';
		end if;	
		if curr_rd = next_instr(9 downto 5) then 	  	 --rs1
			FWD_A <= '1';
		else 
			FWD_A <= '0';
		end if;	
	end if;
	
	
	end if;
	end process;
   end behavior;

