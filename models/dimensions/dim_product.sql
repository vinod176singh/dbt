{{ config(materialized='table') }}

{{ generate_dimension_model(
    source_table='raw_products',
    columns='product_id, product_name, price',
    filter="is_available = true"
) }}
