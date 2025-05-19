{% snapshot customers_snapshot %}

{{
  config(
    target_schema='silver',
    unique_key='customer_id',
    strategy='check',
    check_cols=['raw_region']
  )
}}

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    raw_region,
    signup_date
FROM {{ source('bronze', 'raw_customers') }}

{% endsnapshot %}
