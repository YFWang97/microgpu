##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/clk_20MHz/*.v
vlog +acc -incr ../../tb/tb_top.v

# Run Simulator 
vsim +acc -t ps -lib work tb_top 
do waveformat.do   
run -all
