{{ config(
    materialized='table',
    schema='gold'
) }}

WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.email,
        c.region_code,
        COUNT(o.order_id) AS total_orders,
        SUM(o.amount) AS total_spent,
        MAX(o.LAST_UPDATED) AS last_order_date,
        {{ dbt_utils.generate_surrogate_key(['c.customer_id', 'c.email']) }} AS customer_hash
    FROM {{ ref('refined_customers') }} c
    LEFT JOIN {{ ref('incr_orders') }} o
      ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.email, c.region_code
)

SELECT * FROM customer_orders
