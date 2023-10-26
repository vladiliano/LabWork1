library IEEE;
use IEEE.std_logic_1164.all;

entity key_mux is
    port(
        IN1 : in STD_LOGIC_VECTOR(7 downto 0);
        IN2 : in STD_LOGIC_VECTOR(7 downto 0);
        MODE : in STD_LOGIC;
        SEL : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture key_mux_arch of key_mux is
    begin 
    -- bus mux
    SEL <= IN1 when MODE = '0' else IN2;
end architecture;