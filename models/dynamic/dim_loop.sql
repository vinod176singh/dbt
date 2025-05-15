{% set metadata = [
    {"model_name": "dim_customer", "source_table": "bronze.customers", "columns": "customer_id,first_name,last_name,email"},
    {"model_name": "dim_product", "source_table": "bronze.products", "columns": "product_id,product_name,category"}
] %}

{% for row in metadata %}
-- {{ row.model_name }}
{{ config(materialized='table') }}

SELECT
    {{ row.columns }}
FROM {{ source(row.source_table.split('.')[0], row.source_table.split('.')[1]) }}

{% endfor %}

