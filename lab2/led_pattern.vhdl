library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_pattern is
    Port (
        index   : in  STD_LOGIC_VECTOR(4 downto 0);
        sw0     : in  STD_LOGIC;  -- New input for switch SW0
        leds    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end led_pattern;

architecture Behavioral of led_pattern is
begin
    process(index, sw0)
        variable pattern : STD_LOGIC_VECTOR(15 downto 0);
        variable idx_int : integer;
        variable skip    : integer;  -- Number of LEDs to skip
    begin
        idx_int := to_integer(unsigned(index));
        pattern := (others => '0');

        -- Determine the number of LEDs to skip based on sw0
        if sw0 = '1' then
            skip := 2;  -- Skip 2 LEDs
        else
            skip := 1;  -- Skip 1 LED
        end if;

        -- Generate the LED pattern
        if idx_int = 0 then
            pattern := (others => '0');  -- All LEDs off
        else
            for i in 0 to 15 loop
                if i < idx_int then
                    if (i mod (skip + 1) = 0) then
                        pattern(i) := '1'; 
                    end if;
                end if;
            end loop;
        end if;

        leds <= pattern;  -- Assign the pattern to the output
    end process;
end Behavioral;
