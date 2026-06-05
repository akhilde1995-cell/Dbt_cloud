{{ config(
    materialized='incremental',
    unique_key= 'agent_id',
    incremental_strategy='merge',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

select *
from {{ source('raw_data', 'agents') }}

{% if is_incremental() %}
WHERE hire_date > (SELECT MAX(hire_date) FROM {{ this }})
{% endif %}