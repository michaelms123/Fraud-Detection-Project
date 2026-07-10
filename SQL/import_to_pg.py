## How to Set Up the Schema Through Python

#Importing necessary libraries
import pandas as pd
from sqlalchemy import create_engine

#Creating an engine for PostgreSQL with example format
engine = create_engine('postgresql://username:password@localhost:5432/fraud_detection_data')

#Storing CSV file in a df and checking data before upload with example
fraud_df = pd.read_csv("/FilePath/creditcard.csv")

#Uploading to SQL
fraud_df.to_sql('fraud_detection_data', engine, if_exists='replace', index=False)