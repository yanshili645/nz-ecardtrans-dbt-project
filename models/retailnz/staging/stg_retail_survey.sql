{{ config(materialized='view') }}

with raw_data as (
    select * from {{ source('azure_raw', 'retail_survey') }}
)

select
    -- RTS data processing
    series_reference as series_id,
    period,
    cast(data_value as float) as sales_value,
    status,
    lower(subject) as survey_subject,
    group_name as industry_category
from raw_data