onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dut_text_file/clk_i
add wave -noupdate /dut_text_file/rst_i
add wave -noupdate /dut_text_file/stb_i
add wave -noupdate /dut_text_file/stb_o
add wave -noupdate -radix unsigned /dut_text_file/data_file
add wave -noupdate -radix unsigned -childformat {{/dut_text_file/data_o(7) -radix unsigned} {/dut_text_file/data_o(6) -radix unsigned} {/dut_text_file/data_o(5) -radix unsigned} {/dut_text_file/data_o(4) -radix unsigned} {/dut_text_file/data_o(3) -radix unsigned} {/dut_text_file/data_o(2) -radix unsigned} {/dut_text_file/data_o(1) -radix unsigned} {/dut_text_file/data_o(0) -radix unsigned}} -subitemconfig {/dut_text_file/data_o(7) {-radix unsigned} /dut_text_file/data_o(6) {-radix unsigned} /dut_text_file/data_o(5) {-radix unsigned} /dut_text_file/data_o(4) {-radix unsigned} /dut_text_file/data_o(3) {-radix unsigned} /dut_text_file/data_o(2) {-radix unsigned} /dut_text_file/data_o(1) {-radix unsigned} /dut_text_file/data_o(0) {-radix unsigned}} /dut_text_file/data_o
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
WaveRestoreZoom {81748 ps} {338464 ps}
