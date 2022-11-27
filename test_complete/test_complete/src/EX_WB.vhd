library ieee;
use ieee.std_logic_1164.all; 



entity EX_WB is
	port(
	clk : in std_logic;
	instr_in : in std_logic_vector(24 downto 0);
	instr_out : out std_logic_vector(24 downto 0);	   
	rs1_data_in : in std_logic_vector(127 downto 0);	  
	rs2_data_in : in std_logic_vector(127 downto 0);	
	rs3_data_in : in std_logic_vector(127 downto 0);
	rd_data_in : in std_logic_vector(127 downto 0);	
	
	rs1_data_out : out std_logic_vector(127 downto 0);	  
	rs2_data_out : out std_logic_vector(127 downto 0);	
	rs3_data_out : out std_logic_vector(127 downto 0);
	rd_data_out : out std_logic_vector(127 downto 0)
	
	
	
	);
end EX_WB;

architecture behavioral of EX_WB is
begin
	process(clk)
	begin	
		
	if rising_edge(clk)	then
			instr_out <= instr_in;	
			rs1_data_out <= rs1_data_in;  
			rs2_data_out <= rs2_data_in;
			rs3_data_out <= rs3_data_in;
			rd_data_out <= rd_data_in;
	
		end if;
	end process;
end behavioral;


