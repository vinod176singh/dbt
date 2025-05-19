{{ 
    config(materialized='table', schema='gold') 
}}

{{ dq_inspector.generate_feature_vector('dim_patient_features', ['patient_id', 'avg_dosage']) }}
