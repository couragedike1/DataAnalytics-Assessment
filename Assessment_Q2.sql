-- Transaction Frequency Analysis
-- This query calculates the monthly average number of transactions per customer.
-- Based on the average, each user is categorized into frequency tiers.

WITH txn_months AS (
    SELECT
        owner_id,
        DATE_TRUNC('month', created_at) AS month,
        COUNT(*) AS txns
    FROM savings_savingsaccount
    GROUP BY owner_id, month
),
txn_avg AS (
    SELECT owner_id, AVG(txns) AS avg_txns_per_month FROM txn_months GROUP BY owner_id
),
categorized AS (
    SELECT
        CASE
            WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txns_per_month >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txns_per_month
    FROM txn_avg
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY customer_count DESC;
