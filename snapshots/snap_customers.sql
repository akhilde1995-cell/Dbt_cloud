{% snapshot snap_customers %}
{{
    config(
      target_schema = 'DBT_AP',
      unique_key = 'customer_id',
      strategy = 'check',
      check_cols = ['email','city','state']
    )
}}

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
FROM {{ ref('customers') }}

{% endsnapshot %}