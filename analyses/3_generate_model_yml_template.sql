-- Compile
{{ 
    codegen.generate_model_yaml(
        model_names=['stg_region','stg_province'],
        upstream_descriptions=True
    )
}}