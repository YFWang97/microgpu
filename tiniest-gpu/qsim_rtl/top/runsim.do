vlib work
vmap work work

vlog +acc -incr -dpiheader ../../sw/dpi/tb_dpi/dpiheader.h ../../sw/dpi/tb_dpi/main.cpp ../../tb/top/tb_top.sv
vlog +acc -incr +define+RTL_SIM ../../rtl/top/*.v
vlog +acc -incr ../../rtl/scan_chain/*.v
vlog +acc -incr ../../rtl/sram/*.v
vlog +acc -incr ../../rtl/lib/*.v
vsim +acc -t ps -lib work -c tb_top

add wave -noupdate /tb_top/*
add wave -noupdate /tb_top/top_inst/gpu/*
#add wave -noupdate -r /tb_top/top_inst/gpu/ia1/*
#add wave -noupdate /tb_top/top_inst/scan_chain_inst/*
add wave -noupdate /tb_top/top_inst/sram_wrapper_inst/*
add wave -noupdate /tb_top/top_inst/gpu/vs1/*
add wave -noupdate /tb_top/top_inst/gpu/raster1/*
add wave -noupdate /tb_top/top_inst/gpu/v/*
add wave -noupdate /tb_top/top_inst/gpu/raster1/tex0/*

run -all
