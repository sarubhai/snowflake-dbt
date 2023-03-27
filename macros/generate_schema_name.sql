{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        
        {{ log("Cond1: " ~ target.name ~ " : " ~ default_schema, True) }}
        {{ default_schema }}
        
    {%- elif target.name == 'prod' -%}
        
        {{ log("Cond2: " ~ target.name ~ " : " ~ custom_schema_name, True) }}
        {{ custom_schema_name | trim }}

    {%- else -%}
        
        {{ log("Cond3: " ~ target.name ~ " : " ~ default_schema ~ "_" ~ custom_schema_name, True) }}
        {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}
