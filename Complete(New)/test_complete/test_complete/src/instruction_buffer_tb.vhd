
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
	signal clk, reset: std_logic;
---	signal clk, reset, write: std_logic; 
--	
--	signal ins_IFID: std_logic_vector(24 downto 0);		   
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
	--signal instr_out, instr_in : std_logic_vector(24 downto 0);		  
	
	--signal rs1_data, rs2_data, rs3_data, rd_data, output : std_logic_vector(127 downto 0);
	
	--signal instrc : std_logic_vector(24 downto 0);
	constant period : time := 5us;
	constant temp : time := 1sec;
--	type InstBuff is array (0 to 63) of std_logic_vector(24 downto 0);

--Instruction Buffer
	signal instr:std_logic_vector(24 downto 0);
--IF/ID
	signal ins_IFID: std_logic_vector(24 downto 0);
-- ID/EX
	--  signal ins_IDEX: std_logic_vector(24 downto 0);		   
	signal rs1_IDEX: std_logic_vector(127 downto 0);
	signal rs2_IDEX: std_logic_vector(127 downto 0);
	signal rs3_IDEX: std_logic_vector(127 downto 0);
	--signal rsd_IDEX: std_logic_vector(127 downto 0);
	signal write_IDEX : std_logic;
	
--EX/FWD
	signal ins_EXFWD: std_logic_vector(24 downto 0);		   
	signal rs1_EXFWD: std_logic_vector(127 downto 0);
	signal rs2_EXFWD: std_logic_vector(127 downto 0);
	signal rs3_EXFWD: std_logic_vector(127 downto 0);
	signal rsd_EXFWD: std_logic_vector(127 downto 0);
	signal write_EXFWD : std_logic;
--Forwarding signals
	 signal FWD_A : STD_LOGIC;
	 signal FWD_B : STD_LOGIC;
	 signal FWD_C : STD_LOGIC; 
--EX/FWD
--	signal ins_FWDALU: std_logic_vector(24 downto 0);		   
	signal rs1_FWDALU: std_logic_vector(127 downto 0);
	signal rs2_FWDALU: std_logic_vector(127 downto 0);
	signal rs3_FWDALU: std_logic_vector(127 downto 0);
--	signal rsd_FWDALU: std_logic_vector(127 downto 0);
--EX/WB
--	signal ins_EXWB: std_logic_vector(24 downto 0);		   
	signal rsd_EXWB: std_logic_vector(127 downto 0);
	signal write_EXWB : std_logic;
--WB/REG
	--signal ins_WBREG: std_logic_vector(24 downto 0);		   
	signal rsd_WBREG: std_logic_vector(127 downto 0);
	signal write_WBREG : std_logic;
	signal rd_data_num: std_logic_vector(4 downto 0);
begin
	
	UUT : entity instruction_buffer	
		port map (in_buffer => in_buffer, reset=> reset, clk => clk,  instr_out => instr);	 
	
	
	
	E_IF_ID : entity IF_ID	

		port map (reset=> reset, clk => clk,  instr_in => instr, instr_out => ins_IFID);	
	
	
	
  	RegFile: entity register_file	
		port map ( clk => clk,reset=> reset, write=> write_IDEX,  rs1_data => rs1_IDEX,  rs2_data => rs2_IDEX,  
		rs3_data => rs3_IDEX, instrc => ins_IFID,rd_data => rsd_EXWB, 
		write_wbex => write_WBREG, rd_num => rd_data_num );					   
		
	
	
	--ALU_EXE : entity ALU	
--		port map (  r1 => rs1_FWDALU,  r2 => rs2_FWDALU,  
--		r3 => rs2_FWDALU, instrc => ins_EXFWD, o => rsd_EXWB);	 
		
		
	E_ID_EX: entity ID_EX 
		port map (clk => clk, reset => reset, instr_in =>ins_IFID, rs1_data_in=>rs1_IDEX, rs2_data_in=>rs2_IDEX,
		rs3_data_in=>rs3_IDEX, write_in => write_IDEX, instr_out => ins_EXFWD,rs1_data_out => rs1_EXFWD, 
		rs2_data_out => rs2_EXFWD,rs3_data_out => rs3_EXFWD,write_out=>write_EXWB
		);
		
	ALU_EXE : entity ALU	
		port map ( clk => clk, r1 => rs1_FWDALU,  r2 => rs2_FWDALU,  
		r3 => rs3_FWDALU, instrc => ins_EXFWD, o => rsd_EXWB);	
		
		
		-- might need to add write signal inbetween	(in the fwd or alu to pass to this for timing purposes)
	u_EX_WB: entity EX_WB 
		port map ( clk => clk, reset=>reset, instr_in => ins_EXFWD, rd_data_in => rsd_EXWB,
		rd_data_out => rsd_WBREG, rd_data_num => rd_data_num, write_in =>write_EXWB, write_out => write_WBREG);		

		
		
		
	FWD_MUX : entity \Forwarding Muxes\ 
		port map (clk=>clk,r1_ins => rs1_EXFWD,  r2_ins => rs2_EXFWD,
		r3_ins => rs3_EXFWD,alu_out => rsd_EXWB ,FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C,
		r1_out => rs1_FWDALU,  r2_out => rs2_FWDALU,r3_out => rs3_FWDALU
		);
		
	
		
		

			
		
	
	forward_unit : entity Data_Forwading_Unit	
		port map (clk => clk,instr=>ins_EXFWD,next_instr => ins_IFID ,FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);
		
		
		
		
		
		   
	
		
	
	
	
		process 	 
		
		variable lin     : line;
		--variable v_OLINE     : line;
		variable temp_inst : std_logic_vector(24 downto 0);
		
		variable counter : integer := 0;
		variable ran : boolean := false;  

		  
		
		begin	 
			
			reset <= '1';
			write_WBREG <= '1';
			rsd_WBREG <= "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
	
			
				
			
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
				
				
				--
--				if(counter = 63) then  
--				counter := 0;
--			else 		
				counter := counter + 1;
	
			--end if;
			
			end loop; 		  
			counter	:= 0;
			ran := true;
    	file_close(txt_file);	
		  end if;
	--	std.env.finish;
		wait; 
		
		end process;
		
		
		
		
		clock: process	
		File result : TEXT; 		 
		File expected : TEXT; 
		variable lin : line; 
		variable lin2     : line;
		--variable v_OLINE     : line;
		variable temp_result : std_logic_vector(127 downto 0);
		
		
	
		
  begin	
	  file_open(result, "output.txt", write_mode);			
	   file_open(expected, "expected.txt", read_mode);
	  for i in 0 to 68 loop
	
	  clk <='0';
	  wait for period/2;
	  clk<='1';
	  wait for period/2;	  
	 --end if;			  			  
	 if(i > 3) then 
		readline(expected, lin2);
	read(lin2, temp_result);	 
		 
	  assert rsd_EXWB = temp_result  report " incorrect output"
   severity warning;
			 
	 write(lin, string'("output :"));	 
	  write(lin, rsd_EXWB);
	  writeLine(result, lin);
	 			end if;
	end loop; 
file_close(txt_file);		
  end process;
			
			
	
end tb;
