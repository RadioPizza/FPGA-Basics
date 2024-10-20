LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_module_tb IS
END top_module_tb;

ARCHITECTURE Behavioral OF top_module_tb IS

    -- Сигналы для подключения к top_module
    SIGNAL clk        : STD_LOGIC := '0';
    SIGNAL reset      : STD_LOGIC := '0';
    SIGNAL pause      : STD_LOGIC := '0';
    SIGNAL led_output : STD_LOGIC_VECTOR(15 downto 0);

    -- Константа для периода тактового сигнала (например, 10ns для 100MHz)
    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Генерация тактового сигнала
    clk_process : PROCESS
    BEGIN
        LOOP
            clk <= '0';
            WAIT FOR clk_period / 2;
            clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    -- Инстанциация тестируемого модуля
    uut: entity work.top_module
        PORT MAP (
            clk        => clk,
            reset      => reset,
            pause      => pause,
            led_output => led_output
        );

    -- Процесс для генерации сигналов reset и pause
    stim_proc: PROCESS
    BEGIN
        -- Инициализация: reset и pause неактивны
        reset <= '0';
        pause <= '0';
        WAIT FOR 2 * clk_period;

        -- 1. Прогон всех 16 комбинаций (минимум 16 периодов)
        WAIT FOR 20 * clk_period;

        -- 2. Тестирование сигнала reset
        -- Активируем reset на один тактовый период
        reset <= '1';
        WAIT FOR clk_period;
        reset <= '0';
        WAIT FOR 4 * clk_period;

        -- 3. Тестирование сигнала pause
        -- Активируем pause, после чего модуль должен перестать обновлять led_output
        pause <= '1';
        WAIT FOR 10 * clk_period;
        pause <= '0';
        WAIT FOR 40 ns;

        -- Завершаем симуляцию
        WAIT;
    END PROCESS;

    -- Процесс для мониторинга выходов
    monitor_proc: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            REPORT "Time: " & TIME'image(now) &
                   " | Reset: " & STD_LOGIC'image(reset) &
                   " | Pause: " & STD_LOGIC'image(pause) &
                   " | LED Output: " & to_hstring(led_output);
        END IF;
    END PROCESS;

END Behavioral;