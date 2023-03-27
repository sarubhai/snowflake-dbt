{% set profile = dbt_profiler.get_profile(relation=source("secondary_sales", "province")) %}
{% for row in profile.rows %}
  {% do log(row.values(), info=True) %}
{% endfor %}