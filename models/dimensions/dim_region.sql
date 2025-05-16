{{ config(materialized='table') }}

{{ generate_dimension_model(
    source_table='raw_regions',
    columns='region_id, region_name',
    filter="region_name IS NOT NULL"
) }}
