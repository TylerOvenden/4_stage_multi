		
----------------------------------------------------------------------------------------
--------------  top level model -------------------------------------------------------------			
		
		
		
		
				
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	
use work.instr_pack.all;
use work.regfile_pack.all;
use work.all;

entity processor_model is

port (

clk : in std_logic; -- system clock	 
-- synchrounous counter clear		  
--write: in std_logic;	--write signal	   
reset : in std_logic;
in_buffer: in InstBuff;
instr_in : in std_logic_vector(24 downto 0);
--
--instr_out : out std_logic_vector(24 downto 0);	  
--
--rd_address: in std_logic_vector(4 downto 0);
--
rs1_data : out std_logic_vector(127 downto 0);	  
rs2_data : out std_logic_vector(127 downto 0);	
rs3_data : out std_logic_vector(127 downto 0);
rd_data : in std_logic_vector(127 downto 0)		

--				   regs: in regFile



		);	   
		
		
		
		
		
		
----------------------------------------------------------------------------------------
--------------  top level model -------------------------------------------------------------			
		
		
		
		
		
end processor_model;


architecture behavior of processor_model is
		
	--signal cnten1_sig, up_sig, ld_bar_sig, cntr_zero_sig: std_logic;
	--signal clk_dvd_sig: std_logic;   	 
	
	signal writ: std_logic;
	
	-- IF/ID
	signal ins_IFID: std_logic_vector(24 downto 0);
	
	signal ins: std_logic_vector(24 downto 0);		   
	signal rs1_save: std_logic_vector(127 downto 0);
	signal rs2_save: std_logic_vector(127 downto 0);
	signal rs3_save: std_logic_vector(127 downto 0);	
	
	
	
	

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
	
	signal alu_output: std_logic_vector(127 downto 0);	  
	
	
begin
		
	
	u0: entity instruction_buffer port map (in_buffer => in_buffer, clk => clk, 
		reset=> reset, instr_out => ins);	
		
	u_IF_ID: entity IF_ID port map ( clk => clk, 
		reset=> reset, instr_out => ins_IFID, instr_in => ins);	
			
		
		
		
		
	u1: entity register_file port map (rs1_data => rs1_save,  rs2_data => rs2_save,
		rs3_data => rs3_save, clk => clk, rd_data => rd_data,reset=> reset, instrc => ins, write => writ);		 
	
	--	
--		instr_in : in std_logic_vector(24 downto 0);
--	instr_out : out std_logic_vector(24 downto 0);	   
--	rs1_data_in : in std_logic_vector(127 downto 0);	  
--	rs2_data_in : in std_logic_vector(127 downto 0);	
--	rs3_data_in : in std_logic_vector(127 downto 0);
--	rd_data_in : in std_logic_vector(127 downto 0);	
--	
--	rs1_data_out : out std_logic_vector(127 downto 0);	  
--	rs2_data_out : out std_logic_vector(127 downto 0);	
--	rs3_data_out : out std_logic_vector(127 downto 0);
--	rd_data_out : out std_logic_vector(127 downto 0);	
--		
	
	u_ID_EX: entity ID_EX port map ( clk => clk, 
		reset=> reset, instr_out => ins_EXWB, instr_in => ins, rs1_data_in => rs1_save,
		rs2_data_in => rs2_save,rs3_data_in => rs3_save, rd_data_in => rd_data, rs1_data_out => rs1_save_IDEX,
		rs2_data_out => rs2_save_IDEX, rs3_data_out => rs3_save_IDEX, rd_data_out => rsd_save_IDEX );	
		
	
	--u_IF_ID: entity IF_ID port map ( clk => clk, 
--		reset=> reset, instr_out => ins_IFID, instr_in => ins);		
--	
			
	
	u2: entity alu port map (r1 => rs1_save,  r2 => rs2_save,
		r3 => rs3_save, o =>  alu_output,
		instrc => ins_EXWB );	
	
		
	u3: entity Data_Forwading_Unit port map (r1 => rs1_save_IDEX,  r2 => rs2_save_IDEX,
		r3 => rs3_save_IDEX, instr => ins_EXWB, next_instr => ins_IDEX, FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);
	
	u4 : entity \Forwarding Muxes\ port map (r1_ins => rs1_save_IDEX,  r2_ins => rs2_save_IDEX,
		r3_ins => rs3_save_IDEX,alu_out => alu_output,FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);   	
		
		


	
end architecture;	








