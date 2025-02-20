vlib work
vmap work work

vlog +acc -incr -dpiheader ../../sw/dpi/tb_dpi/dpiheader.h ../../sw/dpi/tb_dpi/main.cpp ../../tb/top/tb_top.sv
vlog +acc -incr ../../rtl/orig/*.v
vsim +acc -t ps -lib work -c tb_top

add wave -noupdate /tb_top/*
add wave -noupdate /tb_top/gpu/*
add wave -noupdate -r /tb_top/gpu/ia1/*

run -all
