{% macro generate_dimension_models() %}
    {% set metadata = load_relation('seed', 'dimension_metadata') %}
    {% for row in metadata %}
        {% set model_name = row['model_name'] %}
        {% set source_table = row['source_table'] %}
        {% set columns = row['columns'].split(',') %}
        
        -- Write to a file using dbt’s built-in capabilities
        {{ return({
          "name": model_name,
          "materialization": "table",
          "sql": "SELECT " ~ columns | join(', ') ~ " FROM " ~ source_table
        }) }}
    {% endfor %}
{% endmacro %}
