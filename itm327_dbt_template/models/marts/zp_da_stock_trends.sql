-- stock_news_daily_zp
 -- Mart 1: stocks trending up
 -- One row per symbol per day
 -- For the data analyst

SELECT s.SYMBOL,
 s.TRADE_DATE,
 s.OPEN, 
s.CLOSE, 
s.PCT_CHANGE,
 s.DIRECTION,
s.VOLUME
 FROM
 {{ ref('fct_daily_stocks') }} s
