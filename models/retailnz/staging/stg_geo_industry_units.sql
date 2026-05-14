{{ config(materialized='view') }}

with raw_data as (
    select * from {{ source('azure_raw', 'geo_industry_units') }}
)

select
    -- Data processing
    series_reference as series_id,
    period,
    cast(data_value as float) as unit_count,
    status,
    units,
    group_name as industry_group
from raw_data