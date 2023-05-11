library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_converter is
    generic (
        DATA_LENGTH : integer := 10
    );
    port
    (
        clk_i  : in std_logic;
        rst_i  : in std_logic;

        stb_i  : in std_logic;
        data_i : in std_logic_vector(DATA_LENGTH - 1 downto 0);
        stb_o  : out std_logic;
        data_o : out std_logic_vector(DATA_LENGTH - 1 downto 0)
    );
end entity data_converter;

architecture data_converter_rtl of data_converter is

begin

    CNV_PROC : process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            stb_o  <= '0';
            data_o <= (others => '0');
        elsif rising_edge(clk_i) then
            if stb_i = '1' then
                for i in 0 to DATA_LENGTH - 1 loop
                    data_o(i) <= data_i(DATA_LENGTH - 1 - i);
                end loop;
                stb_o <= '1';
            else
                stb_o  <= '0';
                data_o <= (others => '0');
            end if;
        end if;
    end process CNV_PROC;

end architecture data_converter_rtl;