library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package MP_read_file_vector is

    procedure MP_read_file_vector (
        file input_file           : text;
        signal std_vector_input_s : out std_logic_vector
    );

    procedure MP_read_file_vector_synch (
        signal clk_i              : in std_logic;
        file input_file           : text;
        signal std_vector_input_s : out std_logic_vector;
        signal stb_o              : out std_logic
    );

end package MP_read_file_vector;

package body MP_read_file_vector is

    procedure MP_read_file_vector (
        file input_file           : text;
        signal std_vector_input_s : out std_logic_vector
    )
    is
    variable input_line         : line;
    variable std_vector_input_v : std_logic_vector(std_vector_input_s'range);--(8 - 1 downto 0);
    variable good_v             : boolean;
begin
    if (not endfile(input_file)) then
        readline(input_file, input_line); -- Read a row from the text file
        read(input_line, std_vector_input_v, good_v);
        std_vector_input_s <= std_vector_input_v;
        if (not good_v) then
            report "[ERROR] : error of the variable" severity failure;
        end if;
    end if;
end procedure MP_read_file_vector;

procedure MP_read_file_vector_synch (
    signal clk_i              : in std_logic;
    file input_file           : text;
    signal std_vector_input_s : out std_logic_vector;
    signal stb_o              : out std_logic
)
is
variable input_line         : line;
variable std_vector_input_v : std_logic_vector(std_vector_input_s'range);--(8 - 1 downto 0);
variable good_v             : boolean;
begin
stb_o <= '0';
while (not endfile(input_file)) loop
    wait until rising_edge(clk_i);
    MP_read_file_vector(input_file, std_vector_input_s);
    stb_o <= '1';
end loop;
wait until rising_edge(clk_i);
stb_o <= '0';
end procedure MP_read_file_vector_synch;

end package body MP_read_file_vector;