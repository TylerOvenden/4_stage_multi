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

entity ALU is
	 port(
		 R1 : in STD_LOGIC_VECTOR(127 downto 0);
		 R2 : in STD_LOGIC_VECTOR(127 downto 0);
		 R3 : in STD_LOGIC_VECTOR(127 downto 0);
		 O : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU_Behavior of ALU is	
process is
begin
	if R1[127:126] = 11 then	
		opcode = R1[
		end if;
	end process;
end ALU_Behavior;
