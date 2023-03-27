with
    source as (select * from {{ source("secondary_sales", "distributor_type") }}),

    renamed as (

        select
            distributor_type_code as distributor_type_code,
            distributor_type_desc_eng as distributor_type_desc_eng,
            distributor_type_desc_chn as distributor_type_desc_chn,
            etl_loaded_at as etl_loaded_at
        from source

    )
select *
from renamed
