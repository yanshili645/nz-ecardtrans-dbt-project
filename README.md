# New Zealand Electronic Card Transactions Analysis (ECT)

## Project Overview
This project builds a modern data pipeline using the **Snowflake, dbt, and GitHub** stack to analyze electronic card transaction trends in New Zealand. The goal is to transform raw monthly transaction data into actionable business insights regarding consumer spending across various industries.

## Tech Stack
*   **Data Warehouse:** Snowflake
*   **Transformation Tool:** dbt (data build tool) Cloud
*   **Version Control:** GitHub
*   **Language:** SQL (Snowflake Dialect)
*   **Data Source:** Stats NZ (Electronic Card Transactions: January 2026)

## Project Structure (dbt)
*   **`models/staging/`**: Initial cleaning of raw data. This is where we rename columns and handle unit conversions (e.g., calculating `actual_amount` using the `magnitude` column).
*   **`models/marts/`**: (Coming in Week 2/3) Final business-ready tables organized in a Star Schema.
*   **`tests/`**: Data quality checks to ensure zero nulls and data integrity.

## Current Progress: Week 1
- [x] Snowflake Database and Warehouse infrastructure setup.
- [x] Connectivity established between Snowflake, dbt Cloud, and GitHub.
- [x] Successful ingestion of raw ECT CSV data into the `RAW` schema.
- [x] Created the first staging model (`stg_transactions`) with calculated transaction values.
- [x] Verified data integrity using dbt test.

## How to Run
To replicate the transformation in your own environment:
1. Ensure your Snowflake credentials are set in dbt Cloud.
2. Run `dbt debug` to check connectivity.
3. Run `dbt run` to build the staging models.
4. Run `dbt test` to verify data quality.

## Data Visualization: NZ Retail Growth Trends
![NZ Ecardtr Growth Chart](NZ%20Ecardtr%20Insights%20Dashboard.png)

*This chart, generated in a Snowflake Notebook, tracks the YoY growth of key sectors using the processed ECT data.*
