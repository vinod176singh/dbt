{{ config(materialized='incremental') }}

SELECT
    order_id,
    customer_id,
    order_date,
    amount,
    status
FROM {{ source('bronze', 'orders') }}
WHERE {{ filter_by_run_date('order_date') }}
