-- do D:/Vova/Prog/projects/data_verification/do_dut_text_file.do
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.MP_package.all;
use work.MP_read_file_vector_synch.all;
use work.MP_write_file_vector.all;

entity dut_text_file is
end entity dut_text_file;

architecture dut_text_file_rtl of dut_text_file is

    signal clk_i     : std_logic := '0';
    signal rst_i     : std_logic := '1';
    constant CLK_PER : time      := 10 ns;

    constant DATA_LENGTH      : integer := 8;
    signal std_vector_input_s : std_logic_vector(DATA_LENGTH - 1 downto 0);

    signal stb_i  : std_logic;
    signal stb_o  : std_logic;
    signal data_o : std_logic_vector(DATA_LENGTH - 1 downto 0);

    constant FILE_NAME_DATA_IN  : string := "D:/Vova/Prog/projects/data_verification/test_data_i.txt";
    constant FILE_NAME_DATA_OUT : string := "D:/Vova/Prog/projects/data_verification/test_data_o.txt";
    constant FILE_NAME_DATA_REF : string := "D:/Vova/Prog/projects/data_verification/test_data_r.txt";
    -- file data_in                : file;
    -- file data_out               : file;
    -- file data_ref               : file;

    signal start_compare    : boolean := false;
    signal pass_flag        : boolean := false;
    signal data_reference   : std_logic_vector(DATA_LENGTH - 1 downto 0);
    signal data_transformed : std_logic_vector(DATA_LENGTH - 1 downto 0);

begin

    clk_i <= not clk_i after CLK_PER / 2;

    READ_DATA_FROM_FILE_PROC : process
        -- file input_file : text is in "D:/Vova/Prog/projects/data_verification/test_data_i.txt";
    begin
        MP_start_reset(10 * CLK_PER, rst_i);

        MP_read_file_vector_synch(clk_i, FILE_NAME_DATA_IN, std_vector_input_s, stb_i);
        -- file_close(input_file);
        -- start_compare <= true;
        MP_end_simulation (10 * CLK_PER);
    end process READ_DATA_FROM_FILE_PROC;

    -- COMPARE_DATA_PROC : process
    --     file file_r : text is in "D:/Vova/Prog/projects/data_verification/test_data_reference.txt";
    --     file file_t : text is in "D:/Vova/Prog/projects/data_verification/test_data_o.txt";
    -- begin
    --     if start_compare then
    --         while ((not endfile(file_r)) or (not endfile(file_t))) loop
    --             MP_read_file_vector(file_r, data_reference);
    --             MP_read_file_vector(file_t, data_transformed);
    --             if data_reference = data_transformed then
    --                 pass_flag <= true;
    --             else
    --                 pass_flag <= false;
    --                 report "ERROR";
    --             end if;
    --             wait for CLK_PER;
    --         end loop;
    --     end if;
    --     wait for CLK_PER;
    -- end process COMPARE_DATA_PROC;

    -- COMPARE_DATA_PROC : process (clk_i)
    --     file file_r : text is in "D:/Vova/Prog/projects/data_verification/test_data_reference.txt";
    -- begin

    --     if rising_edge(clk_i) then
    --         if stb_o = '1' then
    --             MP_read_file_vector(file_r, data_reference);

    --         end if;

    --     end if;
    --     and

    --     if rst_i = '0' and rising_edge(clk_i) and then
    --         MP_read_file_vector(file_r, data_reference);
    --     end if;

    --     if rst_i = '0' and rising_edge(clk_i) and stb_o = '1' then
    --         if data_reference = data_o then
    --             pass_flag <= true;
    --         else
    --             pass_flag <= false;
    --             report "ERROR";
    --         end if;
    --     end if;
    -- end process COMPARE_DATA_PROC;

    WRITE_DATA_FROM_CONVERTER : process (clk_i)
        file output_file : text is out "D:/Vova/Prog/projects/data_verification/test_data_o.txt";
    begin
        if rst_i = '0' and rising_edge(clk_i) and stb_o = '1' then
            MP_write_file_vector(output_file, data_o, DATA_LENGTH);
        end if;
    end process;

    dut : entity work.data_converter(data_converter_rtl)
        generic map(
            DATA_LENGTH => DATA_LENGTH
        )
        port map
        (
            clk_i  => clk_i,
            rst_i  => rst_i,
            stb_i  => stb_i,
            data_i => std_vector_input_s,
            stb_o  => stb_o,
            data_o => data_o
        );

end dut_text_file_rtl;
-- 
-- while (not endfile(input_file)) loop
--     readline(input_file, input_line);             -- Read a row from the text file
--     read(input_line, std_vector_input_v, good_v); -- 
--     std_vector_input_s <= std_vector_input_v;
--     if (not good_v) then
--         report "[ERROR] : error of the variable" severity failure;
--     end if;
--     wait until rising_edge(clk_i);
-- end loop;
--     constant C_FILE_NAME : string    := "DataIn.dat";
--     constant C_DATA1_W   : integer   := 16;
--     constant C_DATA3_W   : integer   := 4;
--     constant C_CLK       : time      := 10 ns;
--     signal clk           : std_logic := '0';
--     signal rst           : std_logic := '0';
--     signal data1         : std_logic_vector(C_DATA1_W - 1 downto 0);
--     signal data2         : integer;
--     signal data3         : std_logic_vector(C_DATA3_W - 1 downto 0);
--     signal eof           : std_logic := '0';
--     file fptr            : text;

-- begin

--     ClockGenerator : process
--     begin
--         clk <= '0' after C_CLK, '1' after 2 * C_CLK;
--         wait for 2 * C_CLK;
--     end process;

--     rst <= '1', '0' after 100 ns;

--     GetData_proc : process

--         variable fstatus : file_open_status;
--         variable file_line : line;
--         variable var_data1 : std_logic_vector(C_DATA1_W - 1 downto 0);
--         variable var_data2 : integer;
--         variable var_data3 : std_logic_vector(C_DATA3_W - 1 downto 0);

--     begin

--         data1 <= (others     => '0');
--         var_data1 := (others => '0');
--         data2 <= 0;
--         var_data2 := 0;
--         data3 <= (others     => '0');
--         var_data3 := (others => '0');
--         eof <= '0';
--         wait until rst = '0';

--         file_open(fstatus, fptr, C_FILE_NAME, read_mode);

--         while (not endfile(fptr)) loop
--             wait until clk = '1';
--             readline(fptr, file_line);
--             hread(file_line, var_data1);
--             data1 <= var_data1;
--             read(file_line, var_data2);
--             data2 <= var_data2;
--             read(file_line, var_data3);
--             data3 <= var_data3;
--         end loop;

--         wait until rising_edge(clk);

--         eof <= '1';
--         file_close(fptr);

--         wait;

--     end process;
-- end ReadDataFromFile_rtl;