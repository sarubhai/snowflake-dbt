-- Compile
{{
    codegen.generate_source(
        name='secondary_sales',
        database_name='raw',
        schema_name='sec_sales',
        table_names=['region', 'province'],
        generate_columns=True,
        include_descriptions=True,
    ) 
}}