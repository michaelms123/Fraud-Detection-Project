-- Creating an EDA for the data
-- Exploring time based analysis, amount analysis

-- ==================================================================================================================

-- Time Based Analysis:

-- Determining:
-- how many total transactions occured per hour
-- how many fraudulent transactions occured per hour
-- what is the fraud rate per hour
-- what share of transactions per hour are fraudulent

SELECT COUNT(*) AS transactions_per_hour
SELECT hours_since_start,
SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) AS fraud_count_per_hour,
ROUND(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 4) AS fraud_rate_per_hour,
ROUND((SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0) / SUM(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END)) OVER(), 4) AS fraud_share_per_hour
FROM fraud_detection_clean
GROUP BY hours_since_start
ORDER BY hours_since_start;

-- Fraudulent transactions seem to increase in overall volume the more time passes from the original transaction
-- Fraud share and fraud rate seem to peak simultaneously 
-- The highest amount of fraudulent cases in a one hour span is 43 which is significantly more than the next highest of 27
-- This may indicate a higher risk time in the day for fraud however due to the anonymized nature of the dataset it's impossible to say for sure.

-- ==================================================================================================================

-- Amount Analysis

-- Distribution of fraud per bucket (count, rate and share)

SELECT 
amount_bucket, 
COUNT(*) AS fraud_amount_dist,
ROUND((COUNT(*) * 100) / SUM(COUNT(*)) OVER(), 4) AS transaction_bucket_pct,
SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) AS fraud_bucket_count,
ROUND(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 4) AS fraud_rate_pct,
ROUND((SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END) * 100.0) / SUM(SUM(CASE WHEN "Class" = 1 THEN 1 ELSE 0 END)) OVER(), 4) AS share_of_all_fraud
FROM fraud_detection_clean
GROUP BY amount_bucket
ORDER BY amount_dist DESC;

-- 35% of all transactions are 0-10 dollars 
-- There are only 2934 total transactions in the $1000+ category
-- Relatively few large transactions means there are likely large outliers affecting the overall average
-- The amount of transactions per bucket follows a linear course from the lowest possible values to the highest
-- Less than 1% of all transaction in any given bucket are fraudulent.
-- There are higher volumes of fraud at lower amounts with the highest fraud count being found in the 0-10 range
-- This also coincides with fraud trends of taking out many small transactions rather than one or two large transactions.
-- THis is also where the majority of the transactions are so we need to keep that in mind going forward.
-- The highest % of fraud is in the 500-1000 range, however this range only has 6000 transactions or so 
-- meaning that even though it has a higher % the overall fraud volume is lower overall. 
-- 50% of the fraudulent transactions are in the 0-10 bucket and under 2% of all fraudulent transactions are in the 1000+ category.

-- ====================================================================================================================

-- PCA Features Analysis:

SELECT
"Class",
COUNT(*) AS transaction_count,
AVG("V10") AS avg_v10,
MIN("V10") AS min_v10,
MAX("V10") AS max_v10,
STDDEV("V10") AS stddev_v10,
AVG("V12") AS avg_v12,
MIN("V12") AS min_v12,
MAX("V12") AS max_v12,
STDDEV("V12") AS stddev_v12,
AVG("V14") AS avg_v14,
MIN("V14") AS min_v14,
MAX("V14") AS max_v14,
STDDEV("V14") AS stddev_v14,
AVG("V17") AS avg_v17,
MIN("V17") AS min_v17,
MAX("V17") AS max_v17,
STDDEV("V17") AS stddev_v17
FROM fraud_detection_clean
GROUP BY "Class"

-- This give an overview of a few of the PCA edited features
-- There distribution based on class (whether they are fraudulent or not
-- All of the selected features have negative minimum values and low max values it's unclear the significance due to the PCA anonomysing
-- 
