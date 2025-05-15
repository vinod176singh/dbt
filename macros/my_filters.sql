{% macro filter_by_status(status='active') %}
    status = '{{ status }}'
{% endmacro %}
