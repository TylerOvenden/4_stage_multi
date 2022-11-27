-------------------------------------------------------------------------------
--
-- Title       : \Forwarding Muxes\
-- Design      : Data Forwarding
-- Author      : Rob
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : B:\Stony Brook\ESE345\4_stage_multi\Data Forwarding\Data_Forwarding\Data Forwarding\src\Forwarding Muxes.vhd
-- Generated   : Thu Nov 24 22:53:17 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;

entity \Forwarding Muxes\ is
	port(
	 	 clk : in STD_LOGIC; -- clk
	-- Registers in
		 alu_out : in STD_Logic_vector(127 downto 0);
		 r1_ins : in STD_LOGIC_VECTOR(127 downto 0);
		 r2_ins:  in STD_LOGIC_VECTOR(127 downto 0);
		 r3_ins:  in STD_LOGIC_VECTOR(127 downto 0); 
	-- control signals
		 FWD_A : in STD_LOGIC;
		 FWD_B : in STD_LOGIC;
		 FWD_C : in STD_LOGIC;
	--output	 
		 r1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 r2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 r3_out: out STD_LOGIC_VECTOR(127 downto 0)
	     );
end \Forwarding Muxes\;



architecture \Forwarding Muxes\ of \Forwarding Muxes\ is
begin
process(clk)
begin 
	--r1 mux
	if FWD_A = '1' then
		r1_out <= alu_out;
	else
		r1_out <= r1_ins;
	end if;	
	--r2 mux
	if FWD_B = '1' then
		r2_out <= alu_out;
	else
		r2_out <= r2_ins;
	end if;
	--r3 mux
	if FWD_C = '1' then
		r3_out <= alu_out;
	else
		r3_out <= r3_ins;
	end if;

end process;
end \Forwarding Muxes\;
