-- Question: do customers with higher or lower credit limits default more?
-- Insight: (fill in after running)
WITH ranked AS (
  SELECT *, NTILE(10) OVER (ORDER BY limit_bal, id) AS limit_decile
  FROM clients_clean
)
SELECT limit_decile,
       MIN(limit_bal) AS min_limit, MAX(limit_bal) AS max_limit,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct
FROM ranked
GROUP BY limit_decile
ORDER BY limit_decile;
