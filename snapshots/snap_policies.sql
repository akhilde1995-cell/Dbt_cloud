  {% snapshot snap_policies %}
  {{
      config(
        target_schema = 'DBT_AP',
        unique_key = 'policy_id',
        strategy = 'check',
        check_cols = ['agent_id','vehicle_id','policy_type','end_date','premium_amount','status']
      )
  }}

  select *
  from {{ ref('policies') }}

  {% endsnapshot %}