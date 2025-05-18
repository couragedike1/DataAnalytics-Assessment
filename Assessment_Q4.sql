-- CLV estimation based on transaction volume and tenure
WITH customer_txns AS (
    SELECT
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value_kobo
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure_calc AS (
    SELECT
        id AS customer_id,
        name,
        DATE_PART('month', AGE(CURRENT_DATE, date_joined)) AS tenure_months
    FROM users_customuser
),
clv_calc AS (
    SELECT
        t.customer_id,
        t.name,
        t.tenure_months,
        COALESCE(c.total_transactions, 0) AS total_transactions,
        COALESCE(ROUND((c.total_value_kobo / c.total_transactions) / 1000.0, 2), 0) AS avg_profit_per_txn, -- convert kobo to Naira then multiply by 0.001 (0.1%)
        CASE 
            WHEN t.tenure_months > 0 THEN ROUND((c.total_transactions::float / t.tenure_months) * 12 * ((c.total_value_kobo / c.total_transactions) * 0.001 / 100), 2)
            ELSE 0
        END AS estimated_clv
    FROM tenure_calc t
    LEFT JOIN customer_txns c ON t.customer_id = c.owner_id
)
SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    estimated_clv
FROM clv_calc
ORDER BY estimated_clv DESC;
