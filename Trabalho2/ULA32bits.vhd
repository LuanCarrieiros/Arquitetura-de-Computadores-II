library ieee;
use ieee.std_logic_1164.all;

entity ULA32bits is 
    port (
        A, B : in std_logic_vector(31 downto 0);
        Cin : in std_logic;
        operation : in std_logic_vector(1 downto 0); -- Controle para operações
        Saida : out std_logic_vector(31 downto 0);
        carry_out : out std_logic;
        zero : out std_logic 
    );
end entity ULA32bits;

architecture rtl of ULA32bits is 
    component ULA is 
        port (
            A, B, Cin : in std_logic;
            Sel : in std_logic_vector(1 downto 0);
            Saida, carry_out : out std_logic
        );
    end component ULA;

    signal carry_chain : std_logic_vector(31 downto 0); -- Carry entre ULAs de 1 bit
    signal result_internal : std_logic_vector(31 downto 0); -- Resultado interno para saída
begin
    -- ULA LSB
    ula_0: ULA port map (
        A => A(0),
        B => B(0),
        Cin => Cin,
        Sel => operation, -- Usando operation como controle
        Saida => result_internal(0),
        carry_out => carry_chain(0)
    );

    -- ULAs de 1 bit intermediárias 
    gen_ULA: for i in 1 to 30 generate 
        ula_i: ULA port map (
            A => A(i),
            B => B(i),
            Cin => carry_chain(i-1),
            Sel => operation,
            Saida => result_internal(i),
            carry_out => carry_chain(i)
        );
    end generate gen_ULA;
    
    -- ULA MSB
    ULA_31: ULA port map (
        A => A(31),
        B => B(31), 
        Cin => carry_chain(30), -- Carry de saída da ULA anterior
        Sel => operation,
        Saida => result_internal(31),
        carry_out => carry_out
    );
    
    Saida <= result_internal;
    -- Detectar se o resultado é zero
    zero <= '1' when result_internal = x"00000000" else '0';
end architecture rtl;
