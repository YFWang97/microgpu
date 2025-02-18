##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/rtl/vga_controller/*.v
vlog +acc -incr /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/tb/tb_vga_controller.v

# Run Simulator 
vsim +acc -t ps -lib work tb_vga_controller 
do waveformat.do   
run -all
