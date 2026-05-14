{{ config(materialized='view') }}

with raw_data as (
    select * from {{ source('azure_raw', 'nz_geo_areas') }}
)

select
    -- NZ geo areas data processing
    series_reference as series_id,
    period,
    cast(data_value as float) as area_value,
    status,
    group_name as region_name
from raw_data