with
    source as (select * from {{ source("secondary_sales", "distributor") }}),

    renamed as (

        select
            distributor_code as distributor_code,
            distributor_name_chn as distributor_name_chn,
            address1_chn as address1_chn,
            address2_chn as address2_chn,
            address3_chn as address3_chn,
            sub_urban as sub_urban,
            province_code as province_code,
            district as district,
            postcode as postcode,
            email as email,
            phone_number as phone_number,
            fax_number as fax_number,
            mobile_number as mobile_number,
            distributor_type_code as distributor_type_code,
            contact_first_name as contact_first_name,
            contact_last_name as contact_last_name,
            contact_person_title as contact_person_title,
            operating_company_id as operating_company_id,
            etl_loaded_at as etl_loaded_at
        from source

    )
select *
from renamed
