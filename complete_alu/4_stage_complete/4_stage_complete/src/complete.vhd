  
--------------------- TC514 Model ------------------------------------
--
--  File: TC514model.vhd
--  Ken Short


-- Counter component

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_cntr is
	generic (n : integer := 16);
	port (clk, cnten1, cnten2, up, ld_bar, rst_bar: in std_logic;
		ld_val: in std_logic_vector(n-1 downto 0);
		--		q: out std_logic_vector (n-1 downto 0);
		cntr_zero: out std_logic);
end bin_cntr;

architecture behavioral of bin_cntr is
begin
	
	cntr: process (clk)
		variable count_v : unsigned(n-1 downto 0);
	begin
		if rising_edge(clk) then
			if rst_bar = '0' then
				count_v := (others => '0');
			elsif ld_bar = '0' then
				count_v := unsigned(ld_val);
			elsif cnten1 = '1' and cnten2 = '1'  then
				case up is
					when '1' => count_v := count_v + 1;
					when others => count_v := count_v - 1;
				end case;
			else
				null;
			end if;
			
			--			q <= std_logic_vector(count_v);
			
			if count_v = to_unsigned(0,n)  then
				cntr_zero <= '1';
			else
				cntr_zero <= '0';
			end if;
		end if;
	end process;
end behavioral;


-- FSM component
-- This FSM has four states: idle, de_int, ovr_shoot, and zero_int
-- The idle state models the TC514 auto_zero and integrate states,
-- for these two states the comparator output is 1.
-- When in the de_int state for a positive voltage the comparator
-- output is 1, but we must stay in this state for a time for a nunber
-- of counter clock periods equal to the binary reprsentation of the
-- analog input value.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
	port (a, b, clk, rst_bar, cntr_zero: in std_logic;
		cnten, up, ld_bar, cmptr : out std_logic);
end fsm;

architecture behavioral of fsm is
	type state is (idle, de_int, ovr_shoot, zero_int);
	signal present_state, next_state : state;
	
begin
	
	state_reg: process (clk)				-- state register process
	begin
		if rising_edge(clk) then
			if rst_bar = '0' then
				present_state <= idle;
			else
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	output: process (present_state)			-- output process
	begin
		case present_state is
			
			when idle =>
				cmptr <= '1' after 10 ns;
				cnten <= '0';
				up <= '0';
				ld_bar <= '0';			
			
			when de_int =>
				cmptr <= '1' after 10 ns;
				cnten <= '1';
				up <= '0';
				ld_bar <= '1';
			
			when ovr_shoot =>
				-- overshoot proportional to input voltage
				cmptr <= '0' after 10 ns;
				cnten <= '1';
				up <= '1';
				ld_bar <= '1';
			
			when zero_int =>
				cmptr <= '0' after 10 ns;
				cnten <= '1';
				up <= '0';
				ld_bar <= '1';
			
			when others =>
				cmptr <= '1' after 10 ns;
				cnten <= '0';
				up <= '0';
				ld_bar <= '0';			
			
		end case;							
	end process;
	
	nx_state: process (present_state, a, b, cntr_zero)	-- next state process
	begin
		case present_state is
			
			when idle =>
				if a = '1' and b = '1' then
					next_state <= de_int;
				else
					next_state <= idle;
				end if;
			
			when de_int =>
				if cntr_zero = '1' then
					next_state <= ovr_shoot;
				else
					next_state <= de_int;
				end if;
			
			when ovr_shoot =>
				if a = '0' and b = '0' then
					next_state <= zero_int;
				else
					next_state <= ovr_shoot;
				end if;
			
			when zero_int =>
				if cntr_zero = '1' then
					next_state <= idle;
				else
					next_state <= zero_int;
				end if;
			
			when others =>
				next_state <= idle;
			
		end case;							
	end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity freq_div_tc514_model is
	port (
		clk : in std_logic;			-- system clock
		rst_bar: in std_logic;		-- synchronous reset
		divisor: in std_logic_vector(3 downto 0);	-- divider
		clk_dvd: out std_logic);	-- output
end freq_div_tc514_model;

architecture behavioral of freq_div_tc514_model is
begin
	
	div: process (clk)
		variable count_v : unsigned(3 downto 0);
		variable q_v : std_logic;
	begin
		if rising_edge(clk) then
			if rst_bar = '0' then
				count_v := unsigned(divisor);
				q_v := '0';
			else
				case count_v is
					when "0001" =>
						count_v := unsigned(divisor);
					q_v := '1';
					when others =>
						count_v := count_v - 1;
					q_v := '0';
				end case;
			end if;
			clk_dvd <= q_v;
		end if;
	end process;
end behavioral;


-- top-level TC514 Modelentity

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity tc514model is
	generic (n : integer := 16);
	port (
		a: in std_logic;
		b: in std_logic;
		analog_val_bin: in std_logic_vector(n-1 downto 0);
		clk: in std_logic;
		-- clk_dvd: in std_logic; 	-- previously commented out
		cmptr: out std_logic;
		rst_bar: in std_logic
		);
end TC514model;


architecture behavior of TC514model is
	
	signal cnten1_sig, up_sig, ld_bar_sig, cntr_zero_sig: std_logic;
	signal clk_dvd_sig: std_logic;
	
begin
	
	u0: entity freq_div_TC514_model port map (clk => clk, rst_bar => rst_bar, divisor => "0100",
		clk_dvd => clk_dvd_sig);
	
	u1: entity bin_cntr
	generic map (n => n)
	port map (clk => clk, cnten1 => cnten1_sig, cnten2 => clk_dvd_sig, up => up_sig, ld_bar => ld_bar_sig,
		rst_bar => rst_bar, ld_val => analog_val_bin, cntr_zero => cntr_zero_sig);
	
	u2: entity fsm
	port map (a => a, b => b, clk => clk, rst_bar => rst_bar,
		cntr_zero => cntr_zero_sig, cnten => cnten1_sig, up => up_sig,
		ld_bar => ld_bar_sig, cmptr => cmptr);
	
end architecture;	
