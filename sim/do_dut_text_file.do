#if we don't quit from simulation we can't change the directoru
quit -sim
vdel -all -lib work
# get a path of the script
set SCRIPT_DIR [file dirname [info script]]
#change directory by path of the script
cd $SCRIPT_DIR
#create a library work
vlib work

vcom -2008 -work work ../package/*.vhd
vcom -2008 -work work ../src/*.vhd

vsim work.dut_text_file
do wave.do

run -all
wave zoom full
  