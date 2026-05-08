with fct_transactions as (
    select * from {{ ref('fct_transactions') }}
),

dim_industry as (
    select * from {{ ref('dim_industry') }}
),

monthly_summary as (
    -- Aggregate spending by industry and month
    select
        i.industry,
        f.transaction_date,
        sum(f.actual_amount) as monthly_spending
    from fct_transactions f
    join dim_industry i on f.industry_key = i.industry_key
    group by 1, 2
),

growth_calc as (
    select
        industry,
        transaction_date,
        monthly_spending,
        -- Get the spending from exactly 12 months ago
        lag(monthly_spending, 12) over (partition by industry order by transaction_date) as prev_year_spending
    from monthly_summary
)

select
    *,
    -- Calculate the percentage growth
    round(
        (monthly_spending - prev_year_spending) / nullif(prev_year_spending, 0) * 100, 
        2
    ) as yoy_growth_pct
from growth_calc