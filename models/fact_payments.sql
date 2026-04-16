{{ config(
    schema='dw',
    materialized='incremental',
    unique_key=['payment_id','policy_id'],
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
     pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT
payment_id,
policy_id,
payment_date,
amount

FROM {{ ref('payments') }}