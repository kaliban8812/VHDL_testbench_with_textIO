onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dut_text_file/clk_i
add wave -noupdate /dut_text_file/rst_i
add wave -noupdate -radix unsigned /dut_text_file/std_vector_input_s
add wave -noupdate /dut_text_file/stb_i
add wave -noupdate /dut_text_file/stb_o
add wave -noupdate -radix unsigned /dut_text_file/data_o
add wave -noupdate /dut_text_file/start_compare
add wave -noupdate /dut_text_file/data_reference
add wave -noupdate /dut_text_file/data_transformed
add wave -noupdate /dut_text_file/pass_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9320 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {404250 ps}