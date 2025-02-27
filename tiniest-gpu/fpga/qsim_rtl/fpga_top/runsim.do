##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/rtl/vga_controller/vga.v
vlog +acc -incr /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/rtl/vga_controller/vga_controller.v
vlog +acc -incr /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/*.v
vlog +acc -incr /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/tb/tb_fpga_top.v

# Run Simulator 
vsim +acc -t ps -lib work tb_fpga_top
do waveformat.do   
run -all
