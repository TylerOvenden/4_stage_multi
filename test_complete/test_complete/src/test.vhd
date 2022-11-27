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
	
end instruction_buffer_tb;

architecture tb of instruction_buffer_tb is	 



	file txt_file : text;


	signal in_buffer: InstBuff;
	signal clk, reset, write: std_logic; 
	
	--signal ins_IFID: std_logic_vector(24 downto 0);		   
--
--	-- ID/EX
--	signal ins_IDEX: std_logic_vector(24 downto 0);		   
--	signal rs1_save_IDEX: std_logic_vector(127 downto 0);
--	signal rs2_save_IDEX: std_logic_vector(127 downto 0);
--	signal rs3_save_IDEX: std_logic_vector(127 downto 0);
--	signal rsd_save_IDEX: std_logic_vector(127 downto 0);
--	--EX/WB
--	signal ins_EXWB: std_logic_vector(24 downto 0);		   
--	signal rs1_save_EXWB: std_logic_vector(127 downto 0);
--	signal rs2_save_EXWB: std_logic_vector(127 downto 0);
--	signal rs3_save_EXWB: std_logic_vector(127 downto 0);
--	signal rsd_save_EXWB: std_logic_vector(127 downto 0);
--	--Forwarding signals
--	 signal FWD_A : STD_LOGIC;
--	 signal FWD_B : STD_LOGIC;
--	 signal FWD_C : STD_LOGIC;
	 
	 
	
	
	--signal cmptr : std_logic;									 
	signal instr_out, instr_in : std_logic_vector(24 downto 0);		  
	
	signal rs1_data, rs2_data, rs3_data, rd_data, output : std_logic_vector(127 downto 0);
	
	signal instrc : std_logic_vector(24 downto 0);
	constant period : time := 5us;				 
--	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
	
	
begin
	UUT : entity processor_model	
		
		
		
		

	port map (in_buffer => in_buffer, 
	reset=> reset, clk => clk, rs1_data => rs1_data, rd_data=> rd_data, rs2_data => rs2_data, rs3_data => rs3_data, alu_out => output, instr_out => instr_out);	 
	
	

	
	
	
		process 	 
		
		variable lin     : line;
		--variable v_OLINE     : line;
		variable temp_inst : std_logic_vector(24 downto 0);
		
		variable counter : integer := 0;
		variable ran : boolean := false;  

		  
		
		begin	 
			
			reset <= '1';
			rd_data <= "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
	
			
				
			
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
			 	
		
		 	
		
		