-- Question: what are the average month-to-month roll rates across all five month pairs?
-- Insight: (fill in after running)
WITH pairs AS (
  SELECT pay_aug AS prev_status, pay_sep AS next_status FROM clients_clean
  UNION ALL SELECT pay_jul, pay_aug FROM clients_clean
  UNION ALL SELECT pay_jun, pay_jul FROM clients_clean
  UNION ALL SELECT pay_may, pay_jun FROM clients_clean
  UNION ALL SELECT pay_apr, pay_may FROM clients_clean
),
states AS (
  SELECT
    CASE WHEN prev_status <= 0 THEN '0_Current'
         WHEN prev_status = 1 THEN '1_One month late'
         WHEN prev_status = 2 THEN '2_Two months late'
         ELSE '3_Three+ months late' END AS from_state,
    CASE WHEN next_status <= 0 THEN '0_Current'
         WHEN next_status = 1 THEN '1_One month late'
         WHEN next_status = 2 THEN '2_Two months late'
         ELSE '3_Three+ months late' END AS to_state
  FROM pairs
)
SELECT from_state, to_state,
       COUNT(*) AS customers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY from_state), 2) AS pct_of_from_state
FROM states
GROUP BY from_state, to_state
ORDER BY from_state, to_state;
