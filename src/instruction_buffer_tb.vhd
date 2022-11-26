
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all; 



use std.textio.all;

library work;
use work.all;
use work.instr_pack.all;


entity instruction_buffer_tb is
--generic(
--n : integer := 6 ;	
--width : integer := 2 ;	
--inst_size : integer := 25 ;	
--
---- width of ADC
--		-- integer analog value simulated, Vin = (analog_val * Vref)/2**n
--		buffer_size : integer := 64);		
--	
	
end instruction_buffer_tb;

architecture tb of instruction_buffer_tb is	 



	file txt_file : text;


	signal in_buffer: InstBuff;
	signal clk, reset: std_logic; 

	--signal cmptr : std_logic;									 
	signal instr_out, instr_in : std_logic_vector(24 downto 0);
	constant period : time := 5us;				 
--	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
	
	
begin
	UUT : entity instruction_buffer	
		
	--	
--		 	generic map (
--		n => n,
--		width  =>	 width,
--		inst_size  =>	  inst_size,
--		--InstBuff => InstBuff,
--		buffer_size => buffer_size
--		)
		
		port map (in_buffer => in_buffer, reset=> reset, clk => clk,  instr_out => instr_out, instr_in => instr_in);	
  
		process 	 
		
		variable lin     : line;
		--variable v_OLINE     : line;
		variable temp_inst : std_logic_vector(24 downto 0);
		
		variable counter : integer := 0;
		variable ran : boolean := false;  

		  
		
		begin	

				if( ran = false) then 
		    --  file_open(txt_file, "binary.txt", write_mode);
			file_open(txt_file, "binary.txt",  read_mode);
			while ( not endfile(txt_file) and (counter <64 ) )loop
		
				readline(txt_file, lin);
				read(lin, temp_inst);
   				in_buffer(counter) <=  temp_inst;
				--instr_in <= temp_inst;   
				
				
				
				counter := counter + 1;

				
			end loop; 		  
			counter	:= 0;
			ran := true;
    	file_close(txt_file);	
		  end if;
	--	std.env.finish;
		wait; 
		end process;
		
		
		 clock: process
  begin 
	  clk <='0';
	  wait for period;
	  clk<='1';
	  wait for period;
  end process;
			
			
	
end tb;
			 	
		
		



