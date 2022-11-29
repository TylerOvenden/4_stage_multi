-------------------------------------------------------------------------------
--
-- Title       :   register_file
-- Design      : register_file
-- Author      :  Tyler Ovenden 112122685
-- Company     : SUNY Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\Lab11\lab11\src\ tc514cntrl.vhd
-- Generated   : 10/1/22
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : he register file has 32 128-bit registers. On any cycle, there can be 3 reads and 1 write. 
-- When executing instructions, each cycle two/three 128-bit register values are read, and one 128-bit result 
-- can be written if a write signal is valid. This register write signal must be explicitly declared so it can 
-- be checked during simulation and demonstration of your design. 
-- The register module must be implemented as a behavioral model in VHDL (dataflow/RTL model in Verilog).
-------------------------------------------------------------------------------			   




library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;	
	
	
	
	
entity register_file is
generic (n : integer := 128; --constant for bits
registers : integer := 32;	 
length_instr : integer := 25	


);
port (clk : in std_logic; -- system clock	
write : out std_logic; --write signal	
write_wbex : in std_logic; --write signal
reset :  in std_logic;
 

instrc : in std_logic_vector(24 downto 0);	   
--instrc_out : out std_logic_vector(24 downto 0);

--rd_address: in std_logic_vector(4 downto 0);

rs1_data : out std_logic_vector(127 downto 0);	  
rs2_data : out std_logic_vector(127 downto 0);	
rs3_data : out std_logic_vector(127 downto 0);
rd_data : in std_logic_vector(127 downto 0);
rd_num : in std_logic_vector(4 downto 0) --number of register to read into




);				 


end register_file;

			 
architecture behaviorhal of register_file is 

	type regFile is array (0 to registers-1) of std_logic_vector(n-1 downto 0);
	signal regs  : regFile;

begin  
	process(clk) 
	begin	  
	
		--if rising_edge(clk) then	
			
			if(reset = '1')then 
		  		rs1_data  <= std_logic_vector(to_signed(0, 128));
				rs2_data <=	 std_logic_vector(to_signed(0, 128));
				rs3_data <=	 std_logic_vector(to_signed(0, 128));
		
				regs(0) <= "11111111000000010000110011001011100001101100000001000001100010100010111111101110111111111011010101100111100100011100011111001000";
				
				regs(1) <= "01100000000011100010101010110100110100110100101110111110011101101111011010110101111000011001101001111001000101101101110011101000";
				regs(2) <= "00011100010110010101000111100001101011100101010101011101000111000110101111010111100100101000100000000110111010001011100000010100";
				regs(3) <= "10111000110010011000011110100001111100101001011100100000000111011001110000011110011010000001001011100111010001101000001010001101";
				regs(4) <= "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
				regs(5) <= "11100011110010101001111100110011011100110101011001111000010010001011111000000101100001011001110110100001000110110000001001011110";
				regs(6) <= "10111110110000001111100000110111100011001011100101110101010111101100001100010110111000000110001011011111000000010101010011110101";
				regs(7) <= "10010011110010111110101010111101100000110011110010001111101001000110101010010110110111111110001100110000110000101101110110101100";
				regs(8) <= "11011111100100011100111111101110101100001000101010100011100100001010000110000110010011100000100010101110100111010001111010011001";
				
				regs(9) <= "10010111101010000010111111000001000100100101100010010000000010001001110101000010101011011101010001110101111101101110110001010000";
				regs(10) <= "01001000011001101111111110100100110011000011001000111100010100010110101111010011101110010010001000000001001101011100100000101110";
				regs(11) <= "01100011001011011100010000111110011001000000111001101010001111011100000101010000010010001011001111100000001111010110111100011101";
				regs(12) <= "01001001010111110110111111101101110011001010010011110111101010100011101101111010101010101000000000000001011000111110001010101101";

				regs(13) <= "10011101110100110010111110000101100100101100000100001111000000110011001110110110010011100011100001110000111110000110100000100001";
				regs(14) <= "11101011110001010100111101011010000100110110111011010100101000001111001000111000100101000101001100101101110100100111000001110011";	
				regs(15) <= "01111101010010011100101000111001100111000101010111010011011000101101111101101011011001111000000101110111101010011100101110110010";	
				regs(16) <= "00010100100110100000100100111001001010110011011010010010010011111100111111011100101001001010100011101100101011100100100001101111";	
				regs(17) <= "01001100110001110100010000101110000110101101000010011101000100001111001100100011110011111110010011011011010001011010111111110011";
				regs(18) <= "01000000001001101110111001100111011000100110101000011000000000111010111001101111111110011000100100000001111011110100011000001111";
				regs(19) <= "00000100101101010011010110011111010111011010111111011010110000101001111000010101000011101110100000000011000111111010101101010010";
				regs(20) <= "10100101101100111111001110111110010010001000110011111010001111001011110111111010110011010110011011011100101010011100111010010100";
				regs(21) <= "00100100010000001001110000011100000010110011101001110101110111100010010001011111100101110001110111101110001011010111100001001000";
				regs(22) <= "11001011001101010111110011100000110110111111101001010110101011111010010011001010101000101010010010010001000111101010100110000100";
				regs(23) <= "00010110010100101101111001000011010110111100101101111111011110000001100101000111010000111000000111011011111000100010100111100001";
				regs(24) <= "00001010110101110111111001001010111001001010010101101100110001001000110110110010001010011011111101000100111010100110101000010100";
				regs(25) <= "11001001011101111010010110111100000010011001001010101000001110110001100101111110000000101110110000110010110110110010001010000011";
				regs(26) <= "00100100001100010000100000011010111000010010101101101011001110110000011101001111100001111001011110011001100001110101101111001111";
				regs(27) <= "10100000101001000110011110011010111101011101011010101100110000101010001111010111001101101001110100011111110010101111000010100000";
				regs(28) <= "00001101000010010111001100110110111001010100011110011111100101010011001011001001000011000001000101111010100010101010111000111010";
				regs(29) <= "11001000110010111010111010101110011011010101011001010101010010100011111100000011110111010111101011010100011110100000010001010011";
				regs(30) <= "11101111100010010110111110100100000100110100000110001000111001011100010110000100110001100111010110111111011001011011111000111011";
				regs(31) <= "11010000000110000110000110111000100111000001111001011100011011001100100011101101000110010010001010001100100010001101101000110101";		  
				write <= '1';
				--run nop
				-- instrc_out <= "1100000000000000000000000";
				
			
				
				
				
			--r4 instructions	
			elsif 	(instrc(24 downto 23) = "10") then 	  
				rs1_data <= regs(to_integer(unsigned(instrc(19 downto 15))));
				rs2_data <= regs(to_integer(unsigned(instrc(14 downto 10))));
				rs3_data <= regs(to_integer(unsigned(instrc(9 downto 5))));	 
				
	
				--write
				--regs(to_integer(unsigned(instrc(4 downto 0)))) <= rd_data;
				write <= '1';
				
				
				
			elsif 	(instrc(24 downto 23) = "11") then 	
				rs1_data <= regs(to_integer(unsigned(instrc(19 downto 15))));
				rs2_data <= regs(to_integer(unsigned(instrc(14 downto 10))));
				
				
				--if(write = '1') then	
					if instrc(18 downto 15) = "0000" then 
						write <= '0';	
						
				else 		
						
				
				write <= '1';	
				--regs(to_integer(unsigned(instrc(4 downto 0)))) <= rd_data;	
				end if;	
				
			
		
	
			--load immidate 
		    elsif (instrc(24 downto 23) = "0") then 
			--	rs1_data <= "10100000101000000100111011111101110011100011001000010011001100100010010010011010100101010110110110000111000010000100010000101111";
				--regs(to_integer(unsigned(instrc(4 downto 0)))) <= rd_data;	
				 write <= '1';
	 
			end if;
	 		--end if;
	 	if write_wbex = '1'	then
			regs(to_integer(unsigned(rd_num(4 downto 0)))) <= rd_data;	
		end if;
	end process;
	
	
end behaviorhal;	
	




library ieee;
use ieee.std_logic_1164.all; 




entity ID_EX is
	port(
	clk : in std_logic;
	instr_in : in std_logic_vector(24 downto 0);
	instr_out : out std_logic_vector(24 downto 0);	   
	rs1_data_in : in std_logic_vector(127 downto 0);	  
	rs2_data_in : in std_logic_vector(127 downto 0);	
	rs3_data_in : in std_logic_vector(127 downto 0);
	--rd_data_in : in std_logic_vector(127 downto 0);	
	
	rs1_data_out : out std_logic_vector(127 downto 0);	  
	rs2_data_out : out std_logic_vector(127 downto 0);	
	rs3_data_out : out std_logic_vector(127 downto 0);
	write_in : in std_logic;
	write_out : out std_logic;
	
	
	reset : in std_logic
	);
end ID_EX;

architecture behavioral of ID_EX is
--signal ins_IDEX: std_logic_vector(24 downto 0);		   
--signal rs1_IDEX: std_logic_vector(127 downto 0);
--signal rs2_IDEX: std_logic_vector(127 downto 0);
--signal rs3_IDEX: std_logic_vector(127 downto 0);

--signal rsd_IDEX: std_logic_vector(127 downto 0);
--signal write_in: std_logic;
signal write_IDEX: std_logic;
begin
	process(clk, reset)
	variable ins_IDEX: std_logic_vector(24 downto 0);		   
variable rs1_IDEX: std_logic_vector(127 downto 0);
variable rs2_IDEX: std_logic_vector(127 downto 0);
variable rs3_IDEX: std_logic_vector(127 downto 0);
	begin	
		
		
		if reset = '1' then
			instr_out <= "0000000000000000000000000";
			rs1_data_out <= rs1_data_in;  
			rs2_data_out <= rs2_data_in;
			rs3_data_out <= rs3_data_in;
			
			
			
		else
			if rising_edge(clk)	then --output 
				instr_out <= ins_IDEX;	
				rs1_data_out <= rs1_IDEX;  
				rs2_data_out <= rs2_IDEX;
				rs3_data_out <= rs3_IDEX;
				write_out <= write_IDEX;
			elsif falling_edge(clk) then --update reg	
				ins_IDEX := instr_in;	
				rs1_IDEX := rs1_data_in;  
				rs2_IDEX := rs2_data_in;
				rs3_IDEX := rs3_data_in;
				write_IDEX <= write_in;	
			end if;
		end if;
	end process;
end behavioral;









	

	
