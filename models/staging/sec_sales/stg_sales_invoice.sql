with
    source as (select * from {{ source("secondary_sales", "sales_invoice") }}),

    renamed as (

        select
            sales_invoice_date as sales_invoice_date,
            distributor_code as distributor_code,
            customer_code as customer_code,
            product_code as product_code,
            sales_type as sales_type,
            doc_number as doc_number,
            gross_sales_quantity as gross_sales_quantity,
            gross_sales_amount as gross_sales_amount,
            sales_return_qty as sales_return_qty,
            sales_return_amount as sales_return_amount,
            discount_promotion as discount_promotion,
            discount_unconditional_discount as discount_unconditional_discount,
            discount_settlement as discount_settlement,
            cogs as cogs,
            base_price_amount as base_price_amount,
            uom_code as uom_code,
            salesman_code as salesman_code,
            etl_loaded_at as etl_loaded_at
        from source

    )
select *
from renamed
