{% macro filter_by_run_date(column_name='order_date') %}
    {% set run_date = var('run_date', none) %}

    {% if run_date is not none %}
        {{ column_name }} = '{{ run_date }}'
    {% else %}
        {{ column_name }} >= DATEADD(day, -30, CURRENT_DATE)
    {% endif %}
{% endmacro %}
