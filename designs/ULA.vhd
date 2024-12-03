library ieee;

use ieee.std_logic_1164.all;

entity ULA is 
    port (
        A, B, Cin, Sel : in std_logic;
        Saida, carry_out : out std_logic
    );
end entity ULA;

architecture rtl of ULA is
    component fulladder 
        port (
            A, B, Cin : in std_logic;
            S1, S2, carry_out : out std_logic
        );
    end component fulladder;

    component mult2x1
        port (
            e1, e2, sel : in std_logic;
            s : out std_logic
        );
    end component mult2x1;

    signal signal_s4, signal_s5, signal_s6 : std_logic;
begin 
    fulladder_inst: fulladder port map (
        A => A, 
        B => B, 
        Cin => Cin,
        S1 => signal_s4,
        S2 => signal_s5,
        carry_out => signal_s6
    );

    mult2x1_inst: mult2x1 port map (
        e1 => signal_s4,
        e2 => signal_s5,
        sel => sel,
        s => Saida
    );

    carry_out <= signal_s6;
end architecture rtl;
