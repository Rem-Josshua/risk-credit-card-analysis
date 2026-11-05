-- Question: which segments carry the most default risk, and how much of total defaults does each contribute?
-- Insight: (fill in after running)
SELECT 'education' AS dimension, education AS segment, COUNT(*) AS customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct,
       ROUND(100.0 * SUM(is_default) / (SELECT SUM(is_default) FROM clients_clean), 2) AS share_of_defaults_pct
FROM clients_clean GROUP BY education
UNION ALL
SELECT 'marital_status', marital_status, COUNT(*),
       ROUND(100.0 * AVG(is_default), 2),
       ROUND(100.0 * SUM(is_default) / (SELECT SUM(is_default) FROM clients_clean), 2)
FROM clients_clean GROUP BY marital_status
UNION ALL
SELECT 'age_band', age_band, COUNT(*),
       ROUND(100.0 * AVG(is_default), 2),
       ROUND(100.0 * SUM(is_default) / (SELECT SUM(is_default) FROM clients_clean), 2)
FROM clients_clean GROUP BY age_band
UNION ALL
SELECT 'sex', sex, COUNT(*),
       ROUND(100.0 * AVG(is_default), 2),
       ROUND(100.0 * SUM(is_default) / (SELECT SUM(is_default) FROM clients_clean), 2)
FROM clients_clean GROUP BY sex
ORDER BY dimension, default_rate_pct DESC;
