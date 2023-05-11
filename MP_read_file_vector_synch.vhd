library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package MP_read_file_vector_synch is

    procedure MP_read_file_vector_synch (
        signal clk_i              : in std_logic;
        constant FILE_NAME        : string;
        signal std_vector_input_s : out std_logic_vector;
        signal stb_o              : out std_logic
    );

end package MP_read_file_vector_synch;

package body MP_read_file_vector_synch is

procedure MP_read_file_vector_synch (
    signal clk_i              : in std_logic;
    constant FILE_NAME        : string;
    signal std_vector_input_s : out std_logic_vector;
    signal stb_o              : out std_logic
)
is
    file input_file             : text;
    variable input_line         : line;
    variable std_vector_input_v : std_logic_vector(std_vector_input_s'range);
    variable good_v             : boolean;
begin
    report "[INFO] START READING FILE IN SYNCH MODE";
    stb_o <= '0';
    file_open(input_file, FILE_NAME, read_mode);
    while (not endfile(input_file)) loop
        wait until rising_edge(clk_i);
        readline(input_file, input_line);
        read(input_line, std_vector_input_v, good_v);
        if (not good_v) then
            report "[ERROR] : error of the variable" severity failure;
        end if;
        std_vector_input_s <= std_vector_input_v;
        stb_o <= '1';
    end loop;
    file_close(input_file);
    wait until rising_edge(clk_i);
    stb_o <= '0';
    report "[INFO] STOP READING FILE IN SYNCH MODE";
end procedure MP_read_file_vector_synch;

end package body MP_read_file_vector_synch;