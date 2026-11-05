-- Question: how well do simple High/Medium/Low rules separate defaulters?
-- Insight: (fill in after running)
WITH tiered AS (
  SELECT is_default,
         CASE WHEN pay_sep >= 2 THEN 'High'
              WHEN pay_sep = 1 OR 1.0 * bill_sep / limit_bal >= 0.9 THEN 'Medium'
              ELSE 'Low' END AS risk_tier
  FROM clients_clean
)
SELECT risk_tier,
       COUNT(*) AS customers,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM tiered), 2) AS pct_of_customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct,
       ROUND(100.0 * SUM(is_default) / (SELECT SUM(is_default) FROM tiered), 2) AS pct_of_defaults,
       ROUND(AVG(is_default) / (SELECT AVG(is_default) FROM tiered), 2) AS lift
FROM tiered
GROUP BY risk_tier
ORDER BY default_rate_pct DESC;
