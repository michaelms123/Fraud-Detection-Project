-- Creating a new table to clean and leaving original table intact
-- Dropping duplicates while creating 

CREATE TABLE fraud_detection_clean
AS SELECT DISTINCT * FROM fraud_detection_data;

-- =================================================================================================================

-- Adding a column to track how many hours since the first transaction

ALTER TABLE fraud_detection_clean
ADD COLUMN hour_since_start double precision;

UPDATE fraud_detection_clean
SET hour_since_start = FLOOR(time/3600);

-- =================================================================================================================

-- Adding amount buckets to group transactions
-- then checking the distribution per bucket, fraud rate per bucket and if there are any 'N/A' values

ALTER TABLE fraud_detection_clean
ADD COLUMN amount_bucket TEXT;

UPDATE fraud_detection_clean
SET amount_bucket = 
CASE 
WHEN "Amount" >= 0 AND "Amount" <= 10 THEN '0-10'
WHEN "Amount" > 10 AND "Amount" <= 25 THEN '10-25'
WHEN "Amount" > 25 AND "Amount" <= 50 THEN '25-50'
WHEN "Amount" > 50 AND "Amount" <= 100 THEN '50-100'
WHEN "Amount" > 100 AND "Amount" <= 250 THEN '100-250'
WHEN "Amount" > 250 AND "Amount" <= 500 THEN '250-500'
WHEN "Amount" > 500 AND "Amount" <= 1000 THEN '500-1000'
WHEN "Amount" > 1000 THEN '1000+'
ELSE 'N/A'
END;
