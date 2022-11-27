		
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
instr_in : in std_logic_vector(24 downto 0)	
--
--instr_out : out std_logic_vector(24 downto 0);	  
--
--rd_address: in std_logic_vector(4 downto 0);
--
--rs1_data : out std_logic_vector(127 downto 0);	  
--rs2_data : out std_logic_vector(127 downto 0);	
--rs3_data : out std_logic_vector(127 downto 0);
--rd_data : in std_logic_vector(127 downto 0);		

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
		reset=> reset, instr_out => ins_IFID);	
		
	u1: entity register_file port map (rs1_data => rs1_save_IDEX,  rs2_data => rs2_save_IDEX,
		rs3_data => rs3_save_IDEX, clk => clk, rd_data => rsd_save_IDEX,
		reset=> reset, instrc => ins_IDEX, write => writ);	
			
	
	u2: entity alu port map (r1 => rs1_save_IDEX,  r2 => rs2_save_IDEX,
		r3 => rs3_save_IDEX, o =>  alu_output,
		instrc => ins_EXWB );	
	
		
	u3: entity Data_Forwading_Unit port map (clk => clk,r1 => rs1_save_IDEX,  r2 => rs2_save_IDEX,
		r3 => rs3_save_IDEX, instr => ins_EXWB, next_instr => ins_IDEX, FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);
	
--	u4 : entity Forwarding Muxes port map (clk => clk,r1_ins => rs1_save_IDEX,  r2_ins => rs2_save_IDEX,
--		r3_ins => rs3_save_IDEX,alu_out => alu_output,FWD_A => FWD_A,FWD_B => FWD_B,FWD_C => FWD_C);   
--		
	 
		
		


	
end architecture;	








