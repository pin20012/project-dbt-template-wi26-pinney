-- dim_weather_cities
-- Dimension table: one row per financial hub city tracked by the weather pipeline.
--
-- In your data warehouse, this acts as the "location" dimension —
-- marts that analyze market performance by geography join against this table.
--
-- TODO: Add a city-to-exchange mapping if you want to associate each city with
--       a specific stock exchange (e.g., New York → NYSE/NASDAQ, London → LSE).

SELECT
    "city"                          AS CITY,
    MIN("date"::DATE)               AS FIRST_OBSERVATION_DATE,
    MAX("date"::DATE)               AS LAST_OBSERVATION_DATE,
    COUNT(*)                        AS TOTAL_OBSERVATION_DAYS,
    ROUND(AVG("max_temp"), 2)       AS AVG_MAX_TEMP,
    ROUND(AVG("min_temp"), 2)       AS AVG_MIN_TEMP,
    ROUND(AVG("precip"), 2)         AS AVG_DAILY_PRECIP,
    ROUND(AVG("max_wind"), 2)       AS AVG_MAX_WIND,
    MAX("max_temp")                 AS HOTTEST_DAY_TEMP,
    MIN("min_temp")                 AS COLDEST_DAY_TEMP,
    MAX("precip")                   AS WETTEST_DAY_PRECIP
FROM {{ ref('raw_weather') }}
GROUP BY "city"
