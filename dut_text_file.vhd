-- do D:/Vova/Prog/projects/data_verification/do_dut_text_file.do
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.MP_package.all;
use work.MP_read_file_vector_synch.all;
use work.MP_write_file_vector.all;
use work.MP_compare_files.all;

entity dut_text_file is
end entity dut_text_file;

architecture dut_text_file_rtl of dut_text_file is

    signal clk_i     : std_logic := '0';
    signal rst_i     : std_logic := '1';
    constant CLK_PER : time      := 10 ns;

    constant LENGTH_IN  : integer := 8;
    constant LENGTH_OUT : integer := 10;
    signal stb_i        : std_logic;                                -- stb from file reading process, '1' when the vector from the file is ready.
    signal stb_o        : std_logic;                                -- stb from dut, when the data is ready stb is '1';
    signal data_file    : std_logic_vector(LENGTH_IN - 1 downto 0); -- data from file
    signal data_o       : std_logic_vector(LENGTH_OUT - 1 downto 0); -- data from dut;

    constant FILE_NAME_DATA_IN  : string := "D:/Vova/Prog/projects/data_verification/test_data_i.txt";
    constant FILE_NAME_DATA_OUT : string := "D:/Vova/Prog/projects/data_verification/test_data_o.txt";
    constant FILE_NAME_DATA_REF : string := "D:/Vova/Prog/projects/data_verification/test_data_r.txt";

begin

    clk_i <= not clk_i after CLK_PER / 2;
    -- it reads data from file and sends it to the DUT
    -- waiting 100 clk for resolvind dut outputs and writing output file
    -- make a comparing output file and reference file
    MAIN_PROC : process
    begin
        MP_start_reset(10 * CLK_PER, rst_i);
        MP_read_file_vector_synch(clk_i, FILE_NAME_DATA_IN, data_file, stb_i);
        wait for 100 * CLK_PER;
        MP_compare_files(FILE_NAME_DATA_REF, FILE_NAME_DATA_OUT, LENGTH_OUT);
        MP_end_simulation (10 * CLK_PER);
    end process MAIN_PROC;
    -- write data to the output file, ckl and stb is needed
    WRITE_DATA_FROM_CONVERTER : process
    begin
        wait until stb_o = '1';
        MP_write_file_vector(clk_i, stb_o, FILE_NAME_DATA_OUT, data_o, LENGTH_OUT);
        wait;
    end process;

    -- in this dut the in and out buses have the same length.
    dut : entity work.data_converter(data_converter_rtl)
        generic map(
            DATA_LENGTH_IN => LENGTH_IN,
            DATA_LENGTH_OUT => LENGTH_OUT
        )
        port map
        (
            clk_i  => clk_i,
            rst_i  => rst_i,
            stb_i  => stb_i,
            data_i => data_file,
            stb_o  => stb_o,
            data_o => data_o
        );

end dut_text_file_rtl;