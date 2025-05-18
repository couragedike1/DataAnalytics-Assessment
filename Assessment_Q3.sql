-- Account Inactivity Alert
-- This query identifies accounts (savings or investment) with no inflow in the last 365 days.

WITH last_txn_savings AS (
    SELECT id AS plan_id, owner_id, 'Savings' AS type, MAX(created_at) AS last_transaction_date
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY id, owner_id
),
last_txn_investments AS (
    SELECT id AS plan_id, owner_id, 'Investment' AS type, MAX(created_at) AS last_transaction_date
    FROM plans_plan
    WHERE is_a_fund = TRUE AND confirmed = TRUE
    GROUP BY id, owner_id
),
combined AS (
    SELECT * FROM last_txn_savings
    UNION ALL
    SELECT * FROM last_txn_investments
)
SELECT
    plan_id,
    owner_id,
    type,
    last_transaction_date::date,
    DATE_PART('day', CURRENT_DATE - last_transaction_date) AS inactivity_days
FROM combined
WHERE last_transaction_date < CURRENT_DATE - INTERVAL '365 days'
ORDER BY inactivity_days DESC;
