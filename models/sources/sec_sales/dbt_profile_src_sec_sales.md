{% docs dbt_profiler__province %}

| COLUMN_NAME       | DATA_TYPE     | ROW_COUNT | NOT_NULL_PROPORTION | DISTINCT_PROPORTION | DISTINCT_COUNT | IS_UNIQUE | MIN                     | MAX                     | AVG | STD_DEV_POPULATION | STD_DEV_SAMPLE | PROFILED_AT                   |
| ----------------- | ------------- | --------- | ------------------- | ------------------- | -------------- | --------- | ----------------------- | ----------------------- | --- | ------------------ | -------------- | ----------------------------- |
| province_code     | text          | 4         | 1.000000            | 1.000000            | 4              | TRUE      |                         |                         |     |                    |                | 2023-02-21 12:58:05.254 -0800 |
| province_desc_eng | text          | 4         | 1.000000            | 1.000000            | 4              | TRUE      |                         |                         |     |                    |                | 2023-02-21 12:58:05.254 -0800 |
| province_desc_chn | text          | 4         | 1.000000            | 1.000000            | 4              | TRUE      |                         |                         |     |                    |                | 2023-02-21 12:58:05.254 -0800 |
| region_code       | text          | 4         | 1.000000            | 0.250000            | 1              | FALSE     |                         |                         |     |                    |                | 2023-02-21 12:58:05.254 -0800 |
| etl_loaded_at     | timestamp_ntz | 4         | 1.000000            | 1.000000            | 4              | TRUE      | 2023-02-21 02:52:22.953 | 2023-02-21 02:52:24.416 |     |                    |                | 2023-02-21 12:58:05.254 -0800 |

{% enddocs %}
