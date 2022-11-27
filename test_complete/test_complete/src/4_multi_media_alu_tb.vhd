
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all; 



use std.textio.all;

library work;
use work.all;
use work.instr_pack.all; 
use work.regfile_pack.all;
								 

entity four_multi_media_alu_tb is

end four_multi_media_alu_tb; 
	

architecture tb of four_multi_media_alu_tb is	 



	file txt_file : text;


	signal in_buffer: InstBuff;	

--	signal clk, clr, write: std_logic;
		 
	signal clk,write, reset: std_logic; 
	--signal cmptr : std_logic;									 				
	
	
	--signal rd_address	  : std_logic_vector(4 downto 0);
	signal instrc : std_logic_vector(24 downto 0);
	--signal cmptr : std_logic;									 
	signal rs1_data, rs2_data, rs3_data, rd_data, outp : std_logic_vector(127 downto 0);
	
	
	
	
	
	
	
	
	signal instr_out, instr_in : std_logic_vector(24 downto 0);
	constant period : time := 5us;				 
--	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
	
	
begin
	IB : entity instruction_buffer	
		
	--	
--		 	generic map (
--		n => n,
--		width  =>	 width,
--		inst_size  =>	  inst_size,
--		--InstBuff => InstBuff,
--		buffer_size => buffer_size
--		)
		
		port map (in_buffer => in_buffer, clk => clk, reset=> reset,  instr_out => instr_out, instr_in => instr_in);	
		
		
		
		
		IFID : entity IF_ID	
		
	--	
--		 	generic map (
--		n => n,
--		width  =>	 width,
--		inst_size  =>	  inst_size,
--		--InstBuff => InstBuff,
--		buffer_size => buffer_size
--		)
		
		port map (clk => clk, instr_out => instr_out, instr_in => instr_in);			
		
		
		
		
	ID : entity register_file	
		
	--	
		 
		port map ( clk => clk,reset=> reset, instrc=> instr_out, write=> write,  rs1_data => rs1_data,  rs2_data => rs2_data,  
		rs3_data => rs3_data, rd_data => rd_data);		
		
	
		alu_ex : entity ALU	
		
	--	
		 
		
		port map (instrc=> instrc,  r1 => rs1_data,  r2 => rs2_data,  
		r3 => rs3_data , o => outp);	
		
		
		
		
		
		
		
		
		
		
		process 	 
		
		variable lin     : line;
		--variable v_OLINE     : line;
		variable temp_inst : std_logic_vector(24 downto 0);	  
		variable temp_reg : std_logic_vector(127 downto 0);
		
		variable counter : integer := 0;
		variable ran : boolean := false;  
		
		
		
		
		  
		
		begin	
			reset <= '1'; 								 
			--init
			
		
			
        wait for period*2;

        reset <= '0';
			
			
			
			
			
			
			
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
			 	
		
		




