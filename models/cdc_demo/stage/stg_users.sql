{{
    config(
        database = 'cdc_demo',
        schema = 'stg_db',
        query_tag = 'dbt_cdc_demo',
        materialized = 'incremental',
        unique_key = 'userid',
        incremental_strategy = 'merge',
        merge_exclude_columns = ['sf_created_at'],
        on_schema_change = 'fail'
    )
}}

with
    source as (select * from {{ source("cdc_demo_raw", "raw_users") }}),

    renamed as (

        select
            userid as userid,
            name as name,
            address as address,
            kafka_partition as kafka_partition,
            kafka_offset as kafka_offset,
            kafka_timestamp as kafka_timestamp,
            CURRENT_TIMESTAMP as sf_created_at,
            CURRENT_TIMESTAMP as sf_updated_at
        from source
    ),

    final as (
        select 
            src.*
        from renamed as src
        {% if is_incremental() %}
            INNER JOIN
            (
                select kafka_partition, max(kafka_timestamp) as kafka_timestamp from {{ this }} group by kafka_partition
            ) tgt
            ON src.kafka_partition = tgt.kafka_partition AND src.kafka_timestamp > tgt.kafka_timestamp
            
            -- NEW PARTITIONS
            UNION ALL
            select
               src.*
            from renamed as src
            where not exists (select 1 from {{ this }} as tgt where src.kafka_partition = tgt.kafka_partition)
        {% endif %}
    )
select *
from final
