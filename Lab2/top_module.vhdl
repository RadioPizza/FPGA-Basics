library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        pause       : in  STD_LOGIC;
        led_output  : out STD_LOGIC_VECTOR(15 downto 0)
    );
end top_module;

architecture Behavioral of top_module is
    signal index_signal : STD_LOGIC_VECTOR(4 downto 0);
begin
    U1: entity work.led_controller
        Port map (
            clk => clk,
            reset => reset,
            pause => pause,
            combination_index => index_signal
        );

    U2: entity work.led_pattern
        Port map (
            index => index_signal,
            leds => led_output
        );
end Behavioral;
