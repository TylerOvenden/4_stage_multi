-------------------------------------------------------------------------------
--
-- Title       : pipeline_reg
-- Design      : Processor
-- Author      : Rob
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : B:\Stony Brook\ESE345\4_stage_multi\Processor\Processor\Processor\src\pipeline_reg.vhd
-- Generated   : Sat Nov 26 17:49:11 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity pipeline_reg is
	port(
		 clk : in std_logic;
		 R1 : in STD_LOGIC_VECTOR(127 downto 0);
		 R2 : in STD_LOGIC_VECTOR(127 downto 0);
		 R3 : in STD_LOGIC_VECTOR(127 downto 0);
		 R1_OUT : out STD_LOGIC_VECTOR(127 downto 0);
		 R2_OUT : out STD_LOGIC_VECTOR(127 downto 0);
		 R3_OUT : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end pipeline_reg;



architecture pipeline_reg of pipeline_reg is
begin

process(clk)
begin
	
	
	 
end process;
end pipeline_reg;
