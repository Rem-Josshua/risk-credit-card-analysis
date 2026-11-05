-- Question: how does the number of late months in the last six relate to default?
-- Insight: (fill in after running)
WITH d AS (
  SELECT is_default,
         (pay_sep >= 1) + (pay_aug >= 1) + (pay_jul >= 1)
       + (pay_jun >= 1) + (pay_may >= 1) + (pay_apr >= 1) AS months_late
  FROM clients_clean
)
SELECT months_late,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct
FROM d
GROUP BY months_late
ORDER BY months_late;
