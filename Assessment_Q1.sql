-- Customers with both funded savings and investment plans, sorted by total deposits
SELECT
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits  -- Convert kobo to Naira
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
JOIN plans_plan p ON u.id = p.owner_id
WHERE s.confirmed_amount > 0
  AND p.is_a_fund = TRUE AND p.confirmed = TRUE
GROUP BY u.id, u.name
HAVING COUNT(DISTINCT s.id) > 0 AND COUNT(DISTINCT p.id) > 0
ORDER BY total_deposits DESC;
