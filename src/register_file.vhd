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



--package regfile_pack is 	
--	
--	type regFile is array (0 to 31) of std_logic_vector(127 downto 0);
----	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
--end package;


	
	

use work.instr_pack.all;


	
entity register_file is
generic (n : integer := 128; --constant for bits
registers : integer := 32;	 
length_instr : integer := 25	


);										  

port (clk : in std_logic; -- system clock	
write : in std_logic; --write signal	

reset :  in std_logic;
clr : in std_logic; -- synchrounous counter clear
	  


--read : in std_logic; --regiser read


instrc : in std_logic_vector(length_instr-1 downto 0);	   


--rs1_address : out std_logic_vector(4 downto 0); 
--rs2_address: out std_logic_vector(4 downto 0);
--rs3_address: out std_logic_vector(4 downto 0);
rd_address: in std_logic_vector(4 downto 0);

rs1_data : out std_logic_vector(n-1 downto 0);	  
rs2_data : out std_logic_vector(n-1 downto 0);	
rs3_data : out std_logic_vector(n-1 downto 0);
rd_data : in std_logic_vector(n-1 downto 0)		



--
--r4_instr  : out std_logic_vector(2 downto 0);	
--


--opcode : out std_logic_vector(4 downto 0);	 
--for load immadiate 
--immediate : out std_logic_vector(15 downto 0);	 
--index : out std_logic_vector(2 downto 0);


--out_reg : in std_logic_vector(n-1 downto 0)


);				 


end register_file;

			 
architecture behaviorhal of register_file is 

	type regFile is array (0 to registers-1) of std_logic_vector(n-1 downto 0);
	signal reg  : regFile;

begin  
	process(clk) 
	begin	  
	
		if rising_edge(clk) then		
			if(reset = '1')then 
		  
				
				
				for i in 0 to 31 loop
			
				reg(i) <=  std_logic_vector(to_unsigned(0, 128));
				
				end loop;
			
			end if;	
				
				
			--r4 instructions	
			elsif 	(instrc(24 downto 23) = "10") then 	  
				rs1_data <= reg(to_integer(unsigned(instrc(19 downto 15))));
				rs2_data <= reg(to_integer(unsigned(instrc(14 downto 10))));
				rs3_data <= reg(to_integer(unsigned(instrc(9 downto 5))));	 
				
	
				--write
				reg(to_integer(unsigned(rd_address))) <= rd_data;
				
				
				
				
			elsif 	(instrc(24 downto 23) = "11") then 	
				rs1_data <= reg(to_integer(unsigned(instrc(19 downto 15))));
				rs2_data <= reg(to_integer(unsigned(instrc(14 downto 10))));
				
				
				if(write = '1') then
					
				reg(to_integer(unsigned(rd_address))) <= rd_data;	
					
				
			
		end if;
		
	
		--load immidate 
	    elsif (instrc(24 downto 23) = "1") then 
			reg(to_integer(unsigned(rd_address))) <= rd_data;	
			
 
					end if;
				
		
	 
	end process;
	
	
end behaviorhal;	



library ieee;
use ieee.std_logic_1164.all;

entity IF_EX is
	port(
	clk : in std_logic;
	instr_in : in std_logic_vector(24 downto 0);  
	
	rs1_data_in : in std_logic_vector(127 downto 0);	  
	rs2_data_in : in std_logic_vector(127 downto 0);	
	rs3_data_in : in std_logic_vector(127 downto 0);
	rd_data_in : in std_logic_vector(127 downto 0);		   
	
	
	
	rs1_data_out : out std_logic_vector(127 downto 0);	  
	rs2_data_out : out std_logic_vector(127 downto 0);	
	rs3_data_out : out std_logic_vector(127 downto 0);
	rd_data_out : out std_logic_vector(127 downto 0);
	
	
	
	
	
	
	instr_out : out std_logic_vector(24 downto 0)
	);
end IF_EX;

architecture behavioral of IF_EX is
begin
	process (clk)
	begin
		if rising_edge(clk) then	  
			
			
			rs1_data_out <=  rs1_data_in;	 
			rs2_data_out <=  rs2_data_in;
			rs3_data_out <=  rs3_data_in;
			rd_data_out <=  rd_data_in;
			
		
		end if;
	end process;
end behavioral;








	

	