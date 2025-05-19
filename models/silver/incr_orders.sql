{{ config(
    materialized='incremental',
    unique_key='order_id',
    schema='silver',
    on_schema_change='sync_all_columns'
) }}

SELECT
    order_id,
    customer_id,
    amount,
    status,
    created_at,
    LAST_UPDATED
FROM {{ source('bronze', 'raw_orders') }}

{% if is_incremental() %}
WHERE created_at > COALESCE((SELECT MAX(created_at) FROM {{ this }}), '1900-01-01')
{% endif %}
