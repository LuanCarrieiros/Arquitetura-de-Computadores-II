library ieee;

use ieee.std_logic_1164.all;

entity ULA32decod is 
    port (
        A, B  : in std_logic_vector(31 downto 0);
        Cin   : in std_logic;
        DecA, DecB, DecC : in std_logic;
        Saida : out std_logic_vector(31 downto 0);
        carry_out : out std_logic
    );
end entity ULA32decod;

architecture rtl of ULA32decod is
    component ULA32bits is 
        port (
            A, B  : in std_logic_vector(31 downto 0);
            Cin : in std_logic;
            operation : in std_logic_vector(1 downto 0);
            Saida : out std_logic_vector(31 downto 0);
            carry_out : out std_logic
        );
    end component ULA32bits;

    component decod is
        port (
            A, B, C : in std_logic;
            operation : out std_logic_vector(1 downto 0)
        );
    end component decod;

    signal operation : std_logic_vector(1 downto 0); -- Sinal de controle de operação
    signal zero_signal : std_logic; -- Sinal interno para zero

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
        carry_out => carry_out
    );

end architecture rtl;
