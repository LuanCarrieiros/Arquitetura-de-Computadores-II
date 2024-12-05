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
    signal zero : std_logic;

    -- Componente ULA32decod
    component ULA32decod is 
        port (
            A, B : in std_logic_vector(31 downto 0);
            Cin : in std_logic;
            DecA, DecB, DecC : in std_logic;
            Saida : out std_logic_vector(31 downto 0);
            carry_out : out std_logic;
            zero : out std_logic
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
        carry_out => carry_out,
        zero => zero
    );

    -- Processo de estímulos
    process 
    begin 
        -- Teste 1: AND
        report "Teste 1: AND";
        A <= "11111111111111111111111111111111"; -- Todos 1
        B <= "00001111000011110000111100001111"; -- Padrão
        Cin <= '0';
        DecA <= '0'; DecB <= '0'; DecC <= '0'; -- AND ativo
        wait for 10 ns;

        -- Teste 2: OR
        report "Teste 2: OR";
        A <= "00000000000000000000000000001010"; -- Padrão binário
        B <= "00000000000000000000000000000011"; -- Padrão binário
        Cin <= '0';
        DecA <= '0'; DecB <= '0'; DecC <= '1'; -- OR ativo
        wait for 10 ns;

        -- Teste 3: ADD
        report "Teste 3: ADD";
        A <= "00000000000000000000000000001110"; -- 15
        B <= "00000000000000000000000000000001"; -- 1
        Cin <= '0';
        DecA <= '0'; DecB <= '1'; DecC <= '0'; -- ADD ativo
        wait for 10 ns;

        -- Teste 4: SUB
        report "Teste 4: SUB";
        A <= "00000000000000000000000000001111"; -- 16 em binário
        B <= "00000000000000000000000000000001"; -- 1 em binário
        Cin <= '1'; -- Carry-in para SUB
        DecA <= '1'; DecB <= '1'; DecC <= '0'; -- SUB ativo
        wait for 10 ns;

        -- Teste 5: SLT
        report "Teste 5: SLT";
        A <= "00000000000000000000000000000010"; -- 2 em binário
        B <= "00000000000000000000000000001000"; -- 3 em binário
        Cin <= '0';
        DecA <= '1'; DecB <= '1'; DecC <= '1'; -- SLT ativo
        wait for 10 ns;
        

        -- Finalizar simulação
        report "Simulação finalizada!";
        wait;
    end process;

end architecture sim;
