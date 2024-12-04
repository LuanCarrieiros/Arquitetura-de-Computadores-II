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

    signal carry_chain : std_logic_vector(31 downto 0);       -- Carry entre ULAs
    signal result_internal : std_logic_vector(31 downto 0);   -- Resultado intermediário
    signal set_signal : std_logic;                           -- Sinal para SLT (MSB)
begin
    -- ULA LSB
    ula_0: ULA port map (
        A => A(0),
        B => B(0),
        Cin => Cin,
        Sel => operation,       -- Controle da operação
        Less => set_signal,            -- Sem SLT no LSB
        Saida => result_internal(0),
        carry_out => carry_chain(0)
    );

    -- ULAs intermediárias
    gen_ULA: for i in 1 to 30 generate
        ula_i: ULA port map (
            A => A(i),
            B => B(i),
            Cin => carry_chain(i-1), -- Carry da ULA anterior
            Sel => operation,
            Less => '0',             -- Sem SLT nas intermediárias
            Saida => result_internal(i),
            carry_out => carry_chain(i)
        );
    end generate gen_ULA;

    -- ULA MSB
    ULA_31: ULA port map (
        A => A(31),
        B => B(31),
        Cin => carry_chain(30),     -- Carry da ULA anterior
        Sel => operation,
        Less => set_signal,         -- Bit para SLT
        Saida => result_internal(31),
        carry_out => carry_out
    );

    -- "Set" para SLT: usa o MSB do resultado da subtração
    set_signal <= result_internal(31);

    -- Resultado final
    Saida <= result_internal;

    -- Detectar se o resultado é zero
    zero <= '1' when result_internal = x"00000000" else '0';
end architecture rtl;
