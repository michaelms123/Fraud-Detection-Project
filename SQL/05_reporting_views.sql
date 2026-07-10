-- Creating views to use in Tableau dashboard creation and analysis

-- ==================================================================================================================

-- Creating an overall summary containing necessary KPIs

CREATE VIEW vw_overall_summary AS
SELECT COUNT(*) as total_transactions,
SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 4) AS fraud_percentage,
ROUND(SUM(CASE WHEN "Class" = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 4) AS legitimate_percentage,
AVG("Amount") AS average_transaction_amount,
MIN("Amount") AS minimum_transaction_amount,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Amount") AS median_transaction_amount,
MAX("Amount") AS maximum_transaction_amount,
AVG(CASE WHEN "Class" = 1 THEN "Amount" END) AS average_fraud_amount,
AVG(CASE WHEN "Class" = 0 THEN "Amount" END) AS average_legitimate_amount
FROM fraud_detection_clean;

-- =====================================================================================================================

-- Creating an hourly summary for transactions by the hour 

CREATE VIEW vw_hourly_summary AS 
SELECT hours_since_start,
COUNT(*) AS transactions_count,
ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(), 4) AS transaction_share,
SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) AS fraud_count,
ROUND(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 4) AS fraud_rate_pct,
ROUND((SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0) / SUM(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END)) OVER(), 4) AS fraud_share_pct
FROM fraud_detection_clean
GROUP BY hours_since_start;

-- =====================================================================================================================

-- Creating an amount bucket summary for transactions that fall in certain ranges

CREATE VIEW vw_amount_bucket_summary AS
SELECT 
amount_bucket, 
COUNT(*) AS transactions_per_amount,
AVG("Amount") AS average_amount,
ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(), 4) AS transaction_share,
SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) AS fraud_count,
ROUND(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 4) AS fraud_rate,
ROUND((SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0) / SUM(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END)) OVER(), 4) AS fraud_share
FROM fraud_detection_clean
GROUP BY amount_bucket;

-- =====================================================================================================================

