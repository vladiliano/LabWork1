-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : lab1
-- Author      : Gizmo
-- Company     : HP Inc.
--
-------------------------------------------------------------------------------
--
-- File        : E:\my_designs\lab1_Habrukh_IKM720a\lab1\compile\simple_des_full.vhd
-- Generated   : Fri Oct 27 00:21:07 2023
-- From        : E:\my_designs\lab1_Habrukh_IKM720a\lab1\src\simple_des_full.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

entity simple_des_full is
  port(
       input_msg : in STD_LOGIC_VECTOR(7 downto 0);
       cipher_key : in STD_LOGIC_VECTOR(9 downto 0);
       cipher_mode : in STD_LOGIC;
       output_msg : out STD_LOGIC_VECTOR(7 downto 0)
  );
end simple_des_full;

architecture simple_des_full of simple_des_full is

---- Component declarations -----

component init_perm
  port(
       INDB : in STD_LOGIC_VECTOR(7 downto 0);
       OUDB : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component init_perm_inv
  port(
       INDB : in STD_LOGIC_VECTOR(7 downto 0);
       OUDB : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component key_mux
  port(
       IN1 : in STD_LOGIC_VECTOR(7 downto 0);
       IN2 : in STD_LOGIC_VECTOR(7 downto 0);
       MODE : in STD_LOGIC;
       SEL : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component perm_choice1
  port(
       KEYIN : in STD_LOGIC_VECTOR(9 downto 0);
       KEYST : out STD_LOGIC_VECTOR(9 downto 0)
  );
end component;
component perm_choice2
  port(
       KSIN : in STD_LOGIC_VECTOR(9 downto 0);
       RKEY : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component rotate1
  port(
       IDB : in STD_LOGIC_VECTOR(4 downto 0);
       ODB : out STD_LOGIC_VECTOR(4 downto 0)
  );
end component;
component rotate2
  port(
       IDB : in STD_LOGIC_VECTOR(4 downto 0);
       ODB : out STD_LOGIC_VECTOR(4 downto 0)
  );
end component;
component round_func
  port(
       INDB : in STD_LOGIC_VECTOR(3 downto 0);
       INRK : in STD_LOGIC_VECTOR(7 downto 0);
       OUDB : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component xor_4
  port(
       IDB1 : in STD_LOGIC_VECTOR(3 downto 0);
       IDB2 : in STD_LOGIC_VECTOR(3 downto 0);
       OUDB : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal BUS117 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS38 : STD_LOGIC_VECTOR(3 downto 0);
signal r1_state : STD_LOGIC_VECTOR(7 downto 0);
signal r2_state : STD_LOGIC_VECTOR(7 downto 0);
signal rk1 : STD_LOGIC_VECTOR(7 downto 0);
signal rk2 : STD_LOGIC_VECTOR(7 downto 0);
signal rk_state0 : STD_LOGIC_VECTOR(9 downto 0);
signal rk_state1 : STD_LOGIC_VECTOR(9 downto 0);
signal rk_state2 : STD_LOGIC_VECTOR(9 downto 0);
signal round_key1 : STD_LOGIC_VECTOR(7 downto 0);
signal round_key2 : STD_LOGIC_VECTOR(7 downto 0);

begin

----  Component instantiations  ----

U1 : init_perm
  port map(
       INDB => input_msg,
       OUDB => r1_state
  );

U10 : rotate2
  port map(
       IDB(4) => rk_state1(9),
       IDB(3) => rk_state1(8),
       IDB(2) => rk_state1(7),
       IDB(1) => rk_state1(6),
       IDB(0) => rk_state1(5),
       ODB(4) => rk_state2(9),
       ODB(3) => rk_state2(8),
       ODB(2) => rk_state2(7),
       ODB(1) => rk_state2(6),
       ODB(0) => rk_state2(5)
  );

U11 : rotate2
  port map(
       IDB(4) => rk_state1(4),
       IDB(3) => rk_state1(3),
       IDB(2) => rk_state1(2),
       IDB(1) => rk_state1(1),
       IDB(0) => rk_state1(0),
       ODB(4) => rk_state2(4),
       ODB(3) => rk_state2(3),
       ODB(2) => rk_state2(2),
       ODB(1) => rk_state2(1),
       ODB(0) => rk_state2(0)
  );

U12 : perm_choice2
  port map(
       KSIN => rk_state1,
       RKEY => round_key1
  );

U13 : perm_choice2
  port map(
       KSIN => rk_state2,
       RKEY => round_key2
  );

U14 : key_mux
  port map(
       IN1 => round_key1,
       IN2 => round_key2,
       MODE => cipher_mode,
       SEL => rk1
  );

U15 : key_mux
  port map(
       IN1 => round_key2,
       IN2 => round_key1,
       MODE => cipher_mode,
       SEL => rk2
  );

U2 : round_func
  port map(
       INDB(3) => r1_state(3),
       INDB(2) => r1_state(2),
       INDB(1) => r1_state(1),
       INDB(0) => r1_state(0),
       INRK => rk1,
       OUDB => BUS38
  );

U3 : xor_4
  port map(
       IDB1 => BUS38,
       IDB2(3) => r1_state(7),
       IDB2(2) => r1_state(6),
       IDB2(1) => r1_state(5),
       IDB2(0) => r1_state(4),
       OUDB(3) => r2_state(3),
       OUDB(2) => r2_state(2),
       OUDB(1) => r2_state(1),
       OUDB(0) => r2_state(0)
  );

U4 : round_func
  port map(
       INDB(3) => r2_state(3),
       INDB(2) => r2_state(2),
       INDB(1) => r2_state(1),
       INDB(0) => r2_state(0),
       INRK => rk2,
       OUDB => BUS117
  );

U5 : xor_4
  port map(
       IDB1 => BUS117,
       IDB2(3) => r1_state(3),
       IDB2(2) => r1_state(2),
       IDB2(1) => r1_state(1),
       IDB2(0) => r1_state(0),
       OUDB(3) => r2_state(7),
       OUDB(2) => r2_state(6),
       OUDB(1) => r2_state(5),
       OUDB(0) => r2_state(4)
  );

U6 : init_perm_inv
  port map(
       INDB => r2_state,
       OUDB => output_msg
  );

U7 : perm_choice1
  port map(
       KEYIN => cipher_key,
       KEYST => rk_state0
  );

U8 : rotate1
  port map(
       IDB(4) => rk_state0(9),
       IDB(3) => rk_state0(8),
       IDB(2) => rk_state0(7),
       IDB(1) => rk_state0(6),
       IDB(0) => rk_state0(5),
       ODB(4) => rk_state1(9),
       ODB(3) => rk_state1(8),
       ODB(2) => rk_state1(7),
       ODB(1) => rk_state1(6),
       ODB(0) => rk_state1(5)
  );

U9 : rotate1
  port map(
       IDB(4) => rk_state0(4),
       IDB(3) => rk_state0(3),
       IDB(2) => rk_state0(2),
       IDB(1) => rk_state0(1),
       IDB(0) => rk_state0(0),
       ODB(4) => rk_state1(4),
       ODB(3) => rk_state1(3),
       ODB(2) => rk_state1(2),
       ODB(1) => rk_state1(1),
       ODB(0) => rk_state1(0)
  );


end simple_des_full;
