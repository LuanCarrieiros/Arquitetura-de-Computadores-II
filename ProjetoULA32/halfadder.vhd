library ieee;

use ieee.std_logic_1164.all;

entity halfadder is
    port (
        A, B  :  in std_logic;
        sum, carry_out : out std_logic
    );
    end entity halfadder;

architecture rtl of halfadder is
begin 
    sum <= A xor B;
    carry_out <= A and B;
end architecture rtl;

