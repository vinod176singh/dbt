{{ config(
    materialized='table',
    schema='silver'
) }}

SELECT
    customer_id,
    email,
    signup_date,
    first_name || ' ' || last_name AS full_name,
    raw_region AS region
FROM {{ source('bronze', 'raw_customers') }}
