{{config(
    materialized='table',
    schema='bronze'
)}}
SELECT *
FROM {{ source('bronze', 'raw_customers') }}
