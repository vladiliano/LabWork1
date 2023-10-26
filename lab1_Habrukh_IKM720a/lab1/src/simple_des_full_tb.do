# simple-DES testbench run
SetActiveLib -work
# compile round function files
comp -include "$dsn\src\rf_expand.vhd"
comp -include "$dsn\src\rf_xor_8.vhd"
comp -include "$dsn\src\rf_subst_1.vhd"
comp -include "$dsn\src\rf_subst_2.vhd"
comp -include "$dsn\src\rf_permute.vhd"
comp -include "$dsn\src\round_func.vhd"
# compile key expansion part
comp -include "$dsn\src\perm_choice1.vhd"
comp -include "$dsn\src\perm_choice2.vhd"
comp -include "$dsn\src\rotate1.vhd"
comp -include "$dsn\src\rotate2.vhd"
comp -include "$dsn\src\key_mux.vhd"
# compile main cipher components
comp -include "$dsn\src\init_perm.vhd"
comp -include "$dsn\src\init_perm_inv.vhd"
comp -include "$dsn\src\xor_4.vhd"
comp -include "$dsn\src\simple_des_full.bde"
# compile testbench
comp -include "$dsn\src\simple_des_full_tb.vhd"
# begin simulation
asim +access +r simple_des_full_tb
wave 
wave -noreg -binary input_msg
wave -noreg -binary cipher_key
wave -noreg cipher_mode
wave -noreg -binary output_msg
run 40 ns