{{config(
    materialized='table',
    schema='gold'
)}}

select region_code,count(distinct customer_id) as customer_count from 
{{ref('refined_customers')}}
group by region_code