with source as (
    select * from {{ source('raw_data', 'RAW_TRANSACTIONS') }}
),

renamed as (
    select
        series_reference,
        period,
        data_value,
        units,
        magnitude,
        -- Creating a calculated column for the actual value
        (data_value * power(10, magnitude)) as actual_amount,
        series_title_1 as group_name,
        series_title_2 as industry
    from source
)

select * from renamed