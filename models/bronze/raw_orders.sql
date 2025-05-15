{{config(
    materialized='table',
    schema='bronze'
)}}
SELECT *
FROM {{ source('bronze', 'orders') }}
