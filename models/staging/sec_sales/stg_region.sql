with
    source as (select * from {{ source("secondary_sales", "region") }}),

    renamed as (

        select
            region_code as region_code,
            region_desc_eng as region_desc_eng,
            region_desc_chn as region_desc_chn,
            etl_loaded_at as etl_loaded_at
        from source

    )
select *
from renamed
