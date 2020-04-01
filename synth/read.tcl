#------------------------------------------------------------
#
# Basic Synthesis Script (TCL format)
#                                  
# Revision History                
#   1/15/03  : Author Shane T. Gehring - from class example
#   2/09/07  : Author Zhengtao Yu      - from class example
#   12/14/07 : Author Ravi Jenkal      - updated to 180 nm & tcl
#
#------------------------------------------------------------

#---------------------------------------------------------
# Read in Verilog file and map (synthesize) onto a generic
# library.
# MAKE SURE THAT YOU CORRECT ALL WARNINGS THAT APPEAR
# during the execution of the read command are fixed 
# or understood to have no impact.
# ALSO CHECK your latch/flip-flop list for unintended 
# latches                                            
#---------------------------------------------------------

read_verilog $RTL_DIR/${modname}.v
read_verilog $RTL_DIR/controller_counter.v
read_verilog $RTL_DIR/controller_signal.v
read_verilog $RTL_DIR/controller_state_selector.v
read_verilog $RTL_DIR/controller.v
read_verilog $RTL_DIR/function_g_mux1.v
read_verilog $RTL_DIR/function_g_mux2.v
read_verilog $RTL_DIR/function_g_mux2_c1_logic.v
read_verilog $RTL_DIR/function_g_top.v
read_verilog $RTL_DIR/Matrix_adder.v
read_verilog $RTL_DIR/Matrix_multiplier.v
read_verilog $RTL_DIR/Matrix_result.v
read_verilog $RTL_DIR/Matrix_top.v
read_verilog $RTL_DIR/Tanh_multiplier.v
read_verilog $RTL_DIR/Tanh_result.v
read_verilog $RTL_DIR/Tanh_top.v
read_verilog $RTL_DIR/Tanh_x.v
read_verilog $RTL_DIR/Tanh_y.v
read_verilog $RTL_DIR/twoscomplement_9bit.v
read_verilog $RTL_DIR/twoscomplement_16bit.v
read_verilog $RTL_DIR/twoscomplement_19bit.v
