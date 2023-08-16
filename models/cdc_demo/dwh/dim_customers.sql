{{
    config(
        database = 'cdc_demo',
        schema = 'dwh_db',
        query_tag = 'dbt_cdc_demo',
        materialized = 'incremental',
        unique_key = 'customerid',
        incremental_strategy = 'merge',
        merge_exclude_columns = ['sf_created_at'],
        on_schema_change = 'fail'
    )
}}

with
    source as (select * from {{ ref("stg_customers") }}),

    transform as (

        select
            customerid,
            name,
            dob,
            CASE
                WHEN DATEDIFF(year, dob, CURRENT_TIMESTAMP) < 25 THEN '<25'
                WHEN DATEDIFF(year, dob, CURRENT_TIMESTAMP) BETWEEN 25 AND 35 THEN '25-35'
                WHEN DATEDIFF(year, dob, CURRENT_TIMESTAMP) BETWEEN 35 AND 45 THEN '35-45'
                WHEN DATEDIFF(year, dob, CURRENT_TIMESTAMP) BETWEEN 45 AND 55 THEN '45-55'
                WHEN DATEDIFF(year, dob, CURRENT_TIMESTAMP) BETWEEN 55 AND 65 THEN '55-65'
                ELSE '>65'
            END as age_bins,
            gender,
            marital_status,
            address,
            postcode,
            CASE WHEN deleted_at IS NULL THEN false ELSE true END as is_deleted,
            sf_created_at as ups_created_at,
            sf_updated_at as ups_updated_at,
            -- Change below two from -2, -1 and 0 for 1st, 2nd, 3rd Run to simulate 3 consecutive loading days
            DATEADD(DAY, 0, CURRENT_TIMESTAMP) as sf_created_at,
            DATEADD(DAY, 0, CURRENT_TIMESTAMP) as sf_updated_at
        from source
        {% if is_incremental() %}
            where (
                sf_created_at > (select nvl(max(ups_created_at), '1900-01-01') from {{ this }}) OR
                sf_updated_at > (select nvl(max(ups_updated_at), '1900-01-01') from {{ this }})
            )
        {% endif %}
    )
select *
from transform
