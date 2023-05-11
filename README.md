# data_verification
tb for using files for verification

If a dut recieves data, transforms it and sends forward, so one can test it by txt files with input data and reference data, what it should be after the transforming.
The dut_text_file.vhd is the main tb file.

The dut connects to a procedure MP_read_file_vector_synch.
MP_read_file_vector_synch.vhd reads std_logic_vector from file and sends it to the dut.
The dut transforms the input data to the output data and writes it to the output file by MP_Write_file_vector.vhd.
After that tb compares the output data with reference data file.

There are some additional files like do_dut_text_file.do for automatization launching it in the Modelsim and wave do for printing the datas in the wave form viewer.
This files should be changed.
