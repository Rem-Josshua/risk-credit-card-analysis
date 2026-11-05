-- Question: how does default risk change as customers use more of their credit limit?
-- Insight: (fill in after running)
WITH util AS (
  SELECT *, 1.0 * bill_sep / limit_bal AS utilization FROM clients_clean
)
SELECT CASE WHEN utilization <= 0 THEN '0. No balance'
            WHEN utilization < 0.3 THEN '1. Under 30%'
            WHEN utilization < 0.6 THEN '2. 30-59%'
            WHEN utilization < 0.9 THEN '3. 60-89%'
            ELSE '4. 90%+' END AS utilization_band,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct
FROM util
GROUP BY utilization_band
ORDER BY utilization_band;
