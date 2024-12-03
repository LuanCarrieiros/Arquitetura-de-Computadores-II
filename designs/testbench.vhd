library ieee;

use ieee.std_logic_1164.all;

entity tb_ULA32decod is 
end entity tb_ULA32decod;

architecture sim of tb_ULA32decod is
    signal A, B : std_logic_vector(31 downto 0);
    signal Cin : std_logic;
    signal DecA, DecB, DecC : std_logic;
    signal Saida : std_logic_vector(31 downto 0);
    signal carry_out : std_logic;

    component ULA32decod is 
        port (
            A, B : in std_logic_vector(31 downto 0);
            Cin : in std_logic;
            DecA, DecB, DecC : in std_logic;
            Saida : out std_logic_vector(31 downto 0);
            carry_out : out std_logic
        );
    end component ULA32decod;

begin 
    uut: ULA32decod port map (
        A => A, 
        B => B, 
        Cin => Cin, 
        DecA => DecA,
        DecB => DecB,
        DecC => DecC,
        Saida => Saida,
        carry_out => carry_out
    );

    process 
    begin 
        -- Teste 1: Soma
        A <= x"0000000F"; B <= x"00000001"; Cin <= '0';
        DecA <= '0'; DecB <= '1'; DecC <= '1'; -- S1 ativo
        wait for 10 ns;
 
        -- Teste 2: AND
        A <= x"FFFFFFFF"; B <= x"0F0F0F0F"; Cin <= '0';
        DecA <= '1'; DecB <= '0'; DecC <= '0'; -- S1 ativo
        wait for 10 ns;
 
        -- Teste 3: Soma com Carry-in
        A <= x"0000FFFF"; B <= x"0000FFFF"; Cin <= '1';
        DecA <= '0'; DecB <= '1'; DecC <= '1'; -- S1 ativo
        wait for 10 ns;

        -- Finaliza
        wait;
    end process;

end architecture sim;