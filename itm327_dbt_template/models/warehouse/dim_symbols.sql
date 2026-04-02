-- dim_symbols
-- Dimension table: one row per unique stock symbol.
-- Contains descriptive attributes about each ticker derived from the trading history.
--
-- In a production DW you would enrich this with a reference API (e.g., company name,
-- sector, market cap). For this project we derive what we can from the data we have.
--
-- TODO: If you have access to a symbol reference table or API, join it here to add
--       COMPANY_NAME, SECTOR, INDUSTRY, etc.

SELECT
    SYMBOL,
    MIN(TRADE_DATE)            AS FIRST_SEEN_DATE,
    MAX(TRADE_DATE)            AS LAST_SEEN_DATE,
    COUNT(*)                   AS TOTAL_TRADING_DAYS,
    MAX(HIGH)                  AS ALL_TIME_HIGH,
    MIN(LOW)                   AS ALL_TIME_LOW,
    AVG(CLOSE)                 AS AVG_CLOSE_PRICE,
    AVG(VOLUME)                AS AVG_DAILY_VOLUME
FROM {{ ref('raw_stocks') }}
GROUP BY SYMBOL
