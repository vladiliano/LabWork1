library IEEE;
use IEEE.std_logic_1164.all;

entity rotate1 is
    port(
        IDB : in STD_LOGIC_VECTOR(4 downto 0);
        ODB : out STD_LOGIC_VECTOR(4 downto 0)
    );
end entity;

architecture rotate1_arch of rotate1 is
    begin 
    -- ROT1([4 3 2 1 0]) = [3 2 1 0 4]
    ODB <= IDB(3 downto 0) & IDB(4);
end architecture;