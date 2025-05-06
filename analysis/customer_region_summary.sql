-- analysis/customer_region_code_summary.sql

-- 📊 Customer region_code Summary (last 3 months)

WITH base AS (
    SELECT
        customer_id,
        region_code,
        signup_date
    FROM {{ ref('refined_customers') }}
),

recent_customers AS (
    SELECT *
    FROM base
    WHERE signup_date >= DATEADD(month, -3, CURRENT_DATE)
),

summary AS (
    SELECT
        region_code,
        COUNT(DISTINCT customer_id) AS recent_customer_count,
        MIN(signup_date) AS first_signup,
        MAX(signup_date) AS last_signup
    FROM recent_customers
    GROUP BY region_code
)

SELECT *
FROM summary
ORDER BY recent_customer_count DESC;
