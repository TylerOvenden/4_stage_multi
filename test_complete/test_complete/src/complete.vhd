		
----------------------------------------------------------------------------------------
--------------  top level model -------------------------------------------------------------			
		
		
		
		
				
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	
use work.instr_pack.all;
use work.regfile_pack.all;
use work.all;

entity alu_model is

port (
	clk : in std_logic; -- system clock
-- synchrounous counter clear		  
write: in std_logic;	--write signal	   
reset : in std_logic;
 in_buffer: in InstBuff;
instr_in : in std_logic_vector(24 downto 0);	

instr_out : out std_logic_vector(24 downto 0);	  

rd_address: in std_logic_vector(4 downto 0);

rs1_data : out std_logic_vector(127 downto 0);	  
rs2_data : out std_logic_vector(127 downto 0);	
rs3_data : out std_logic_vector(127 downto 0);
rd_data : in std_logic_vector(127 downto 0);		

				   regs: in regFile



		);	   
		
		
		
		
		
		
----------------------------------------------------------------------------------------
--------------  top level model -------------------------------------------------------------			
		
		
		
		
		
end alu_model;


architecture behavior of alu_model is
		
	--signal cnten1_sig, up_sig, ld_bar_sig, cntr_zero_sig: std_logic;
	--signal clk_dvd_sig: std_logic;   	 
	
	signal writ: std_logic;
	
	signal ins: std_logic_vector(24 downto 0);		   
	signal rs1_save: std_logic_vector(127 downto 0);
	signal rs2_save: std_logic_vector(127 downto 0);
	signal rs3_save: std_logic_vector(127 downto 0);	  
	
	signal alu_output: std_logic_vector(127 downto 0);	  
	
	
begin
		
	
	u0: entity instruction_buffer port map (in_buffer => in_buffer, clk => clk, 
		reset=> reset, instr_out => ins, instr_in => instr_in);	
		
	u1: entity register_file port map (rs1_data => rs1_save,  rs2_data => rs2_save,
		rs3_data => rs3_save, clk => clk, rd_data => rd_data,
		reset=> reset, instrc => ins, write => writ);	
			
	
		
	u2: entity alu port map (r1 => rs1_save,  r2 => rs2_save,
		r3 => rs3_save, o =>  alu_output,
		 instrc => ins );			
		
	 
		
		


	
end architecture;	













	