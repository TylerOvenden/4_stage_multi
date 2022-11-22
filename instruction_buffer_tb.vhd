
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;


use std.textio.all;

use work.all;

entity instruction_buffer_tb is
generic(
n : integer := 6 ;	
width : integer := 2 ;	
inst_size : integer := 25 ;	
-- width of ADC
		-- integer analog value simulated, Vin = (analog_val * Vref)/2**n
		buffer_size : integer := 64);		
	
	
end instruction_buffer_tb;

architecture tb of instruction_buffer_tb is	 



	file txt_file : text;



	signal clk, clr, write: std_logic;

	--signal cmptr : std_logic;									 
	signal instr_out, instr_in : std_logic_vector(inst_size-1 downto 0);
	constant period : time := 5us;				 
	
	
	
begin
	UUT : entity instruction_buffer	
		
		
		 	generic map (
		n => n,
		width  =>	 width,
		inst_size  =>	  inst_size,
		buffer_size => buffer_size
		)
		
		port map (clk => clk, clr=> clr, write => write, instr_out => instr_out, instr_in => instr_in);	

		process 
		variable v_ILINE     : line;
		variable v_OLINE     : line;
		variable temp_inst : std_logic_vector(inst_size-1 downto 0);
		
		variable counter : integer range 0 to 63 := 0;
		  

		  
		
		begin	

			
		      file_open(txt_file, "test.txt", write_mode);
			--file_open(file_VECTORS, "binary.txt",  read_mode);
			while not endfile(txt_file) loop
		
				readline(txt_file, v_ILINE);
				read(v_ILINE, temp_inst);
   		
				instr_in <= temp_inst;   
				counter := counter + 1;
				
				
				 wait for period;
			end loop;
			
			
			
			
			

	end process;	  
	
end tb;
			 	
		
		



