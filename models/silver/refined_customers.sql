{{ config(
    materialized='table',
    schema='silver'
) }}

SELECT
    c.customer_id,
    c.email,
    c.signup_date,
    c.first_name || ' ' || c.last_name AS full_name,
    c.raw_region as region,
    rm.region_code
FROM {{ ref('raw_customers') }} c
LEFT JOIN {{ ref('region_mapping') }} rm
    ON c.raw_region = rm.region_name
