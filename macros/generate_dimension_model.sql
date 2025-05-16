{% macro generate_dimension_model(source_table, columns, filter) %}
SELECT {{ columns }}
FROM {{ ref(source_table) }}
WHERE {{ filter }}
{% endmacro %}