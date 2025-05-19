{{
    config(materialized='table',
    schema='gold'
    )
}}
select * from {{ ref('dq_inspector', 'dim_patient_features') }}