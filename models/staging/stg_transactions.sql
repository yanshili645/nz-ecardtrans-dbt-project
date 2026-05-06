with source as (
    select * from {{ source('raw_data', 'RAW_TRANSACTIONS') }}
),

renamed as (
    select
        series_reference,
        -- Converting float period (YYYY.MM) to a DATE
        try_to_date(
            floor(period)::varchar || '-' || 
            lpad(round((period - floor(period)) * 100), 2, '0') || '-01'
        ) as transaction_date,
        data_value,
        units,
        magnitude,
        -- Ensure we handle nulls by defaulting to 0, then apply magnitude scaling
        (coalesce(data_value, 0) * power(10, coalesce(magnitude, 0))) as actual_amount,
        series_title_1 as group_name,
        series_title_2 as industry
    from source
)

select * from renamed