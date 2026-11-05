-- Question: from one month to the next, what share of customers cure, stay late, or get worse?
-- Insight: (fill in after running)
WITH states AS (
  SELECT
    CASE WHEN pay_aug <= 0 THEN '0_Current'
         WHEN pay_aug = 1 THEN '1_One month late'
         WHEN pay_aug = 2 THEN '2_Two months late'
         ELSE '3_Three+ months late' END AS from_state,
    CASE WHEN pay_sep <= 0 THEN '0_Current'
         WHEN pay_sep = 1 THEN '1_One month late'
         WHEN pay_sep = 2 THEN '2_Two months late'
         ELSE '3_Three+ months late' END AS to_state
  FROM clients_clean
)
SELECT from_state, to_state,
       COUNT(*) AS customers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY from_state), 2) AS pct_of_from_state
FROM states
GROUP BY from_state, to_state
ORDER BY from_state, to_state;
