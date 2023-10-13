{{
    config(
        database = 'cdc_demo',
        schema = 'stg_db',
        query_tag = 'dbt_cdc_demo',
        materialized = 'incremental',
        unique_key = 'userid',
        incremental_strategy = 'merge',
        merge_exclude_columns = ['prev_status','kafka_created_at','sf_created_at'],
        on_schema_change = 'fail'
    )
}}

with
    source as (

        select
            * 
        from {{ source("cdc_demo_raw", "raw_users") }}
    ),

    renamed as (

        select
            userid as userid,
            name as name,
            address as address,
            status as status, 
            kafka_partition as kafka_partition,
            kafka_offset as kafka_offset,
            min(kafka_timestamp) over (partition by userid) as kafka_created_at,
            max(kafka_timestamp) over (partition by userid) as kafka_updated_at,
            row_number() over (partition by userid order by kafka_timestamp desc) as desc_rnk,
            row_number() over (partition by userid order by kafka_timestamp asc) as asc_rnk
        from source
    ),

    oldstatus as (

        select
            userid as user_id,
            status as prev_status
        from renamed
        where asc_rnk = 1
    ),

    deduplicated as (

        select
            userid,
            name,
            address,
            prev_status,
            status as curr_status,
            kafka_partition,
            kafka_offset,
            kafka_created_at,
            kafka_updated_at,
            CURRENT_TIMESTAMP as sf_created_at,
            CURRENT_TIMESTAMP as sf_updated_at
        from renamed
        inner join oldstatus
        on renamed.userid = oldstatus.user_id
        where desc_rnk = 1
    ),

    {% if is_incremental() %}
        tgt as (
            
            select 
                kafka_partition, max(kafka_updated_at) as kafka_updated_at
            from {{ this }}
            group by kafka_partition
        ),
    {% endif %}

    final as (

        select 
            src.*
        from deduplicated as src

        {% if is_incremental() %}
            INNER JOIN tgt
            ON src.kafka_partition = tgt.kafka_partition
            AND src.kafka_updated_at > tgt.kafka_updated_at
            
            -- NEW PARTITIONS
            UNION ALL
            select
               src.*
            from deduplicated as src
            where not exists (
                select
                    1 
                from tgt
                where src.kafka_partition = tgt.kafka_partition)
        {% endif %}
    )
select *
from final
