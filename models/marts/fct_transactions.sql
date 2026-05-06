with staging as (
    select * from {{ ref('stg_transactions') }}
),

dim_industry as (
    select * from {{ ref('dim_industry') }}
),

final_fact as (
    select
        -- Create a unique key for the transaction row
        md5(s.series_reference || s.transaction_date) as transaction_key,
        s.transaction_date,
        -- Link to our industry dimension using the same hash key
        i.industry_key,
        s.actual_amount,
        s.units
    from staging s
    left join dim_industry i 
        on s.industry = i.industry
            -- Add this to your final_fact CTE
    where s.industry not in ('Total', 'RTS total industries')
)

select * from final_fact