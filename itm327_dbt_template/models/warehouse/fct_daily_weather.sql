-- fct_daily_weather
-- Fact table: one row per city per observation day.
-- Grain: CITY + DATE
--
-- Accepts weather readings from staging into the warehouse layer.
-- Marts that need weather data must reference this table via ref(),
-- not reach back to the raw_weather staging view directly.
--
-- TODO: If your weather pipeline adds new columns (e.g., humidity,
--       UV index), add them here so marts inherit them automatically.

SELECT
    "date"::DATE    AS DATE,
    "city"          AS CITY,
    "max_temp"      AS MAX_TEMP,
    "min_temp"      AS MIN_TEMP,
    "precip"        AS PRECIP,
    "max_wind"      AS MAX_WIND
FROM {{ ref('raw_weather') }}
