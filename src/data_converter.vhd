-- simple code for testing the testbench
-- it works like:
-- 1. reverse the input signal from LE to BE
-- 2. add before MSB and after LSB '1';
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_converter is
    generic (
        DATA_LENGTH_IN  : integer := 10;
        DATA_LENGTH_OUT : integer := 12
    );
    port
    (
        clk_i : in std_logic;
        rst_i : in std_logic;

        stb_i  : in std_logic;
        data_i : in std_logic_vector(DATA_LENGTH_IN - 1 downto 0);
        stb_o  : out std_logic;
        data_o : out std_logic_vector(DATA_LENGTH_OUT - 1 downto 0)
    );
end entity data_converter;

architecture data_converter_rtl of data_converter is
    signal rev_data : std_logic_vector(data_i'range);
begin

    CNV_PROC : process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            stb_o    <= '0';
            rev_data <= (others => '0');
        elsif rising_edge(clk_i) then
            if stb_i = '1' then
                for i in 0 to DATA_LENGTH_IN - 1 loop
                    rev_data(i) <= data_i(DATA_LENGTH_IN - 1 - i);
                end loop;
                stb_o      <= '1';
            else stb_o <= '0';
                rev_data   <= (others => '0');
            end if;
        end if;
    end process CNV_PROC;
    
    data_o <= ('1',rev_data,'1');

end architecture data_converter_rtl;