{{
    config(
        database = 'cdc_demo',
        schema = 'stg_db',
        query_tag = 'dbt_cdc_demo',
        materialized = 'incremental',
        unique_key = 'customerid',
        incremental_strategy = 'merge',
        merge_exclude_columns = ['sf_created_at'],
        on_schema_change = 'fail'
    )
}}

with
    source as (select * from {{ source("cdc_demo_raw", "raw_customers") }}),

    renamed as (

        select
            customerid as customerid,
            name as name,
            dob as dob,
            gender as gender,
            marital_status as marital_status,
            address as address,
            postcode as postcode,
            created_at as created_at,
            updated_at as updated_at,
            deleted_at as deleted_at,
            etl_loaded_at as etl_loaded_at,
            -- Change below two from -2, -1 and 0 for 1st, 2nd, 3rd Run to simulate 3 consecutive loading days
            DATEADD(DAY, 0, CURRENT_TIMESTAMP) as sf_created_at,
            DATEADD(DAY, 0, CURRENT_TIMESTAMP) as sf_updated_at
        from source
        {% if is_incremental() %}
            where etl_loaded_at > (select nvl(max(etl_loaded_at), '1900-01-01') from {{ this }})
        {% endif %}
    )
select *
from renamed
