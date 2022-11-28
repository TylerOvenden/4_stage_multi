library ieee;
use ieee.std_logic_1164.all; 



entity EX_WB is
	port(
	clk : in std_logic;
	reset : in std_logic;
	instr_in : in std_logic_vector(24 downto 0);
	--instr_out : out std_logic_vector(24 downto 0);	   
	
	rd_data_in : in std_logic_vector(127 downto 0);	
	
	
	rd_data_out : out std_logic_vector(127 downto 0);
	rd_data_num: out std_logic_vector(4 downto 0);
	write_in : in std_logic;
	write_out : out std_logic
	
	);
end EX_WB;

architecture behavioral of EX_WB is

--signal ins_EXWB: std_logic_vector(24 downto 0);		   
--signal rsd_EXWB: std_logic_vector(127 downto 0); 
--signal rd_data_num_EXWB:std_logic_vector(4 downto 0);
--signal write_EXWB: std_logic;
begin
	process(clk)
	variable rsd_EXWB: std_logic_vector(127 downto 0); 
	variable rd_data_num_EXWB:std_logic_vector(4 downto 0);
	variable write_EXWB: std_logic;
	begin
	--if reset = '1' then 
--		rsd_EXWB := "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
--		write_EXWB := '0';
--		rd_data_num_EXWB := "00000";
--	else
	if rising_edge(clk)	then	  --output
			--instr_out <= ins_EXWB;	
			rd_data_out <= rsd_EXWB;
			write_out <= write_EXWB;
			rd_data_num <= rd_data_num_EXWB;
	elsif falling_edge(clk) then	-- update reg
			--ins_EXWB <= instr_in;
			rsd_EXWB := rd_data_in;
			write_EXWB := write_in;
			rd_data_num_EXWB := instr_in(4 downto 0);
	end if;	
	--end if;
	end process;
end behavioral;


