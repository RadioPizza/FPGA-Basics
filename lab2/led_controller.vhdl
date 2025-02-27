library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_controller is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        pause   : in  STD_LOGIC;
        combination_index   : out STD_LOGIC_VECTOR (4 downto 0)
    );
end led_controller;

architecture Behavioral of led_controller is
    signal current_index : UNSIGNED(4 downto 0) := (others => '0');
    signal counter       : UNSIGNED(31 downto 0) := (others => '0');
    constant MAX_INDEX   : UNSIGNED(4 downto 0) := "10000"; -- 17 combinations
    constant DELAY       : UNSIGNED(31 downto 0) := X"029020C0"; -- 43,000,000 for 100 MHz
    signal running       : STD_LOGIC := '1';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_index <= (others => '0');
            counter <= (others => '0');
            running <= '1';
        elsif rising_edge(clk) then
            running <= not pause;

            if running = '1' then
                if counter < DELAY then
                    counter <= counter + 1;
                else
                    counter <= (others => '0');
                    current_index <= current_index + 1;
                    if current_index > MAX_INDEX then
                        current_index <= (others => '0');
                    end if;
                end if;
            end if;
        end if;
    end process;

    combination_index <= std_logic_vector(current_index);
end Behavioral;
