
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
create_project: 2

00:00:062

00:00:062

1356.4772
6.9652
258072
30589Z17-722h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental /home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.srcs/utils_1/imports/synth_1/top_gpu.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2�
�/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.srcs/utils_1/imports/synth_1/top_gpu.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
d
Command: %s
53*	vivadotcl23
1synth_design -top top_gpu -part xc7a35ticpg236-1LZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a35tiZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a35tiZ17-349h px� 
F
Loading part %s157*device2
xc7a35ticpg236-1LZ21-403h px� 
\
$Part: %s does not have CEAM library.966*device2
xc7a35ticpg236-1LZ21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
4Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
79335Z8-7075h px� 
�
%s*synth2�
�Starting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:04 . Memory (MB): peak = 2120.980 ; gain = 412.715 ; free physical = 24683 ; free virtual = 29470
h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
x2
wire2c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/project.v2
3348@Z8-11241h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
y2
wire2c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/project.v2
3348@Z8-11241h px� 
�
.'%s' is already implicitly declared on line %s5153*oasys2
x2
3342c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/project.v2
3608@Z8-8895h px� 
�
.'%s' is already implicitly declared on line %s5153*oasys2
y2
3342c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/project.v2
3608@Z8-8895h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
clk_502
wire2m
i/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/top_fpga.v2
228@Z8-11241h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
clk_402
wire2m
i/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/top_fpga.v2
238@Z8-11241h px� 
�
synthesizing module '%s'%s4497*oasys2	
top_gpu2
 2m
i/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/top_fpga.v2
88@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	clk_wiz_02
 2�
�/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.runs/synth_1/.Xil/Vivado-79299-Wangs-Linux/realtime/clk_wiz_0_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	clk_wiz_02
 2
02
12�
�/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.runs/synth_1/.Xil/Vivado-79299-Wangs-Linux/realtime/clk_wiz_0_stub.v2
68@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
locked2
	clk_wiz_02
instance_name2m
i/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/top_fpga.v2
198@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
instance_name2
	clk_wiz_02
52
42m
i/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/top_fpga.v2
198@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2
tt_um_pongsagon_tiniest_gpu2
 2c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/project.v2
88@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
ia2
 2^
Z/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/ia.v2
68@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

uart_top2
 2d
`/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/uart_top.v2
198@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
baud_rate_generator2
 2o
k/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/baud_rate_generator.v2
358@Z8-6157h px� 
D
%s
*synth2,
*	Parameter N bound to: 5 - type: integer 
h p
x
� 
E
%s
*synth2-
+	Parameter M bound to: 22 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
baud_rate_generator2
 2
02
12o
k/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/baud_rate_generator.v2
358@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_receiver2
 2i
e/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/uart_receiver.v2
228@Z8-6157h px� 
H
%s
*synth20
.	Parameter DBITS bound to: 8 - type: integer 
h p
x
� 
K
%s
*synth23
1	Parameter SB_TICK bound to: 16 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_receiver2
 2
02
12i
e/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/uart_receiver.v2
228@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

uart_top2
 2
02
12d
`/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/uart_top.v2
198@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ia2
 2
02
12^
Z/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/ia.v2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
vs2
 2^
Z/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/vs.v2
138@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
div2
 2_
[/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/div.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
div2
 2
02
12_
[/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/div.v2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
div__parameterized02
 2_
[/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/div.v2
68@Z8-6157h px� 
I
%s
*synth21
/	Parameter WIDTH bound to: 40 - type: integer 
h p
x
� 
I
%s
*synth21
/	Parameter FBITS bound to: 20 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
div__parameterized02
 2
02
12_
[/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/div.v2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2	
slowmpy2
 2c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/slowmpy.v2
528@Z8-6157h px� 
G
%s
*synth2/
-	Parameter LGNA bound to: 5 - type: integer 
h p
x
� 
=
%s
*synth2%
#	Parameter NA bound to: 6'b010110 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
slowmpy2
 2
02
12c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/slowmpy.v2
528@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
dot42
 2`
\/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/dot4.v2
148@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
slowmpy__parameterized02
 2c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/slowmpy.v2
528@Z8-6157h px� 
G
%s
*synth2/
-	Parameter LGNA bound to: 4 - type: integer 
h p
x
� 
<
%s
*synth2$
"	Parameter NA bound to: 5'b10000 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
slowmpy__parameterized02
 2
02
12c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/slowmpy.v2
528@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dot42
 2
02
12`
\/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/dot4.v2
148@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
vs2
 2
02
12^
Z/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/vs.v2
138@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
raster2
 2b
^/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/raster.v2
128@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
bitmap_rom_ddct2
 2k
g/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/bitmap_rom_ddct.v2
28@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
bitmap_rom_ddct2
 2
02
12k
g/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/bitmap_rom_ddct.v2
28@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
bitmap_rom_sk2
 2i
e/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/bitmap_rom_sk.v2
28@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
bitmap_rom_sk2
 2
02
12i
e/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/bitmap_rom_sk.v2
28@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
raster2
 2
02
12b
^/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/raster.v2
128@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
vga2
 2_
[/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/vga.v2
58@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
vga2
 2
02
12_
[/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/vga.v2
58@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
tt_um_pongsagon_tiniest_gpu2
 2
02
12c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/project.v2
88@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
top_gpu2
 2
02
12m
i/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/top_fpga.v2
88@Z8-6155h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
back_face_reg2b
^/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/raster.v2
978@Z8-6014h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[7]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[6]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[5]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[4]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[2]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[1]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[0]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[7]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[6]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[5]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[4]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[3]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[2]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[1]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[0]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ena2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
clk2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
%s*synth2�
�Finished RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 2245.949 ; gain = 537.684 ; free physical = 24528 ; free virtual = 29321
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 2263.762 ; gain = 555.496 ; free physical = 24528 ; free virtual = 29321
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 2263.762 ; gain = 555.496 ; free physical = 24528 ; free virtual = 29321
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Netlist sorting complete. 2
00:00:00.052
00:00:00.042

2263.7622
0.0002
245292
29322Z17-722h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.gen/sources_1/ip/clk_wiz_0/clk_wiz_0/clk_wiz_0_in_context.xdc2
instance_name	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.gen/sources_1/ip/clk_wiz_0/clk_wiz_0/clk_wiz_0_in_context.xdc2
instance_name	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2o
k/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/Basys-3-tiniest_gpu.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2o
k/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/Basys-3-tiniest_gpu.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2m
k/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/Basys-3-tiniest_gpu.xdc2
.Xil/top_gpu_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Netlist sorting complete. 2

00:00:002

00:00:002

2408.5432
0.0002
245402
29333Z17-722h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
 Constraint Validation Runtime : 2
00:00:00.012
00:00:00.012

2408.5432
0.0002
245402
29333Z17-722h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Constraint Validation : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 2408.543 ; gain = 700.277 ; free physical = 24529 ; free virtual = 29323
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Loading part: xc7a35ticpg236-1L
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 24529 ; free virtual = 29323
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 24529 ; free virtual = 29323
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
uart_receiverZ8-802h px� 
f
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
iaZ8-802h px� 
g
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
divZ8-802h px� 
w
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
div__parameterized0Z8-802h px� 
h
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
dot4Z8-802h px� 
p
3inferred FSM for state register '%s' in module '%s'802*oasys2
state_transform_reg2
vsZ8-802h px� 
o
3inferred FSM for state register '%s' in module '%s'802*oasys2
state_ei_frame_reg2
vsZ8-802h px� 
p
3inferred FSM for state register '%s' in module '%s'802*oasys2
state_pixel_reg2
rasterZ8-802h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                    idle |                               00 |                               00
h p
x
� 
y
%s
*synth2a
_                   start |                               01 |                               01
h p
x
� 
y
%s
*synth2a
_                    data |                               10 |                               10
h p
x
� 
y
%s
*synth2a
_                    stop |                               11 |                               11
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2
uart_receiverZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                                0 |                               00
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                                1 |                               01
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2
iaZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                              000 |                              000
h p
x
� 

%s
*synth2
*
h p
x
� 
y
%s
*synth2a
_                    INIT |                              001 |                              001
h p
x
� 
y
%s
*synth2a
_                    CALC |                              010 |                              010
h p
x
� 
y
%s
*synth2a
_                   ROUND |                              011 |                              011
h p
x
� 
y
%s
*synth2a
_                    SIGN |                              100 |                              100
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2
divZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                              000 |                              000
h p
x
� 

%s
*synth2
*
h p
x
� 
y
%s
*synth2a
_                    INIT |                              001 |                              001
h p
x
� 
y
%s
*synth2a
_                    CALC |                              010 |                              010
h p
x
� 
y
%s
*synth2a
_                   ROUND |                              011 |                              011
h p
x
� 
y
%s
*synth2a
_                    SIGN |                              100 |                              100
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2
div__parameterized0Z8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                              000 |                              000
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                              001 |                              001
h p
x
� 
y
%s
*synth2a
_                 iSTATE1 |                              010 |                              010
h p
x
� 
y
%s
*synth2a
_                 iSTATE2 |                              011 |                              011
h p
x
� 
y
%s
*synth2a
_                 iSTATE3 |                              100 |                              100
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2
dot4Z8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                iSTATE18 |                           000000 |                           000000
h p
x
� 
y
%s
*synth2a
_                iSTATE15 |                           000001 |                           000001
h p
x
� 
y
%s
*synth2a
_                iSTATE11 |                           000010 |                           000010
h p
x
� 
y
%s
*synth2a
_                 iSTATE9 |                           000011 |                           000011
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                           000100 |                           000100
h p
x
� 
y
%s
*synth2a
_                iSTATE31 |                           000101 |                           000101
h p
x
� 
y
%s
*synth2a
_                iSTATE25 |                           000110 |                           000110
h p
x
� 
y
%s
*synth2a
_                iSTATE22 |                           000111 |                           000111
h p
x
� 
y
%s
*synth2a
_                iSTATE29 |                           001000 |                           001000
h p
x
� 
y
%s
*synth2a
_                iSTATE27 |                           001001 |                           001001
h p
x
� 
y
%s
*synth2a
_                iSTATE20 |                           001010 |                           001010
h p
x
� 
y
%s
*synth2a
_                iSTATE17 |                           001011 |                           001011
h p
x
� 
y
%s
*synth2a
_                 iSTATE6 |                           001100 |                           001100
h p
x
� 
y
%s
*synth2a
_                 iSTATE4 |                           001101 |                           001101
h p
x
� 
y
%s
*synth2a
_                 iSTATE1 |                           001110 |                           001110
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                           001111 |                           001111
h p
x
� 
y
%s
*synth2a
_                iSTATE12 |                           010000 |                           010000
h p
x
� 
y
%s
*synth2a
_                iSTATE10 |                           010001 |                           010001
h p
x
� 
y
%s
*synth2a
_                 iSTATE8 |                           010010 |                           010010
h p
x
� 
y
%s
*synth2a
_                 iSTATE7 |                           010011 |                           010011
h p
x
� 
y
%s
*synth2a
_                iSTATE26 |                           010100 |                           010100
h p
x
� 
y
%s
*synth2a
_                iSTATE24 |                           010101 |                           010101
h p
x
� 
y
%s
*synth2a
_                iSTATE19 |                           010110 |                           010110
h p
x
� 
y
%s
*synth2a
_                iSTATE16 |                           010111 |                           010111
h p
x
� 
y
%s
*synth2a
_                iSTATE23 |                           011000 |                           011000
h p
x
� 
y
%s
*synth2a
_                iSTATE21 |                           011001 |                           011001
h p
x
� 
y
%s
*synth2a
_                iSTATE14 |                           011010 |                           011010
h p
x
� 
y
%s
*synth2a
_                iSTATE13 |                           011011 |                           011011
h p
x
� 
y
%s
*synth2a
_                 iSTATE3 |                           011100 |                           011100
h p
x
� 
y
%s
*synth2a
_                 iSTATE2 |                           011101 |                           011101
h p
x
� 
y
%s
*synth2a
_                iSTATE30 |                           011110 |                           011110
h p
x
� 
y
%s
*synth2a
_                iSTATE28 |                           011111 |                           011111
h p
x
� 
y
%s
*synth2a
_                 iSTATE5 |                           100000 |                           100000
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
state_transform_reg2

sequential2
vsZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
%s
*synth2t
r                 iSTATE1 | 000000000000000000000000000000000000000000000000001 |                           000000
h p
x
� 
�
%s
*synth2t
r                 iSTATE0 | 000000000000000000000000000000000000000000000000010 |                           000001
h p
x
� 
�
%s
*synth2t
r                  iSTATE | 000000000000000000000000000000000000000000000000100 |                           000010
h p
x
� 
�
%s
*synth2t
r                iSTATE49 | 000000000000000000000000000000000000000000000001000 |                           000011
h p
x
� 
�
%s
*synth2t
r                iSTATE33 | 000000000000000000000000000000000000000000000010000 |                           000100
h p
x
� 
�
%s
*synth2t
r                iSTATE31 | 000000000000000000000000000000000000000000000100000 |                           000101
h p
x
� 
�
%s
*synth2t
r                iSTATE29 | 000000000000000000000000000000000000000000001000000 |                           000110
h p
x
� 
�
%s
*synth2t
r                iSTATE26 | 000000000000000000000000000000000000000000010000000 |                           000111
h p
x
� 
�
%s
*synth2t
r                iSTATE32 | 000000000000000000000000000000000000000000100000000 |                           001000
h p
x
� 
�
%s
*synth2t
r                iSTATE30 | 000000000000000000000000000000000000000001000000000 |                           001001
h p
x
� 
�
%s
*synth2t
r                iSTATE27 | 000000000000000000000000000000000000000010000000000 |                           001010
h p
x
� 
�
%s
*synth2t
r                iSTATE24 | 000000000000000000000000000000000000000100000000000 |                           001011
h p
x
� 
�
%s
*synth2t
r                iSTATE17 | 000000000000000000000000000000000000001000000000000 |                           001100
h p
x
� 
�
%s
*synth2t
r                iSTATE16 | 000000000000000000000000000000000000010000000000000 |                           001101
h p
x
� 
�
%s
*synth2t
r                iSTATE15 | 000000000000000000000000000000000000100000000000000 |                           001110
h p
x
� 
�
%s
*synth2t
r                iSTATE12 | 000000000000000000000000000000000001000000000000000 |                           001111
h p
x
� 
�
%s
*synth2t
r                iSTATE28 | 000000000000000000000000000000000010000000000000000 |                           010000
h p
x
� 
�
%s
*synth2t
r                iSTATE25 | 000000000000000000000000000000000100000000000000000 |                           010001
h p
x
� 
�
%s
*synth2t
r                iSTATE21 | 000000000000000000000000000000001000000000000000000 |                           010010
h p
x
� 
�
%s
*synth2t
r                iSTATE20 | 000000000000000000000000000000010000000000000000000 |                           010011
h p
x
� 
�
%s
*synth2t
r                iSTATE14 | 000000000000000000000000000000100000000000000000000 |                           010100
h p
x
� 
�
%s
*synth2t
r                iSTATE10 | 000000000000000000000000000001000000000000000000000 |                           010101
h p
x
� 
�
%s
*synth2t
r                 iSTATE7 | 000000000000000000000000000010000000000000000000000 |                           010110
h p
x
� 
�
%s
*synth2t
r                 iSTATE4 | 000000000000000000000000000100000000000000000000000 |                           010111
h p
x
� 
�
%s
*synth2t
r                iSTATE11 | 000000000000000000000000001000000000000000000000000 |                           011000
h p
x
� 
�
%s
*synth2t
r                 iSTATE8 | 000000000000000000000000010000000000000000000000000 |                           011001
h p
x
� 
�
%s
*synth2t
r                 iSTATE5 | 000000000000000000000000100000000000000000000000000 |                           011010
h p
x
� 
�
%s
*synth2t
r                 iSTATE2 | 000000000000000000000001000000000000000000000000000 |                           011011
h p
x
� 
�
%s
*synth2t
r                iSTATE47 | 000000000000000000000010000000000000000000000000000 |                           011100
h p
x
� 
�
%s
*synth2t
r                iSTATE44 | 000000000000000000000100000000000000000000000000000 |                           011101
h p
x
� 
�
%s
*synth2t
r                iSTATE40 | 000000000000000000001000000000000000000000000000000 |                           011110
h p
x
� 
�
%s
*synth2t
r                iSTATE36 | 000000000000000000010000000000000000000000000000000 |                           011111
h p
x
� 
�
%s
*synth2t
r                iSTATE13 | 000000000000000000100000000000000000000000000000000 |                           100000
h p
x
� 
�
%s
*synth2t
r                 iSTATE9 | 000000000000000001000000000000000000000000000000000 |                           100001
h p
x
� 
�
%s
*synth2t
r                 iSTATE6 | 000000000000000010000000000000000000000000000000000 |                           100010
h p
x
� 
�
%s
*synth2t
r                 iSTATE3 | 000000000000000100000000000000000000000000000000000 |                           100011
h p
x
� 
�
%s
*synth2t
r                iSTATE48 | 000000000000001000000000000000000000000000000000000 |                           100100
h p
x
� 
�
%s
*synth2t
r                iSTATE46 | 000000000000010000000000000000000000000000000000000 |                           100101
h p
x
� 
�
%s
*synth2t
r                iSTATE42 | 000000000000100000000000000000000000000000000000000 |                           100110
h p
x
� 
�
%s
*synth2t
r                iSTATE39 | 000000000001000000000000000000000000000000000000000 |                           100111
h p
x
� 
�
%s
*synth2t
r                iSTATE45 | 000000000010000000000000000000000000000000000000000 |                           101000
h p
x
� 
�
%s
*synth2t
r                iSTATE43 | 000000000100000000000000000000000000000000000000000 |                           101001
h p
x
� 
�
%s
*synth2t
r                iSTATE38 | 000000001000000000000000000000000000000000000000000 |                           101010
h p
x
� 
�
%s
*synth2t
r                iSTATE35 | 000000010000000000000000000000000000000000000000000 |                           101011
h p
x
� 
�
%s
*synth2t
r                iSTATE23 | 000000100000000000000000000000000000000000000000000 |                           101100
h p
x
� 
�
%s
*synth2t
r                iSTATE22 | 000001000000000000000000000000000000000000000000000 |                           101101
h p
x
� 
�
%s
*synth2t
r                iSTATE19 | 000010000000000000000000000000000000000000000000000 |                           101110
h p
x
� 
�
%s
*synth2t
r                iSTATE18 | 000100000000000000000000000000000000000000000000000 |                           101111
h p
x
� 
�
%s
*synth2t
r                iSTATE41 | 001000000000000000000000000000000000000000000000000 |                           110000
h p
x
� 
�
%s
*synth2t
r                iSTATE37 | 010000000000000000000000000000000000000000000000000 |                           110001
h p
x
� 
�
%s
*synth2t
r                iSTATE34 | 100000000000000000000000000000000000000000000000000 |                           110010
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
state_ei_frame_reg2	
one-hot2
vsZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                                0 |                               01
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                                1 |                               00
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
state_pixel_reg2

sequential2
rasterZ8-3354h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:13 ; elapsed = 00:00:14 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 24527 ; free virtual = 29322
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   44 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   39 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input   39 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   31 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input   31 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   23 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   22 Bit       Adders := 4     
h p
x
� 
F
%s
*synth2.
,	   3 Input   22 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   3 Input   20 Bit       Adders := 24    
h p
x
� 
F
%s
*synth2.
,	   2 Input   20 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   4 Input   20 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input   17 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   16 Bit       Adders := 13    
h p
x
� 
F
%s
*synth2.
,	   3 Input   16 Bit       Adders := 4     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit       Adders := 2     
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   2 Input      1 Bit         XORs := 2     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               44 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               40 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	               39 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	               32 Bit    Registers := 6     
h p
x
� 
H
%s
*synth20
.	               31 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	               22 Bit    Registers := 22    
h p
x
� 
H
%s
*synth20
.	               20 Bit    Registers := 38    
h p
x
� 
H
%s
*synth20
.	               16 Bit    Registers := 56    
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                7 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                6 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                2 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 36    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   40 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   5 Input   40 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input   39 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   5 Input   39 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   5 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  33 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input   31 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   5 Input   31 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   23 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   22 Bit        Muxes := 9     
h p
x
� 
F
%s
*synth2.
,	  51 Input   22 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input   20 Bit        Muxes := 26    
h p
x
� 
F
%s
*synth2.
,	  51 Input   20 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   17 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   16 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   5 Input   16 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	  33 Input   16 Bit        Muxes := 17    
h p
x
� 
F
%s
*synth2.
,	  14 Input   16 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	  14 Input   10 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    7 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	  33 Input    6 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    6 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit        Muxes := 12    
h p
x
� 
F
%s
*synth2.
,	   3 Input    6 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   4 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   5 Input    3 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   4 Input    2 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 49    
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   5 Input    1 Bit        Muxes := 36    
h p
x
� 
F
%s
*synth2.
,	  33 Input    1 Bit        Muxes := 23    
h p
x
� 
F
%s
*synth2.
,	  51 Input    1 Bit        Muxes := 23    
h p
x
� 
F
%s
*synth2.
,	  62 Input    1 Bit        Muxes := 2     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
p
%s
*synth2X
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2
mul2/o_p_reg2
322
242c
_/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/rtl/clk_20MHz/slowmpy.v2
1478@Z8-3936h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[7]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[6]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[5]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[4]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[2]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[1]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ui_in[0]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[7]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[6]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[5]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[4]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[3]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[2]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[1]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
	uio_in[0]2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ena2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
clk2
tt_um_pongsagon_tiniest_gpuZ8-7129h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:26 ; elapsed = 00:00:26 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23779 ; free virtual = 28592
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
;
%s*synth2#
!
ROM: Preliminary Mapping Report
h px� 
[
%s*synth2C
A+----------------+------------+---------------+----------------+
h px� 
\
%s*synth2D
B|Module Name     | RTL Object | Depth x Width | Implemented As | 
h px� 
[
%s*synth2C
A+----------------+------------+---------------+----------------+
h px� 
\
%s*synth2D
B|bitmap_rom_ddct | mem        | 2048x8        | LUT            | 
h px� 
\
%s*synth2D
B|bitmap_rom_sk   | mem        | 2048x8        | LUT            | 
h px� 
\
%s*synth2D
B+----------------+------------+---------------+----------------+

h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:31 ; elapsed = 00:00:32 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23621 ; free virtual = 28440
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Timing Optimization : Time (s): cpu = 00:00:32 ; elapsed = 00:00:33 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23594 ; free virtual = 28413
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Technology Mapping : Time (s): cpu = 00:00:34 ; elapsed = 00:00:34 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23531 ; free virtual = 28351
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished IO Insertion : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23395 ; free virtual = 28214
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23395 ; free virtual = 28214
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23379 ; free virtual = 28198
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23379 ; free virtual = 28198
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23379 ; free virtual = 28198
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23379 ; free virtual = 28198
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|      |BlackBox name |Instances |
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|1     |clk_wiz_0     |         1|
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
3
%s*synth2
+------+--------+------+
h px� 
3
%s*synth2
|      |Cell    |Count |
h px� 
3
%s*synth2
+------+--------+------+
h px� 
3
%s*synth2
|1     |clk_wiz |     1|
h px� 
3
%s*synth2
|2     |CARRY4  |   328|
h px� 
3
%s*synth2
|3     |LUT1    |   107|
h px� 
3
%s*synth2
|4     |LUT2    |  1013|
h px� 
3
%s*synth2
|5     |LUT3    |   706|
h px� 
3
%s*synth2
|6     |LUT4    |   522|
h px� 
3
%s*synth2
|7     |LUT5    |   350|
h px� 
3
%s*synth2
|8     |LUT6    |  1176|
h px� 
3
%s*synth2
|9     |MUXF7   |    96|
h px� 
3
%s*synth2
|10    |MUXF8   |    27|
h px� 
3
%s*synth2
|11    |FDRE    |  2513|
h px� 
3
%s*synth2
|12    |FDSE    |    11|
h px� 
3
%s*synth2
|13    |IBUF    |     2|
h px� 
3
%s*synth2
|14    |OBUF    |    24|
h px� 
3
%s*synth2
+------+--------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 2416.547 ; gain = 708.281 ; free physical = 23379 ; free virtual = 28198
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
a
%s
*synth2I
GSynthesis finished with 0 errors, 0 critical warnings and 19 warnings.
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Runtime : Time (s): cpu = 00:00:36 ; elapsed = 00:00:37 . Memory (MB): peak = 2416.547 ; gain = 563.500 ; free physical = 23376 ; free virtual = 28191
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:38 ; elapsed = 00:00:39 . Memory (MB): peak = 2416.555 ; gain = 708.281 ; free physical = 23376 ; free virtual = 28191
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Netlist sorting complete. 2
00:00:00.032
00:00:00.042

2416.5552
0.0002
237252
28541Z17-722h px� 
U
-Analyzing %s Unisim elements for replacement
17*netlist2
451Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Netlist sorting complete. 2

00:00:002

00:00:002

2472.5742
0.0002
237272
28544Z17-722h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

b74b94bcZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
762
412
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
synth_design: 2

00:00:452

00:00:432

2472.5742

1098.2852
237272
28544Z17-722h px� 
�
%s peak %s Memory [%s] %s12246*common2
synth_design2

Physical2
PSS2=
;(MB): overall = 1955.380; main = 1541.184; forked = 439.205Z17-2834h px� 
�
%s peak %s Memory [%s] %s12246*common2
synth_design2	
Virtual2
VSS2>
<(MB): overall = 3522.488; main = 2472.578; forked = 1105.938Z17-2834h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Write ShapeDB Complete: 2
00:00:00.022
00:00:00.012

2496.5862
0.0002
237272
28544Z17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2�
�/home/yangfan/Desktop/Columbia/2025Spring/Projects/microgpu/tiniest-gpu/fpga/xilinx/full_20MHz/full_20MHz.runs/synth_1/top_gpu.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2Y
Wreport_utilization -file top_gpu_utilization_synth.rpt -pb top_gpu_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Sat Feb  8 01:30:54 2025Z17-206h px� 


End Record