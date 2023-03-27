{% macro run_test_prior(model_name) -%}
    {{log('models.' ~ model_name, info=true)}}
    {%- if execute -%}
    {%- set nodes = graph.nodes.values() -%}
    
    {%- set model = (nodes
        | selectattr('name', 'equalto', model_name) 
        | selectattr('resource_type', 'equalto', 'model')
        | list).pop() -%}

    {%- set model_raw_sql = model.raw_code -%}
    {%- else -%}
    {%- set model_raw_sql = '' -%}
    {%- endif -%}
    
    {%- set model_raw_sql = model_raw_sql ~ ' where ' -%}
    /*{{ log(model_raw_sql, info=true) }}*/


    {% for node in nodes | selectattr('resource_type', 'equalto', 'test') | selectattr('file_key_name', 'equalto', 'models.' ~ model_name) %}
       /*{{ log(node.raw_code, info=true) }}*/
       --{%- set model_raw_sql = model_raw_sql ~ node.raw_code | replace('**_dbt_generic_test_kwargs', model_name ~ ',' ~ node.test_metadata.kwargs.column_name) -%}
       {%- set where_sql = node.raw_code | replace('**_dbt_generic_test_kwargs', "'" ~ model_name ~ "'," ~ "'" ~ node.test_metadata.kwargs.column_name ~ "'") -%}
       {{ log(where_sql, info=true) }}
       /*{{ log(model_raw_sql ~ node.raw_code | replace('**_dbt_generic_test_kwargs', "'" ~ model_name ~ "'," ~ "'" ~ node.test_metadata.kwargs.column_name ~ "'"), info=true) }}*/
    {% endfor %}

{%- endmacro %}
