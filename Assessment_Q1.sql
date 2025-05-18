-- High-Value Customers with Multiple Products
-- This query finds users with at least one funded savings plan (confirmed_amount > 0)
-- and one funded investment plan (is_a_fund = TRUE and confirmed = TRUE).
-- It returns the customer details, count of plans, and total deposits (converted from kobo to naira).

SELECT
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id AND s.confirmed_amount > 0
JOIN plans_plan p ON u.id = p.owner_id AND p.is_a_fund = TRUE AND p.confirmed = TRUE
GROUP BY u.id, u.name
HAVING COUNT(DISTINCT s.id) > 0 AND COUNT(DISTINCT p.id) > 0
ORDER BY total_deposits DESC;
