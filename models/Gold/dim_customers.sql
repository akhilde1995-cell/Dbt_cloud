{{ config(
    materialized='incremental',
    unique_key= 'customer_id',
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
    schema ='DW',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT
    customer_id,
    first_name,
    last_name,
    dob,
    gender,
    email,
    phone,
    address,
    city,
    state,
    created_at
FROM {{ ref('snap_customers') }}
WHERE dbt_valid_to IS NULL