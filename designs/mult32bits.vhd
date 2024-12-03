library ieee;

use ieee.std_logic_1164.all;

entity mult32bits is 
    port (
        e1, e2   :   in std_logic_vector(31 downto 0);
        sel      :   in std_logic;
        s        :   out std_logic_vector(31 downto 0)
    );
end entity mult32bits;

architecture rtl of mult32bits is
    component mult2x1
        port (
            e1, e2 : in std_logic;
            sel    : in std_logic;
            s      : out std_logic
        );
        end component;

    signal sinal_sel : std_logic_vector(31 downto 0);

begin 
    gen_mux: for i in 0 to 31 generate
        mux_instancia: mult2x1 port map (
            e1 => e1(i),
            e2 => e2(i),
            sel => sel,
            s => sinal_sel(i) -- essa linha
        );
        end generate gen_mux;
    
    s <= sinal_sel; -- essa segunda linha

end architecture rtl;
    