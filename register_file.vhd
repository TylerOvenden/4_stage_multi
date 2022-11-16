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
write : in std_logic; --write signal
clr_bar : in std_logic; -- synchrounous counter clear
rst_bar: in std_logic; -- synchronous reset		  


read : in std_logic; --regiser read


instrc : in std_logic_vector(length_instr-1 downto 0);	   


rs1_address : out std_logic_vector(4 downto 0); 
rs2_address: out std_logic_vector(4 downto 0);
rs3_address: out std_logic_vector(4 downto 0);
rd_address: out std_logic_vector(4 downto 0);

rs1_data : out std_logic_vector(n-1 downto 0);	  
rs2_data : out std_logic_vector(n-1 downto 0);	
rs3_data : out std_logic_vector(n-1 downto 0);
rd_data : out std_logic_vector(n-1 downto 0);		


r4_instr  : out std_logic_vector(2 downto 0);	

opcode : out std_logic_vector(4 downto 0);	 
--for load immadiate 
immediate : out std_logic_vector(15 downto 0);	 
index : out std_logic_vector(2 downto 0);


out_reg : in std_logic_vector(n-1 downto 0)


);				 


end register_file;

			 
architecture behaviorhal of register_file is 

	type regFile is array (0 to length_instr-1) of std_logic_vector(n-1 downto 0);
	signal instr  : regFile;

begin  
	process(clk) 
	begin	  
		--rd is supposed to be set to all 0s on first cycle		
		
		--idea have an input signal set by the testbench on first cycle to signify this
		   rd_data <= (others => '0'); 
		
		
		if rising_edge(clk) then
			if instrc(24) = '0' then	
				
				
				
			--r4 instructions	
			elsif 	(instrc(24 downto 23) = "10") then 
				
				
				if (instrc(22 downto 20) = "000")	then 
					
					
					
				elsif (instrc(22 downto 20) = "001")	then 	
					
					
					
					
				elsif (instrc(22 downto 20) = "010")	then 
					
					
					
					
					
				elsif (instrc(22 downto 20) = "011")	then 	
					
					
				elsif (instrc(22 downto 20) = "100")	then
					
					
				elsif (instrc(22 downto 20) = "101")	then
		
				elsif (instrc(22 downto 20) = "110")	then  
					
					
				elsif (instrc(22 downto 20) = "111")	then  
					end if;
				
			
		
			end if;
	
	   end if;
	end process;
	
	
end behaviorhal;	
	


	
