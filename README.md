# Credit Card Fraud Detection
## Overview
**Note:**
The dataset was too larget to upload directly to GitHub, you can find it here on Kaggle: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

This project builds machine learning models to detect fraudulent credit card transactions in a highly imbalanced dataset. The objective is to identify fraud accurately while minimizing false positives, reflecting real-world constraints in financial systems.

The workflow covers exploratory data analysis, model development, threshold optimization, and final evaluation on a held-out test set.

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
## Methodology
Stratified train/validation/test split
Evaluation metrics:
F1 Score
ROC-AUC
Average Precision Score (PR-AUC)
Threshold optimization to balance precision and recall
Hyperparameter tuning for tree-based models
Regularization to control overfitting

## Results

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
- Python
- Scikit-learn
- XGBoost
- LightGBM
- Pandas, NumPy
- Matplotlib, Seaborn
