library ieee;
use ieee.std_logic_1164.all;

entity decod is
    port (
        A, B, C : in std_logic; -- Entradas individuais (compatível com seu projeto)
        operation : out std_logic_vector(1 downto 0) -- Controle para as operações
    );
end entity decod;

architecture rtl of decod is
    signal opcode : std_logic_vector(2 downto 0); -- Combinação das entradas
begin
    -- Combinar A, B, C em um vetor
    opcode <= A & B & C;

    -- Lógica para mapear as saídas (em 2 bits)
    operation <= "00" when opcode = "000" else -- AND
                 "01" when opcode = "001" else -- OR
                 "10" when opcode = "010" else -- ADD
                 "10" when opcode = "110" else -- SUB
                 "11" when opcode = "111" else -- SLT
                 "00"; -- Default
end architecture rtl;
