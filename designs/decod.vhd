library ieee;

use ieee.std_logic_1164.all;

entity decod is
    port (
        A,  B,  C  : in std_logic;
        S1, S2, S3 : out std_logic
    );
end entity decod;

-- architecture comportamental of decod is 
-- begin 
--     S1 <= '1' when (A = '0', B = '1', C = '1') else
--           '1' when (A = '1', B = '1', C = '0') else
--           '1' when (A = '1', B = '1', C = '1') else '0';
      
--     S2 <= '1' when (B = '1') else '0';
--     S3 <= '1'  when (C = '1') else '0';
--     end architecture comportamental;
    
architecture estrutural of decod is 
begin 
    S1 <= (B and C) or (A and B);
    S2 <= (B);
    S3 <= (C);
end architecture estrutural;

