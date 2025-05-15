{{ config(materialized='table') }}

with dates as (
    select
        date_day,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day
    from {{ ref('date_spine') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_key,
        *
    from dates
)

select * from final
