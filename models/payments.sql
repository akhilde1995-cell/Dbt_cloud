{{ config(
    materialized='incremental',
    unique_key= 'payment_id',
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

select *
from {{ source('raw_data', 'payments') }}

