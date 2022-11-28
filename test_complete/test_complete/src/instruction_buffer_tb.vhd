
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
	
	signal ins_IFID: std_logic_vector(24 downto 0);		   

	-- ID/EX
	signal ins_IDEX: std_logic_vector(24 downto 0);		   
	signal rs1_save_IDEX: std_logic_vector(127 downto 0);
	signal rs2_save_IDEX: std_logic_vector(127 downto 0);
	signal rs3_save_IDEX: std_logic_vector(127 downto 0);
	signal rsd_save_IDEX: std_logic_vector(127 downto 0);
	--EX/WB
	signal ins_EXWB: std_logic_vector(24 downto 0);		   
	signal rs1_save_EXWB: std_logic_vector(127 downto 0);
	signal rs2_save_EXWB: std_logic_vector(127 downto 0);
	signal rs3_save_EXWB: std_logic_vector(127 downto 0);
	signal rsd_save_EXWB: std_logic_vector(127 downto 0);
	--Forwarding signals
	 signal FWD_A : STD_LOGIC;
	 signal FWD_B : STD_LOGIC;
	 signal FWD_C : STD_LOGIC;
	 
	 
	
	
	--signal cmptr : std_logic;									 
	signal instr_out, instr_in : std_logic_vector(24 downto 0);		  
	
	signal rs1_data, rs2_data, rs3_data, rd_data, output : std_logic_vector(127 downto 0);
	
	signal instrc : std_logic_vector(24 downto 0);
	constant period : time := 5us;				 
--	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);	
	
	
begin
	UUT : entity instruction_buffer	
		



	port map (in_buffer => in_buffer, reset=> reset, clk => clk,  instr_out => instr_out);	 
	
	
	
		E_IF_ID : entity IF_ID	
		
																				


	port map (reset=> reset, clk => clk,  instr_in => instr_out, instr_out => ins_IFID);	
	
	
	
  	ID : entity register_file	
		
	--	
		 
		
		port map ( clk => clk,reset=> reset, write=> write,  rs1_data => rs1_data,  rs2_data => rs2_data,  
		rs3_data => rs3_data, rd_data => rd_data, instrc => ins_IFID);					   
		
	
		
	E_ID_EX: entity ID_EX port map ( clk => clk, 
		reset=> reset, instr_out => ins_IDEX, instr_in => instr_out, rs1_data_in => rs1_data,
		rs2_data_in => rs2_data,rs3_data_in => rs3_data, rd_data_in => rd_data, rs1_data_out => rs1_save_IDEX,
		rs2_data_out => rs2_save_IDEX, rs3_data_out => rs3_save_IDEX, rd_data_out => rsd_save_IDEX );		
		
		
		
			ALU_EXE : entity ALU	
		
		port map (  r1 => rs1_data,  r2 => rs2_data,  
		r3 => rs3_data, instrc => ins_IDEX, o => output);	 
		
		
		
		u_EX_WB: entity EX_WB port map ( clk => clk, instr_out => ins_EXWB, instr_in => instr_out, rs1_data_in => rs1_save_IDEX,
		rs2_data_in => rs2_save_IDEX,rs3_data_in => rs3_save_IDEX, rd_data_in => rd_data, rs1_data_out => rs1_save_EXWB,
		rs2_data_out => rs2_save_EXWB, rs3_data_out => rs3_save_EXWB, rd_data_out => rsd_save_EXWB );	
			
		
		
	
		
		
		
		--
--			 clk : in STD_LOGIC;	
--		 r1 : in STD_LOGIC_VECTOR(127 downto 0);
--		 r2 : in STD_LOGIC_VECTOR(127 downto 0);
--		 r3 : in STD_LOGIC_VECTOR(127 downto 0);
--		 instr: in STD_LOGIC_VECTOR(24 downto 0);
--		 next_instr: in STD_LOGIC_VECTOR(24 downto 0);
--		 FWD_A : out STD_LOGIC;
--		 FWD_B : out STD_LOGIC;
--		 FWD_C : out STD_LOGIC
			 	
			forward_unit : entity Data_Forwading_Unit	
		
		port map (r1 => rs1_save_IDEX,  r2 => rs2_save_IDEX,
		r3 => rs3_save_IDEX, instr => ins_EXWB, next_instr => ins_IDEX, FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);
		
		
		
		
		
		mux_WB : entity \Forwarding Muxes\ port map (r1_ins => rs1_save_IDEX,  r2_ins => rs2_save_IDEX,
		r3_ins => rs3_save_IDEX,alu_out => output,FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);   
	
		
	
	
	
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
  
  
  
 -- update: process
--  begin 
--	 
--	  wait for 15us;
--	   for i in 0 to 20 loop
--	  rd_data <= rsd_save_EXWB;	   
--	  
--	  wait for 10us;				   
--	  end loop;
--  end process;
  
  
  
  
			
	
end tb;
			 	
		
		 	
		
		