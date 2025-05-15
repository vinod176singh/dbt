{{ config(materialized='table') }}

-- Generate a date range using Snowflake's GENERATOR
select
    dateadd(day, seq4(), to_date('2000-01-01')) as date_day
from table(generator(rowcount => 18628))  -- ~51 years of days
