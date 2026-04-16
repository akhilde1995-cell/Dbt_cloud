{{ config(
    schema='dw',
    materialized='incremental',
    unique_key=['claim_id','policy_id'],
    on_schema_change='append_new_columns',
    incremental_strategy='merge',
    pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT
claim_id,
policy_id,
claim_amount,
approved_amount,
payout_ratio

FROM {{ ref('claims') }}