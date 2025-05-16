{{ config(materialized='table') }}

{{ generate_dimension_model(
    source_table='raw_customers',
    columns='customer_id, customer_name, signup_date',
    filter="is_active = true"
) }}
