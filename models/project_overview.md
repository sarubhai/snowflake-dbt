{% docs __snowflake_dwh__ %}

# Snowflake DWH
---
This DBT project contains all the models relevant to transform the raw data to business insights.

## Subject Area
---
| Option.         | Description |
| --------------- | ----------- |
| Primary Sales   | Primary Sales to Big Retail Chains. |
| Secondary Sales | Secondary Sales by Distributors to Medium/Small Retailers. |
| Inverntory      | Inventory Stock In/Out. |
| Route Plan      | Salesman Route Plan. |
| Sales Budget    | Sales Budget. |
| Sales Forecast  | Sales Forecast. |

{% enddocs %}


{% docs __dbt_utils__ %}

# Utility macros
---
This dbt package provides some helpful utility Macros, especially:
- `surrogate_key`
- `test_equality`
- `pivot`

{% enddocs %}


{% docs __audit_helper__ %}

# Audit Helper
---
This dbt package provides some helpful Macros for performing data auditing:
- `compare_relations`
- `compare_relation_columns`

{% enddocs %}


{% docs __codegen__ %}

# Codegen Macros
---
This dbt package provides some helpful Macros that generate dbt code, and log it to the command line, to speed up dbt development:
- `generate_source`
- `generate_base_model`
- `generate_model_yaml`

{% enddocs %}


{% docs __metrics__ %}

# Metrics Macros
---
This dbt package generates queries based on Metrics
- `calculate`
- `develop`
- `period_to_date`

{% enddocs %}


{% docs __dbt_constraints__ %}

# Snowflake Constraints
---
This package generates database constraints based on the tests in a dbt project
- `primary_key`
- `unique_key`
- `foreign_key`

{% enddocs %}


{% docs __dbt_snow_mask__ %}

# Snowflake Masking
---
This package contains macros that can be used with snowflake, to apply Dynamic Data Masking using dbt meta.
- `create_masking_policy`
- `apply_masking_policy`

{% enddocs %}


{% docs __dbt_profiler__ %}

# DBT Profiler
---
This package helps to provide Data Profiling information about Sources & Models.
- `get_profile`

{% enddocs %}


{% docs __dbt_meta_testing__ %}

# DBT Meta Testing
---
This dbt package contains macros to assert test and documentation coverage
- `required_tests`
- `required_docs`

{% enddocs %}


{% docs __elementary__ %}

# Elementary
---
This dbt package contains macros to monitor your data quality, operation and performance directly from dbt project.

{% enddocs %}
