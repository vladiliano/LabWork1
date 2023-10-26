library IEEE;
use IEEE.std_logic_1164.all;

entity simple_des_full_tb is
end entity;

architecture simple_des_full_tb_arch of simple_des_full_tb is
    signal input_msg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal cipher_key : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal cipher_mode : STD_LOGIC := '0';
	signal output_msg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal enc_res : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal dec_res : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin 

    UUT: entity work.simple_des_full(simple_des_full)
    port map (
		input_msg => input_msg,
		cipher_key => cipher_key,
        cipher_mode => cipher_mode,
		output_msg => output_msg
    );
    
    stim_gen: process
	begin
		-- test 1 - part 1: encrypt
		input_msg <= "11101010"; --EA
		cipher_key <= "0010111110";	--0BE
		cipher_mode <= '0'; -- encrypt
		wait for 10 ns;
		assert output_msg = "10011101" report "Test 1: Enc Open Text do not match!" severity ERROR;
		
		-- test 1 - part 2: decrypt
		input_msg <= "10010001"; --91
		cipher_key <= "0010111110";	--0BE
		cipher_mode <= '1'; -- decrypt
		wait for 10 ns;
		assert output_msg = "00110101" report "Test 1: Dec Close Text do not match!" severity ERROR;
		
		-- test 2 - part 1: encrypt
		input_msg <= "11011001"; --D9
		cipher_key <= "0001110000";	--070
		cipher_mode <= '0'; -- encrypt
		wait for 10 ns;
		assert output_msg = "00010101" report "Test 2: Enc Open Text do not match!" severity ERROR;
		
		-- test 2 - part 2: decrypt
		input_msg <= "11101111"; --EF
		cipher_key <= "0001110000";	--070
		cipher_mode <= '1'; -- decrypt
		wait for 10 ns;
		assert output_msg = "01111111" report "Test 2: Dec Close Text do not match!" severity ERROR;
		
	end process;

end architecture;