{{ config(
    materialized='incremental',
    unique_key='policy_id',
    incremental_strategy='merge',
    schema='dw',
    on_schema_change='append_new_columns',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT
    policy_id,
    policy_number,
    customer_id,
    agent_id,
    vehicle_id,
    policy_type,
    start_date,
    end_date,
    DATEDIFF(day, start_date, end_date) AS policy_duration_days,
    premium_amount,
    status,
    created_at,
    dbt_valid_from,
    dbt_valid_to

FROM {{ ref('snap_policies') }}
WHERE dbt_valid_to IS NULL