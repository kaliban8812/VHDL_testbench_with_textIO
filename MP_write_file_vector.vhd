library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package MP_write_file_vector is

    procedure MP_write_file_vector (
        signal clk_i               : in std_logic;
        signal stb_i               : in std_logic;
        constant FILE_NAME         : string;
        signal std_vector_output_s : in std_logic_vector;
        constant DATA_LENGTH       : in integer
    );

end package MP_write_file_vector;

package body MP_write_file_vector is

    procedure MP_write_file_vector (
        signal clk_i               : in std_logic;
        signal stb_i               : in std_logic;
        constant FILE_NAME         : string;
        signal std_vector_output_s : in std_logic_vector;
        constant DATA_LENGTH       : in integer
    )
    is
    file output_file     : text;
    variable output_line : line;
begin
    report "[INFO] START WRITING FILE IN SYNCH MODE";
    file_open(output_file, FILE_NAME, write_mode);
    wait until rising_edge(clk_i);
    while (stb_i = '1') loop
        write(output_line, std_vector_output_s, left, DATA_LENGTH);
        writeline(output_file, output_line);
        wait until rising_edge(clk_i);
    end loop;
    file_close(output_file);
    report "[INFO] STOP WRITING FILE IN SYNCH MODE";
end procedure MP_write_file_vector;

--     procedure MP_write_file_vector (
--         -- signal clk_i               : in std_logic;
--         -- file output_file           : text;
--         constant FILE_NAME         : string;
--         signal std_vector_output_s : in std_logic_vector;
--         constant DATA_LENGTH       : in integer
--     )
--     is
--     file output_file     : text;
--     variable output_line : line;
-- begin
--     file_open(output_file, FILE_NAME, append_mode);
--     write(output_line, std_vector_output_s, left, DATA_LENGTH);
--     writeline(output_file, output_line);
--     file_close(output_file);

-- end procedure MP_write_file_vector;

end package body MP_write_file_vector;