-- Question: how do we get one clean, readable version of the data to analyze?
DROP VIEW IF EXISTS clients_clean;
CREATE VIEW clients_clean AS
SELECT
  id,
  limit_bal,
  CASE sex WHEN 1 THEN 'Male' WHEN 2 THEN 'Female' END AS sex,
  CASE WHEN education = 1 THEN 'Graduate school'
       WHEN education = 2 THEN 'University'
       WHEN education = 3 THEN 'High school'
       ELSE 'Others/Unknown' END AS education,
  CASE WHEN marriage = 1 THEN 'Married'
       WHEN marriage = 2 THEN 'Single'
       ELSE 'Others/Unknown' END AS marital_status,
  age,
  CASE WHEN age < 25 THEN '<25'
       WHEN age < 35 THEN '25-34'
       WHEN age < 45 THEN '35-44'
       WHEN age < 55 THEN '45-54'
       ELSE '55+' END AS age_band,
  pay_0 AS pay_sep, pay_2 AS pay_aug, pay_3 AS pay_jul,
  pay_4 AS pay_jun, pay_5 AS pay_may, pay_6 AS pay_apr,
  bill_amt1 AS bill_sep, bill_amt2 AS bill_aug, bill_amt3 AS bill_jul,
  bill_amt4 AS bill_jun, bill_amt5 AS bill_may, bill_amt6 AS bill_apr,
  pay_amt1 AS paid_sep, pay_amt2 AS paid_aug, pay_amt3 AS paid_jul,
  pay_amt4 AS paid_jun, pay_amt5 AS paid_may, pay_amt6 AS paid_apr,
  default_payment_next_month AS is_default
FROM clients;
