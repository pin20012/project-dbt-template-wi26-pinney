from snowflake.snowpark.functions import col, avg, count, lit
from snowflake.snowpark.functions import when

# For the Data Scientist
# Question: to see if days that had news coverage affected stocks


def model(dbt, session):
    """
    Snowpark Python model: One symbol per row per day

    Demonstrates dbt Python models using Snowpark DataFrames instead of SQL.

    Output: 
    """
    
    stocks_df = dbt.ref('fct_daily_stocks')

    # Compute derived columns before aggregation
    stocks_with_metrics = stocks_df.withColumn(
    'HAD_NEWS', when(col('NEWS_ARTICLE_COUNT') > lit(0), lit('YES')).otherwise(lit('NO'))
)

    # Aggregate per symbol across all trading days
    summary = (
        stocks_with_metrics
        .groupBy('SYMBOL', 'TRADE_DATE')
        .agg(
            avg('PCT_CHANGE').alias('AVG_PCT_CHANGE'),
            count('NEWS_ARTICLE_COUNT').alias('ARTICLES_NEWS_COUNT'),
            avg(when(col('HAD_NEWS') == lit('YES'), lit(1)).otherwise(lit(0))).alias('HAD_NEWS')
        )
    )

    return summary
