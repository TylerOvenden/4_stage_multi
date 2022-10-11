-------------------------------------------------------------------------------
--
-- Title       :   register_file
-- Design      : register_file
-- Author      :  Tyler Ovenden 112122685
-- Company     : SUNY Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\Lab11\lab11\src\ tc514cntrl.vhd
-- Generated   : 10/1/22
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : he register file has 32 128-bit registers. On any cycle, there can be 3 reads and 1 write. 
-- When executing instructions, each cycle two/three 128-bit register values are read, and one 128-bit result 
-- can be written if a write signal is valid. This register write signal must be explicitly declared so it can 
-- be checked during simulation and demonstration of your design. 
-- The register module must be implemented as a behavioral model in VHDL (dataflow/RTL model in Verilog).
-------------------------------------------------------------------------------			   




	
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
clr_bar : in std_logic; -- synchrounous counter clear
rst_bar: in std_logic; -- synchronous reset		   
enable : in std_logic; --regiser write
in_reg : in std_logic_vector(n-1 downto 0);
out_reg : in std_logic_vector(n-1 downto 0)


);
end register_file;

			 
architecture behaviorhal of register_file is
begin
	
	
end behaviorhal;	
	


	

	