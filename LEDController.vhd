-- LEDController.VHD
-- 2025.03.09
--
-- This SCOMP peripheral drives ten outputs high or low based on
-- a value from SCOMP.

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY LEDController IS
PORT(
    CS          : IN  STD_LOGIC;  -- Chip Select
    WRITE_EN    : IN  STD_LOGIC;  -- Write Enable
    RESETN      : IN  STD_LOGIC;  -- Active-low Reset
    CLOCK       : IN  STD_LOGIC;  -- System Clock for PWM
    LEDs        : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); -- LED Outputs
    IO_DATA     : IN  STD_LOGIC_VECTOR(15 DOWNTO 0) -- Data from SCOMP
    );
END LEDController;

ARCHITECTURE a OF LEDController IS
    SIGNAL count      : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); 
    SIGNAL pattern    : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL duty_cycle : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); 
	 SIGNAL PWM        : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); --PWM data 
	 
BEGIN
    -- Process for updating LED pattern from IO_DATA (Only when CS and WRITE_EN are high)
    PROCESS (RESETN, CLOCK)
    BEGIN
        IF (RESETN = '0') THEN
            pattern <= (OTHERS => '0');
        ELSIF (RISING_EDGE(CS)) THEN
            IF (WRITE_EN = '1') THEN
                pattern <= IO_DATA(9 DOWNTO 0);
					 PWM <= IO_DATA(13 DOWNTO 10); -- PWM input
            END IF;
        END IF;
    END PROCESS;

    -- Process for PWM control
    PROCESS (RESETN, CLOCK)
    BEGIN
        IF (RESETN = '0') THEN
            count <= (OTHERS => '0');
            duty_cycle <= (OTHERS => '0');
				
        ELSIF (RISING_EDGE(CLOCK)) THEN
            count <= count + 1; -- Continuous counter for PWM
				

            -- Set duty cycle based on PWM (need changes)
            CASE PWM IS
				    when "0000" => duty_cycle <= x"00"; -- 0 % duty cycle
					 when "0001" => duty_cycle <= x"01"; -- 10 % duty cycle
					 when "0010" => duty_cycle <= x"07"; -- 20 % duty cycle
					 when "0011" => duty_cycle <= x"12"; -- 30 % duty cycle
					 when "0100" => duty_cycle <= x"21"; -- 40 % duty cycle
					 when "0101" => duty_cycle <= x"37"; -- 50 % duty cycle
					 when "0110" => duty_cycle <= x"52"; -- 60 % duty cycle
					 when "0111" => duty_cycle <= x"74"; -- 70 % duty cycle
					 when "1000" => duty_cycle <= x"9c"; -- 80 % duty cycle
					 when "1001" => duty_cycle <= x"ca"; -- 90 % duty cycle
					 when "1010" => duty_cycle <= x"ff"; -- 100 % duty cycle
					 when others => duty_cycle <= x"ff"; -- 100 % duty cycle

            END CASE;

            -- PWM logic: LEDs ON when count < duty_cycle, otherwise OFF
            IF (count = duty_cycle) THEN
					 count <= (others => '0');
                LEDs <= Pattern;
            ELSE
                LEDs <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;
END a;