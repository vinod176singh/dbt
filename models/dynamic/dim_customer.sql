-- Auto-generated model: dim_customer
{{ config(materialized='table') }}

SELECT customer_id,first_name,last_name,email
FROM {{ source('bronze', 'customers') }}