# Credit Card Fraud Analysis and Detection
## Overview
**Note:**
The dataset was too larget to upload directly to GitHub, you can find it here on Kaggle: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

You can access the public Tableau dashboard here: https://public.tableau.com/views/frauddetectionwb/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

Credit providers process millions of credit card transactions every day. Detecting fraudulent transactions quickly is essential for minimizing loss while reducing false positives that are inconvenient to legitimate customers. This project analyzes over 280,000 transactions to identify fraud patterns, build analytical dashboards and evaluate ML models for fraud detection. 

The workflow covers data cleaning, exploratory data analysis,  SQL based analyisis, dashboard development, predictive modeling and final business insights. 

## Dataset
- Highly imbalanced dataset with fraud representing a small fraction of transactions
- Features are anonymized using PCA (V1–V28)
### Additional features:
- Time: seconds since first transaction (~48 hours)
- Amount: transaction value
- Class: target (0 = non-fraud, 1 = fraud)
## Approach
Models Evaluated
Logistic Regression (baseline)
Random Forest
LightGBM
XGBoost (final model)

## Results

### Analytical Findings:
The exploratory and SQL-based analysis identified several key fraud patterns:

- Fraud represented a very small percentage of all transactions, highlighting the importance of monitoring highly imbalanced data.
- Fraudulent transactions occurred disproportionately during specific time periods, indicating temporal patterns that could support real-time monitoring.
- Higher-value transactions showed elevated fraud risk compared with typical transaction amounts.
- Data validation and exploratory analysis confirmed the dataset was suitable for downstream modeling and dashboard reporting.

Interactive dashboards were developed to: 
- Determine total transactions
- Fraud rate
- Fraud by transaction amount
- Fraud trends over time
- High risk transaction segments

<img width="1591" height="841" alt="Screenshot 2026-07-09 205548" src="https://github.com/user-attachments/assets/c6cbbb09-4bd5-40c7-a0b3-cac9cc24b082" />
<img width="1577" height="341" alt="Screenshot 2026-07-09 205606" src="https://github.com/user-attachments/assets/2279b0c8-a11a-4197-8c92-38d9e055a6d9" />


## Predictive Model Performance:

**Final model: XGBoost**
F1 Score: 0.86
Precision: 0.95
Recall: 0.78
ROC-AUC: 0.98
Average Precision (APS): 0.83

## Interpretation

The model achieves high precision, meaning flagged transactions are highly likely to be fraudulent. It detects the majority of fraud cases while keeping false positives very low. The chosen threshold reflects a balance between fraud detection and minimizing unnecessary alerts.

## Key Points
- Boosting models significantly outperformed linear and bagging approaches
- Threshold tuning was critical for optimizing performance
- Precision-recall metrics are more informative than accuracy for imbalanced data
- Regularization improved generalization and model stability

## Tech Stack
- SQL (PostgreSQL)
- Python
- Pandas
- NumPy
- Tableau
- Matplotlib
- Scikit-learn
- XGBoost
