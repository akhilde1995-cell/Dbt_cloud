{% macro incremental_where(column_name) %}
    {% if is_incremental() %}
         {{ column_name }} >
            (SELECT MAX({{ column_name }}) FROM {{ this }})
    {% endif %}
{% endmacro %}
