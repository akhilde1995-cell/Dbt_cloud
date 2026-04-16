{{ config(
    schema='dw',
    materialized='incremental',
    unique_key=['policy_id','customer_id','agent_id','vehicle_id'],
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT
policy_id,
customer_id,
agent_id,
vehicle_id,
premium_amount,
policy_duration_days,
status

FROM {{ ref('dim_policies') }}