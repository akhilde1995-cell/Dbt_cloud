{{ config(
    schema='dw',
    materialized='table',
   pre_hook="{{ log_model_start() }}",
    post_hook="{{ log_model_success() }}"
) }}

SELECT

COUNT(DISTINCT p.policy_id) AS total_policies,
SUM(p.premium_amount) AS total_premium,
COUNT(c.claim_id) AS total_claims,
SUM(c.claim_amount) AS total_claim_amount,
SUM(c.approved_amount) AS total_payout,
SUM(c.approved_amount)/SUM(p.premium_amount) AS loss_ratio

FROM {{ ref('fact_policies') }} p
LEFT JOIN {{ ref('fact_claims') }} c
ON p.policy_id = c.policy_id