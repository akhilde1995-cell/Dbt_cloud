{% snapshot snap_agents %}
{{
    config(
      target_schema = 'DBT_AP',
      unique_key = 'agent_id',
      strategy = 'check',
      check_cols = ['agent_name','region','hire_date','status']
    )
}}

select *
from {{ ref('agents') }}

{% endsnapshot %}