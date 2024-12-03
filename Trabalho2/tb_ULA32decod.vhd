library ieee;
use ieee.std_logic_1164.all;

entity tb_ULA32decod is 
end entity tb_ULA32decod;

architecture sim of tb_ULA32decod is
    -- Sinais internos
    signal A, B : std_logic_vector(31 downto 0);
    signal Cin : std_logic;
    signal DecA, DecB, DecC : std_logic;
    signal Saida : std_logic_vector(31 downto 0);
    signal carry_out : std_logic;

    -- Componente ULA32decod
    component ULA32decod is 
        port (
            A, B : in std_logic_vector(31 downto 0);
            Cin : in std_logic;
            DecA, DecB, DecC : in std_logic;
            Saida : out std_logic_vector(31 downto 0);
            carry_out : out std_logic
        );
    end component;

begin 
    -- Instância do componente
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

    -- Processo de estímulos
    process 
    begin 
        -- Teste 1: Soma
        report "Teste 1: Soma";
        A <= x"0000000F"; B <= x"00000001"; Cin <= '0';
        DecA <= '0'; DecB <= '1'; DecC <= '1'; -- S1 ativo
        wait for 10 ns;

        -- Teste 2: AND
        report "Teste 2: AND";
        A <= x"FFFFFFFF"; B <= x"0F0F0F0F"; Cin <= '0';
        DecA <= '1'; DecB <= '0'; DecC <= '0'; -- S1 ativo
        wait for 10 ns;

        -- Teste 3: Soma com Carry-in
        report "Teste 3: Soma com Carry-in";
        A <= x"0000FFFF"; B <= x"0000FFFF"; Cin <= '1';
        DecA <= '0'; DecB <= '1'; DecC <= '1'; -- S1 ativo
        wait for 10 ns;

        -- Teste 4: Subtração
        report "Teste 4: Subtração";
        A <= x"00000010"; B <= x"00000001"; Cin <= '1';
        DecA <= '0'; DecB <= '1'; DecC <= '1'; -- S1 ativo
        wait for 10 ns;

        -- Teste 5: OR
        report "Teste 5: OR";
        A <= x"12345678"; B <= x"87654321"; Cin <= '0';
        DecA <= '1'; DecB <= '0'; DecC <= '1'; -- S3 ativo
        wait for 10 ns;

        -- Teste 6: SLT
        report "Teste 6: SLT";
        A <= x"00000002"; B <= x"00000003"; Cin <= '0';
        DecA <= '1'; DecB <= '1'; DecC <= '0'; -- S4 ativo
        wait for 10 ns;

        -- Finalizar simulação
        report "Simulação finalizada!";
        wait;
    end process;

end architecture sim;
