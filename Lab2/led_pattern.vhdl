library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_pattern is
    Port (
        index   : in  STD_LOGIC_VECTOR(3 downto 0);
        leds    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end led_pattern;

architecture Behavioral of led_pattern is
begin
    process(index)
        variable pattern : STD_LOGIC_VECTOR(15 downto 0);
        variable idx_int : integer;
    begin
        idx_int := to_integer(unsigned(index));
        pattern := (others => '0');

        if idx_int = 0 then
            pattern := (others => '0');
        else
            for i in 0 to idx_int - 1 loop
                if ((idx_int mod 2 = 0) and (i mod 2 = 1)) or
                   ((idx_int mod 2 = 1) and (i mod 2 = 0)) then
                    pattern(i) := '1';
                end if;
            end loop;
        end if;

        leds <= pattern;
    end process;
end Behavioral;
