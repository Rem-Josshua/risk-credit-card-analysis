-- Question: which age and education combinations have the highest default rates?
-- Insight: (fill in after running)
WITH seg AS (
  SELECT age_band, education,
         COUNT(*) AS customers,
         SUM(is_default) AS defaults,
         ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct
  FROM clients_clean
  GROUP BY age_band, education
  HAVING COUNT(*) >= 200
)
SELECT *, RANK() OVER (ORDER BY default_rate_pct DESC) AS risk_rank
FROM seg
ORDER BY risk_rank;
