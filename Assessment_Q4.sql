-- Customer Lifetime Value (CLV) Estimation
-- This query calculates estimated CLV using tenure and total transaction volume.
-- Profit per transaction is 0.1% of average transaction value.

WITH txns AS (
    SELECT owner_id, COUNT(*) AS total_transactions, SUM(confirmed_amount) AS total_kobo
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure AS (
    SELECT id AS customer_id, name,
           DATE_PART('month', AGE(CURRENT_DATE, date_joined)) AS tenure_months
    FROM users_customuser
),
clv AS (
    SELECT
        t.customer_id,
        t.name,
        t.tenure_months,
        COALESCE(x.total_transactions, 0) AS total_transactions,
        ROUND(COALESCE(x.total_kobo, 0) / 100.0 / NULLIF(x.total_transactions, 0), 2) AS avg_value_naira,
        ROUND(
            (COALESCE(x.total_transactions, 0)::float / NULLIF(t.tenure_months, 0)) * 12 *
            ((COALESCE(x.total_kobo, 0) / NULLIF(x.total_transactions, 1)) * 0.001 / 100),
            2
        ) AS estimated_clv
    FROM tenure t
    LEFT JOIN txns x ON t.customer_id = x.owner_id
)
SELECT customer_id, name, tenure_months, total_transactions, estimated_clv
FROM clv
ORDER BY estimated_clv DESC;
