with staging as (
    select * from {{ ref('stg_transactions') }}
),

unique_industries as (
    select distinct
        -- Generating a unique key for each industry
        md5(industry) as industry_key,
        industry,
        group_name
    from staging
    where industry is not null
)

select * from unique_industries