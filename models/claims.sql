{{ config(
materialized='incremental',
    unique_key= 'claim_id',
    on_schema_change='append_new_columns',
    incremental_strategy='merge',    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

select 
claim_id,
policy_id,
claim_number,
claim_date,
claim_amount,
approved_amount,
status,
created_at,
case 
    when claim_amount > 0 
    then approved_amount / claim_amount
    else null
end as payout_ratio
from {{ source('raw_data', 'claims') }}

