library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

package MP_package is

    procedure MP_start_reset (
        constant p_DURATION : in time;
        signal p_rst_o      : out std_logic
    );

    procedure MP_end_simulation (
        constant p_DURATION : in time
    );

end package MP_package;

package body MP_package is

    procedure MP_end_simulation (
        constant p_DURATION : in time
    )
    is begin
        wait for p_DURATION;
        report "[INFO] : End simulation" severity failure;
    end procedure MP_end_simulation;

    procedure MP_start_reset (
        constant p_DURATION : in time;
        signal p_rst_o      : out std_logic
    ) is begin
        report "Start_reset";
        p_rst_o <= '1';
        wait for p_DURATION;
        p_rst_o <= '0';
        wait for p_DURATION;
    end procedure MP_start_reset;

end package body MP_package;