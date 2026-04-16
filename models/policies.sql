{{ config(
    materialized='incremental',
    unique_key= 'policy_id',
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

select 
    POLICY_ID,
    POLICY_NUMBER,
    CUSTOMER_ID,
    AGENT_ID,
    VEHICLE_ID,
    POLICY_TYPE,
    start_date,
    end_date,
    DATEDIFF(day, start_date, end_date) AS policy_duration_days,
    PREMIUM_AMOUNT,
    STATUS,
    CREATED_AT
from {{ source('raw_data', 'policies') }}

{% if is_incremental() %}
where created_at >
        (SELECT MAX(created_at) FROM {{ this }})
    {% endif %}