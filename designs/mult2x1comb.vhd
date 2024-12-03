library ieee;

use ieee.std_logic_1164.all;

entity mult2x1comb is 
    port (
        e1, e2, e3, e4  : in std_logic;
        sel1            : in std_logic;
        s1              : out std_logic
    );
end entity mult2x1comb;

architecture rtl of mult2x1comb is
    component mult2x1
        port (
            e1, e2 : in std_logic;
            sel    : in std_logic;
            s      : out std_logic
        );
    end component;

    signal sinal_sel : std_logic;

begin 
    mux1: mult2x1 port map (
        e1 => e1,
        e2 => e2,
        sel => sel1,
        s => sinal_sel
    );

    mux2: mult2x1 port map (
        e1 => e3,
        e2 => e4,
        sel => sinal_sel,
        s => s1
    );
end architecture rtl;