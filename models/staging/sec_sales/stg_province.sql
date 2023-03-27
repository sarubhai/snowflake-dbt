with
    source as (select * from {{ source("secondary_sales", "province") }}),

    renamed as (

        select
            province_code as province_code,
            province_desc_eng as province_desc_eng,
            province_desc_chn as province_desc_chn,
            region_code as region_code,
            etl_loaded_at as etl_loaded_at
        from source

    )
select *
from renamed
