-- Question: how does the most recent repayment status relate to default?
-- Insight: (fill in after running)
SELECT pay_sep AS latest_status,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct
FROM clients_clean
GROUP BY pay_sep
ORDER BY pay_sep;
