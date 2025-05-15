-- models/silver/customer_orders.sql

with base as (
    select
        customer_id,
        order_id,
        order_date,
        amount
    from {{ ref('raw_orders') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_id']) }} as customer_order_sk,
    *
from base
