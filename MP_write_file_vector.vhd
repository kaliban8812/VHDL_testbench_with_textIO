library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package MP_write_file_vector is

    procedure MP_write_file_vector (
        -- signal clk_i               : in std_logic;
        file output_file           : text;
        signal std_vector_output_s : in std_logic_vector;
        constant DATA_LENGTH       : in integer
    );

end package MP_write_file_vector;

package body MP_write_file_vector is

    procedure MP_write_file_vector (
        -- signal clk_i               : in std_logic;
        file output_file           : text;
        signal std_vector_output_s : in std_logic_vector;
        constant DATA_LENGTH       : in integer
    )
    is
    variable output_line : line;
begin

    write(output_line, std_vector_output_s, left, DATA_LENGTH);
    writeline(output_file, output_line);

end procedure MP_write_file_vector;

end package body MP_write_file_vector;