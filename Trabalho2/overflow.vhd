library ieee;

use ieee.std_logic_1164.all;

entity overflow is 
    port (
        A_msb, B_msb, Result_msb : in std_logic;
        Overflow                 : out std_logic
    );

    end entity overflow;

architecture rtl of overflow is
begin 
    Overflow <= (A_msb and B_msb and not Result_msb) 
    or          (not A_msb and not B_msb and Result_msb);

end architecture rtl;