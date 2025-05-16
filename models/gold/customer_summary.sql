{{config(
    materialized='table',
    schema='gold'
)}}

select region,count(distinct customer_id) as customer_count from 
{{ref('refined_customers')}}
group by region