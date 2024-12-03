library ieee;
use ieee.std_logic_1164.all;

entity ULA is 
    port (
        A, B, Cin : in std_logic;          -- Entradas de 1 bit
        Sel : in std_logic_vector(1 downto 0); -- Seleção de 2 bits
        Saida, carry_out : out std_logic     -- Saídas
    );
end entity ULA;

architecture rtl of ULA is
    signal B_invertido, AND_out, OR_out, Soma : std_logic; -- Sinais intermediários
    signal carry_temp : std_logic;                       -- Carry temporário

begin 
    -- Inversão de B com base no Sel (binvert)
    B_invertido <= B xor Sel(0); -- Seleção do bit para inversão de B

    -- Operações Lógicas
    AND_out <= A and B_invertido; -- Operação AND
    OR_out <= A or B_invertido;  -- Operação OR

    -- Operação de Soma com Carry
    Soma <= (A xor B_invertido) xor Cin;
    carry_temp <= (A and B_invertido) or (Cin and (A xor B_invertido));

    -- Multiplexador para Seleção de Operação
    with Sel select
        Saida <= AND_out when "00",    -- AND
                 OR_out when "01",     -- OR
                 Soma when "10",       -- Soma
                 '0' when others;      -- Default

    -- Saída de Carry
    carry_out <= carry_temp;
end architecture rtl;
