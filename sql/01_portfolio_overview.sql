-- Question: what is the overall default rate and average credit limit?
-- Insight: (fill in after running)
SELECT COUNT(*) AS customers,
       SUM(is_default) AS defaults,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct,
       ROUND(AVG(limit_bal)) AS avg_limit
FROM clients_clean;
