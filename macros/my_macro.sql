{% macro my_custom_format_date(column_name) %}
    to_char({{ column_name }}, 'YYYY-MM-DD')
{% endmacro %}
