library ieee;
use ieee.std_logic_1164.all;

entity ULA is 
    port (
        A, B, Cin : in std_logic;          -- Entradas de 1 bit
        Sel : in std_logic_vector(1 downto 0); -- Seleção de 2 bits
        Less : in std_logic;              -- Entrada para SLT
        Saida, carry_out : out std_logic     -- Saídas
    );
end entity ULA;

architecture rtl of ULA is
    signal B_invertido, AND_out, OR_out, Soma, SLT_out: std_logic; -- Sinais intermediários
    signal carry_temp, local_cin : std_logic;                      -- Sinais temporários
begin 
    -- Inversão de B e definição de Carry-in local
    B_invertido <= B when Sel(1) = '0' else not B; -- Usa B para ADD, not B para SUB
    local_cin <= Sel(1);         -- Carry-in = 1 para SUB, 0 para ADD

    -- Operações Lógicas
    AND_out <= A and B;          -- Operação AND
    OR_out <= A or B;            -- Operação OR

    -- Operação de Soma/Subtração
    Soma <= (A xor B_invertido) xor local_cin; -- Soma ou Subtração
    carry_temp <= (A and B_invertido) or (local_cin and (A xor B_invertido));

    -- Operação de SLT (Menor que)
    SLT_out <= Less when Sel = "11" else '0';

    -- Multiplexador para Seleção de Operação
    with Sel select
        Saida <= AND_out when "00",    -- AND
                 OR_out when "01",     -- OR
                 Soma when "10",       -- Soma/Subtração
                 SLT_out when "11",    -- SLT
                 '0' when others;      -- Default

    -- Saída de Carry
    carry_out <= carry_temp;
end architecture rtl;
