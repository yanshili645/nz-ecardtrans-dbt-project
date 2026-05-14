{{ config(materialized='view') }}

-- Refer to the source defined in models/retailnz/sources.yml
with raw_data as (
    select * from {{ source('azure_raw', 'card_transactions') }}
),

renamed as (
    select
        -- Primary key and date
        series_reference as series_id,
        period,
        
        -- Data conversion
        cast(data_value as float) as transaction_value,
        
        -- Dimension info
        status,
        units,
        subject,
        group_name as industry_group,
        series_title_1 as category_l1,
        series_title_2 as category_l2
    from raw_data
)

select * from renamed