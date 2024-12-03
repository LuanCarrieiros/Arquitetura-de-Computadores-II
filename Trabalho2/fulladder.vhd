library ieee;

use ieee.std_logic_1164.all;

entity fulladder is 
    port (
        A, B, Cin : in std_logic;
        S1, S2, carry_out : out std_logic
    );
    end entity fulladder;

architecture rtl of fulladder is
    component halfadder 
        port (
            A, B : in std_logic;
            sum, carry_out : out std_logic
        );
    end component;

    signal signal_s1, signal_s2, signal_s3 : std_logic;
begin 
    halfadder1: halfadder port map (
        A => A, 
        B => B, 
        sum => signal_s1,
        carry_out => signal_s2
    );

    halfadder2: halfadder port map (
        A => signal_s1,
        B => Cin, 
        sum => S1, 
        carry_out => signal_s3
    );

    carry_out <= signal_s2 or signal_s3;
    S2 <= A and B;
end architecture rtl;