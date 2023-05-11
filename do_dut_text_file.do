vlib work
vcom -2008 -work work D:/Vova/Prog/projects/data_verification/MP_package.vhd
vcom -2008 -work work D:/Vova/Prog/projects/data_verification/MP_read_file_vector_synch.vhd
vcom -2008 -work work D:/Vova/Prog/projects/data_verification/MP_write_file_vector.vhd
vcom -2008 -work work D:/Vova/Prog/projects/data_verification/data_converter.vhd
vcom -2008 -work work D:/Vova/Prog/projects/data_verification/dut_text_file.vhd

vsim work.dut_text_file
do D:/Vova/Prog/projects/data_verification/wave.do

run -all
wave zoom full

 
  