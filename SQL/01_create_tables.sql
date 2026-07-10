-- Creating database schema

CREATE DATABASE fraud_detection_data;

-- NOTE: 
-- The source CSV is imported into PostgreSQL using a Python Script
-- The script creates the database schema used by the Python import process 
-- The workflow is in the import_to_pg.py folder in the repo