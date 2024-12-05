library ieee;

use ieee.std_logic_1164.all;

entity ULA32decod is 
    port (
        A, B  : in std_logic_vector(31 downto 0);  -- Entradas de 32 bits
        Cin   : in std_logic;                     -- Carry inicial
        DecA, DecB, DecC : in std_logic;          -- Entradas para o decodificador
        Saida : out std_logic_vector(31 downto 0);-- Saída do resultado
        carry_out : out std_logic;               -- Carry final
        zero : out std_logic                     -- Indica se o resultado é zero
    );
end entity ULA32decod;

architecture rtl of ULA32decod is
    
    component ULA32bits is 
        port (
            A, B  : in std_logic_vector(31 downto 0);  -- Entradas de 32 bits
            Cin : in std_logic;                       -- Carry inicial
            operation : in std_logic_vector(1 downto 0); -- Controle de operação
            Saida : out std_logic_vector(31 downto 0); -- Resultado de 32 bits
            carry_out : out std_logic;               -- Carry final
            zero : out std_logic                     -- Indica se o resultado é zero
        );
    end component ULA32bits;

    component decod is
        port (
            A, B, C : in std_logic;                  -- Entradas do decodificador
            operation : out std_logic_vector(1 downto 0) -- Sinal de controle
        );
    end component decod;

    signal operation : std_logic_vector(1 downto 0); -- Sinal de controle da operação
begin 
    -- Instância do Decodificador
    decod_inst: decod port map (
        A => DecA,
        B => DecB,
        C => DecC,
        operation => operation -- Sinal de saída
    );

    -- Instância da ULA de 32 bits
    ula32: ULA32bits port map (
        A => A,
        B => B,
        Cin => Cin,
        operation => operation, -- Conectando o sinal de controle
        Saida => Saida,
        carry_out => carry_out,
        zero => zero            -- Conectando o sinal zero
    );

end architecture rtl;
