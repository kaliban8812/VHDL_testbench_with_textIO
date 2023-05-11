-- compare two files
-- files should contain the std_logic_vectors with length DATA_LENGTH

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package MP_compare_files is

    procedure MP_compare_files (
        constant FILE_NAME_0 : string;
        constant FILE_NAME_1 : string;
        constant DATA_LENGTH : integer
    );

end package MP_compare_files;

package body MP_compare_files is

    procedure MP_compare_files (
        constant FILE_NAME_0 : string;
        constant FILE_NAME_1 : string;
        constant DATA_LENGTH : integer
    )
    is
    file file_0           : text;
    file file_1           : text;
    variable input_line_0 : line;
    variable input_line_1 : line;
    variable vector_0     : std_logic_vector(DATA_LENGTH - 1 downto 0);
    variable vector_1     : std_logic_vector(DATA_LENGTH - 1 downto 0);
    variable good_v       : boolean;
begin
    report "[INFO] START COMPARE FILES";

    file_open(file_0, FILE_NAME_0, read_mode);
    file_open(file_1, FILE_NAME_1, read_mode);

    while (true) loop
        if endfile(file_0) and endfile(file_1) then
            report "[INFO] COMPARING IS PASSED";
            exit;
        elsif endfile(file_0) and not endfile(file_1) then
            report "[ERROR] : file_1 is longer" severity failure;
        elsif not endfile(file_0) and endfile(file_1) then
            report "[ERROR] : file_0 is longer" severity failure;
        end if;
        readline(file_0, input_line_0);
        readline(file_1, input_line_1);
        read(input_line_0, vector_0, good_v);
        if (not good_v) then
            report "[ERROR] : error of the variable" severity failure;
        end if;
        read(input_line_1, vector_1, good_v);
        if (not good_v) then
            report "[ERROR] : error of the variable" severity failure;
        end if;
        report "[COMPARE] = " & integer'image(to_integer(unsigned(vector_0))) & " = " & integer'image(to_integer(unsigned(vector_1)));
        if (vector_0 /= vector_1) then
            report "[ERROR] : error of comparing" severity failure;
        end if;
    end loop;
    file_close(file_0);
    file_close(file_1);
    report "[INFO] STOP COMPARE FILES";
end procedure MP_compare_files;

end package body MP_compare_files;