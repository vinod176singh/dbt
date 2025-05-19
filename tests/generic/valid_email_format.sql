{% test valid_email_format(model, column_name) %}
SELECT *
FROM {{ model }}
WHERE NOT REGEXP_LIKE({{ column_name }}, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
{% endtest %}
