library ieee;
use ieee.std_logic_1164.all;

entity ULA32bits is 
    port (
        A, B : in std_logic_vector(31 downto 0);       -- Entradas de 32 bits
        Cin : in std_logic;                           -- Carry inicial
        operation : in std_logic_vector(1 downto 0);  -- Controle para operações
        Saida : out std_logic_vector(31 downto 0);    -- Resultado de 32 bits
        carry_out : out std_logic;                    -- Carry final
        zero : out std_logic                          -- Indica se o resultado é zero
    );
end entity ULA32bits;

architecture rtl of ULA32bits is 
    component ULA is 
        port (
            A, B, Cin : in std_logic;                 -- Entradas de 1 bit
            Sel : in std_logic_vector(1 downto 0);    -- Controle para operação
            Less : in std_logic;                     -- Sinal para SLT
            Saida, carry_out : out std_logic          -- Saídas
        );
    end component ULA;

    signal carry_chain : std_logic_vector(31 downto 0); -- Carry entre ULAs
    signal result_internal : std_logic_vector(31 downto 0); -- Resultado intermediário
    signal slt_set : std_logic; -- Resultado do SLT
begin
    -- ULA LSB
    ula_0: ULA port map (
        A => A(0),
        B => B(0),
        Cin => Cin,
        Sel => operation,
        Less => slt_set,
        Saida => result_internal(0),
        carry_out => carry_chain(0)
    );

    -- Comparação bit a bit e cálculo do SLT
    process (A, B, operation)
    begin
        if operation = "11" then
            if A < B then
                slt_set <= '1';
            else
                slt_set <= '0';
            end if;
        else
            slt_set <= '0';
        end if;
    end process;

    -- ULAs intermediárias
    gen_ULA: for i in 1 to 30 generate
        ula_i: ULA port map (
            A => A(i),
            B => B(i),
            Cin => carry_chain(i-1),
            Sel => operation,
            Less => '0',
            Saida => result_internal(i),
            carry_out => carry_chain(i)
        );
    end generate gen_ULA;

    -- ULA MSB
    ula_31: ULA port map (
        A => A(31),
        B => B(31),
        Cin => carry_chain(30),
        Sel => operation,
        Less => '0',
        Saida => result_internal(31),
        carry_out => carry_out
    );

    -- Resultado final
    Saida <= result_internal when operation /= "11" else
             (31 downto 1 => '0') & slt_set;

    -- Detectar se o resultado é zero
    zero <= '1' when result_internal = x"00000000" else '0';
end architecture rtl;
