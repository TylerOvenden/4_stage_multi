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




	
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	


entity instruction_buffer is
generic (			 
n : integer := 6; -- 2^6 = 64 values for pc
buffer_size : integer := 64;	 
width : integer := 25
);
port (clk : in std_logic; -- system clock
clr_bar : in std_logic; -- synchrounous counter clear
rst_bar: in std_logic; -- synchronous reset		 
pc : in std_logic_vector(n-1 downto 0);
instru_in : in std_logic_vector(width-1 downto 0);
instru_out : out std_logic_vector(width-1 downto 0)
);

end instruction_buffer;

			 
architecture behaviorhal of instruction_buffer is
begin
	
	
end behaviorhal;	
	
