vlib work
vmap work work

vlog +acc -incr -dpiheader ../../sw/dpi/tb_dpi/dpiheader.h ../../sw/dpi/tb_dpi/main.cpp ../../tb/orig/tb_top.sv
vlog +acc -incr +define+RTL_SIM ../../rtl/orig/*.v
vlog +acc -incr ../../rtl/scan_chain/*.v
vlog +acc -incr ../../rtl/sram/*.v
vlog +acc -incr ../../rtl/lib/*.v
vsim +acc -t ps -lib work -c tb_top

add wave -noupdate /tb_top/*
add wave -noupdate /tb_top/gpu/*
add wave -noupdate -r /tb_top/gpu/ia1/*
add wave -noupdate /tb_top/gpu/scan_chain_inst/*
add wave -noupdate /tb_top/gpu/sram_wrapper_inst/*
add wave -noupdate /tb_top/gpu/raster1/*
add wave -noupdate /tb_top/gpu/raster1/tex0/*

run -all
