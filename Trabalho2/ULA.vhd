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
    component overflow is 
        port (
            A_msb, B_msb, Result_msb : in std_logic;
            Overflow                 : out std_logic
        );
    end component overflow;

    signal B_invertido, AND_out, OR_out, Soma, SLT_out: std_logic;
    signal carry_temp, local_cin : std_logic;
    signal overflow_signal: std_logic; -- Sinal de overflow
begin 
    -- Configuração para Subtração (invertendo B e ajustando Cin para 1)
    B_invertido <= not B when Sel = "10" or Sel = "11" else B; -- Inverte B para SUB e SLT
    local_cin <= '1' when Sel = "10" or Sel = "11" else '0';  -- Carry-in = 1 para SUB e SLT

    -- Operações Lógicas
    AND_out <= A and B;          -- Operação AND
    OR_out <= A or B;            -- Operação OR

    -- Operação de Soma/Subtração
    Soma <= (A xor B_invertido) xor local_cin;
    carry_temp <= (A and B_invertido) or (local_cin and (A xor B_invertido));

    -- Instância do cálculo de Overflow
    overflow_inst: overflow port map (
        A_msb => A,
        B_msb => B,
        Result_msb => Soma,
        Overflow => overflow_signal
    );

    -- Operação de SLT (Menor que)
    SLT_out <= (overflow_signal xor Soma) when Sel = "11" else '0';

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
