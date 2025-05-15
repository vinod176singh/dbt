-- Auto-generated model: dim_product
{{ config(materialized='table') }}

SELECT product_id,product_name,category
FROM {{ source('bronze', 'products') }}