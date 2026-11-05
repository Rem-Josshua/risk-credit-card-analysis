-- Question: do customers who pay only the minimum default more than those who pay most of the bill?
-- Insight: (fill in after running)
WITH r AS (
  SELECT is_default,
         CASE WHEN bill_aug <= 0 THEN NULL ELSE 1.0 * paid_sep / bill_aug END AS pay_ratio
  FROM clients_clean
)
SELECT CASE WHEN pay_ratio IS NULL THEN '0. No balance due'
            WHEN pay_ratio < 0.05 THEN '1. Under 5% (minimum or less)'
            WHEN pay_ratio < 0.25 THEN '2. 5-24%'
            WHEN pay_ratio < 1 THEN '3. 25-99%'
            ELSE '4. Paid in full' END AS payment_band,
       COUNT(*) AS customers,
       ROUND(100.0 * AVG(is_default), 2) AS default_rate_pct
FROM r
GROUP BY payment_band
ORDER BY payment_band;
