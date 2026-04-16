{% macro log_model_start() %}

INSERT INTO {{ target.database }}.{{ target.schema }}.audit_log
(
    run_id,
    model_name,
    status,
    start_time,
    No_of_rows
)
VALUES
(
    '{{ invocation_id }}',
    '{{ this.name }}',
    'START',
    CURRENT_TIMESTAMP,
    0
);

{% endmacro %}

{% macro log_model_success() %}

UPDATE {{ target.database }}.{{ target.schema }}.audit_log
SET
    status = 'SUCCESS',
    end_time = CURRENT_TIMESTAMP,
    No_of_rows = (SELECT COUNT(*) FROM {{ this }})
WHERE
    run_id = '{{ invocation_id }}'
    AND model_name = '{{ this.name }}';

{% endmacro %}