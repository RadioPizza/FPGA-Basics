library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_pattern is
    Port (
        index   : in  STD_LOGIC_VECTOR(4 downto 0);
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

        -- Limit the range of idx_int
        if idx_int > 16 then
            idx_int := 16;  -- Set index to 16 if it exceeds 16
        end if;

        if idx_int = 0 then
            pattern := (others => '0');  -- Keep all bits '0' if index is 0
        else
            for i in 0 to 15 loop  -- Fixed range loop
                if i < idx_int then
                    if ((idx_int mod 2 = 0) and (i mod 2 = 1)) or
                       ((idx_int mod 2 = 1) and (i mod 2 = 0)) then
                        pattern(i) := '1';  -- Set bit to '1' according to condition
                    end if;
                end if;
            end loop;
        end if;

        leds <= pattern;  -- Assign the result to the output signal leds
    end process;
end Behavioral;
