{{ config(
    materialized='incremental',
    unique_key= 'customer_id',
    on_schema_change='append_new_columns',
    incremental_strategy='merge'
    
) }}

select *
from {{ source('raw_data', 'customers') }}

{% if is_incremental() %}
where created_at  >
            (SELECT MAX({{ created_at }}) FROM {{ this }})
    {% endif %}


    