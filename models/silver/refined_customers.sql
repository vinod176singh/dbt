{{ config(
    materialized='table',
    unique_key='customer_id',
    schema='silver',
    on_schema_change='sync_all_columns'
) }}

SELECT
    c.customer_id,
    c.email,
    c.signup_date,
    c.first_name || ' ' || c.last_name AS full_name,
    c.raw_region AS region,
    rm.region_code
FROM {{ ref('raw_customers') }} c
LEFT JOIN {{ ref('region_mapping') }} rm
    ON c.raw_region = rm.region_name
WHERE {{ filter_by_run_date('c.signup_date') }}
