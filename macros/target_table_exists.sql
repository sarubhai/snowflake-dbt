{% macro target_table_exists(table_name) -%}
    {%- set source_relation = adapter.get_relation(
        database=target.database,
        schema=target.schema,
        identifier=table_name
    ) -%}

    {% set table_exists=source_relation is not none %}

    {% if table_exists %}
        {{ log("Table " ~ table_name ~ " exists.", info=true) }}
        return True
    {% else %}
        {{ log("Table " ~ table_name ~ " doesn't exists.", info=true) }}
        return False
    {% endif %}
{%- endmacro %}
