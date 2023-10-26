library IEEE;
use IEEE.std_logic_1164.all;

entity rotate2 is
    port(
        IDB : in STD_LOGIC_VECTOR(4 downto 0);
        ODB : out STD_LOGIC_VECTOR(4 downto 0)
    );
end entity;

architecture rotate2_arch of rotate2 is
    begin 
    -- ROT2([4 3 2 1 0]) = [2 1 0 4 3]
    ODB <= IDB(2 downto 0) & IDB(4 downto 3);
end architecture;