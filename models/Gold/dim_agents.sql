{{ config(
    materialized='incremental',
    unique_key= 'agent_id',
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
    schema ='DW',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT
    agent_id,
    agent_name,
    region,
    hire_date,
    status,
    dbt_valid_from,
    dbt_valid_to
FROM {{ ref('snap_agents') }}
WHERE dbt_valid_to IS NULL