#start.do
#此脚本文件存放于工程文件夹下的tb子文件夹

transcript on
if {[file exists wql_work]} {
	vdel -lib wql_work -all
}
#上面的意思是如果已有 wql_work 这个库，就把它全部删了
#新建 wql_work 库,这是modelsim必须要做的事，作用就是把自己的源代码编译进这个库中。

vlib wql_work  

#将wql_work映射到 work 中，因为操作的时候modelsim是默认对work进行的，
#所以如果不这样modelsim就找不到这个库。

vmap work wql_work

#编译源代码和测试文件，这样写就是默认编译进了 wql_work 中了   
#编译testbench文件					       	
vlog    water_led_tb.v

#编译 	设计文件（位于工程文件夹下的rtl子文件夹）					       	 
vlog ../src/water_led.v
#vlog ../src/*.v
#vlog ../src/*.v

#编译IP文件


#指定仿真顶层模块	
vsim -novopt work.water_led_tb 

#添加信号到波形窗 							  
#add wave -position insertpoint sim:/water_led_tb//*

#下面将信号显示调整为十进制无符号形式
radix unsigned

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/water_led_tb/water_led_inst/Group1 -group {Region: sim:/water_led_tb/water_led_inst} /water_led_tb/water_led_inst/clk
add wave -noupdate -expand -label sim:/water_led_tb/water_led_inst/Group1 -group {Region: sim:/water_led_tb/water_led_inst} /water_led_tb/water_led_inst/rst_n
add wave -noupdate -expand -label sim:/water_led_tb/water_led_inst/Group1 -group {Region: sim:/water_led_tb/water_led_inst} -radix binary /water_led_tb/water_led_inst/led_out
add wave -noupdate -expand -label sim:/water_led_tb/water_led_inst/Group1 -group {Region: sim:/water_led_tb/water_led_inst} /water_led_tb/water_led_inst/cnt
add wave -noupdate -expand -label sim:/water_led_tb/water_led_inst/Group1 -group {Region: sim:/water_led_tb/water_led_inst} /water_led_tb/water_led_inst/cnt_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {276 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {5121 ns}


run -all