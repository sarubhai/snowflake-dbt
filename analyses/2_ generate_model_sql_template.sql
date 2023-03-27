-- Compile
{{
    codegen.generate_base_model(
        source_name='secondary_sales',
        table_name='region',
        materialized='table'
    )
}}