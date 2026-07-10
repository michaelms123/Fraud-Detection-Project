-- Data Inspection for Fraud Dataset 

-- NOTES:
-- The time is in the format of seconds starting at 0 and increasing in terms of how many seconds have passed since the first transaction
-- There are 28 PCA edited features (for client confidentiality)
-- The $ amount of money per transaction 
-- There is also Class which shows whether a transaction is fraudulent or not


-- General Overview of data 
SELECT * FROM fraud_detection_data
LIMIT 10 

-- ========================================================================================================================

-- Checking missing values for all features in the dataset

SELECT COUNT(*) AS total_rows,
COUNT("Time") AS time_count,
COUNT("V1") AS V1_count,
COUNT("V2") AS V2_count,
COUNT("V3") AS V3_count,
COUNT("V4") AS V4_count,
COUNT("V5") AS V5_count,
COUNT("V6") AS V6_count,
COUNT("V7") AS V7_count,
COUNT("V8") AS V8_count,
COUNT("V9") AS V9_count,
COUNT("V10") AS V10_count,
COUNT("V11") AS V11_count,
COUNT("V12") AS V12_count,
COUNT("V13") AS V13_count,
COUNT("V14") AS V14_count,
COUNT("V15") AS V15_count,
COUNT("V16") AS V16_count,
COUNT("V17") AS V17_count,
COUNT("V18") AS V18_count,
COUNT("V19") AS V19_count,
COUNT("V20") AS V20_count,
COUNT("V21") AS V21_count,
COUNT("V22") AS V22_count,
COUNT("V23") AS V23_count,
COUNT("V24") AS V24_count,
COUNT("V25") AS V25_count,
COUNT("V26") AS V26_count,
COUNT("V27") AS V27_count,
COUNT("V28") AS V28_count,
COUNT("Amount") AS transaction_amount_count,
COUNT("Class") AS class_count
FROM fraud_detection_data;

-- There are no missing values in the dataset 
-- The dataset is very large with over 280000 values

-- ========================================================================================================================

-- Checking duplicate values (2 different ways)

-- 1) Using a GROUP BY clause and adding a duplicated count column to count the selected duplicates
SELECT "Time", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12", "V13", "V14", "V15",
    "V16", "V17", "V18", "V19", "V20", "V21", "V22", "V23", "V24", "V25", "V26", "V27", "V28", "Amount", "Class",
	COUNT(*) AS duplicate_count
FROM fraud_detection_data
GROUP BY "Time", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12", "V13", "V14", "V15", "V16", "V17",
"V18", "V19", "V20", "V21", "V22", "V23", "V24", "V25", "V26", "V27", "V28", "Amount", "Class"
HAVING COUNT(*) > 1;

-- 2) Using a CTE to get the total count of all duplicate values
WITH duplicates AS (
SELECT COUNT(*) AS duplicate_count
FROM fraud_detection_data
GROUP BY "Time", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12", "V13", "V14", "V15",
    "V16", "V17", "V18", "V19", "V20", "V21", "V22", "V23", "V24", "V25", "V26", "V27", "V28", "Amount", "Class"
HAVING COUNT(*) > 1
)
SELECT COALESCE(SUM(duplicate_count - 1), 0) AS total_duplicate_rows
FROM duplicates;

-- There appears to be just over 1000 duplicates in a dataset of over 280,000 
-- This is corroborated in our Python analysis (1081 duplicates to be exact)

-- ========================================================================================================================

-- Checking Class Imbalance:

SELECT "Class", COUNT(*) AS transactions,
ROUND((COUNT(*)) / SUM(COUNT(*)) OVER(), 4) AS fraud_pct
FROM fraud_detection_data
GROUP BY "Class";

-- Dataset is extremely imbalanced only 492 of the 284,407 transactions are fraudulent 
-- Only 0.017% of the data is actually fraudulent 

-- ========================================================================================================================

-- Checking the basic statistics for the transaction amounts

SELECT MIN("Amount"), MAX("Amount"), AVG("Amount"), STDDEV_SAMP("Amount")
FROM fraud_detection_data;

-- There is a very wide range of transactions with some extreme outliers
-- min value is 0, max is > 25000 and the average is 88
-- The standard deviation is around 250 meaning the results are scattered relatively far from the mean and point to outliers as a whole

-- Checking if there are any invalid values (i.e. less than zero)

SELECT * FROM fraud_detection_data
WHERE "Amount" < 0;

-- There are none which will make data cleaning easier overall