library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_pattern is
    Port (
        index   : in  STD_LOGIC_VECTOR(3 downto 0);
        leds    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end led_pattern;

architecture Behavioral of led_pattern is
    type led_array is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
    constant patterns : led_array := (
        "0000000000000000",  -- 0
        "0000000000000001",  -- 1
        "0000000000000010",  -- 2
        "0000000000000101",  -- 3
        "0000000000001010",  -- 4
        "0000000000101010",  -- 5
        "0000000001010101",  -- 6
        "0000000010101010",  -- 7
        "0000000101010101",  -- 8
        "0000001010101010",  -- 9
        "0000010101010101",  -- 10
        "0000101010101010",  -- 11
        "0001010101010101",  -- 12
        "0010101010101010",  -- 13
        "0101010101010101",  -- 14
        "1010101010101010"   -- 15
    );
begin
    leds <= patterns(to_integer(unsigned(index)));
end Behavioral;
