{% macro create_dynamic_models() %}
{%- set rows = load_csv('data/dimension_config.csv')[1:] -%}

{%- for row in rows %}
  {% set sql %}
    {{ generate_dimension_model(row['model_name'], row['source_table'], row['columns']) }}
  {% endset %}

  {% do write_file('models/dynamic/' ~ row['model_name'] ~ '.sql', sql) %}
  {{ log('✅ Created model for ' ~ row['model_name'], info=True) }}
{%- endfor %}
{% endmacro %}
