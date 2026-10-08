# DataCo Supply Chain & Manufacturing Analytics

A portfolio Data Analytics project built from the **DataCo Smart Supply Chain** Kaggle dataset.

## Dataset
Source: DataCo Smart Supply Chain for Big Data Analysis (Kaggle). The original dataset contains 180,519 order-item records and 53 columns in this uploaded version.

## Privacy / cleaning
The original file contains customer-identifying/security fields. These were deliberately excluded from the analytics dataset, including customer email, password, names, street address, and unnecessary product-image/description fields.

## Stack
- Python: pandas, NumPy, matplotlib
- MySQL
- Excel
- Jupyter Notebook
- Git/GitHub

## Workflow
Raw Kaggle data → Python cleaning/feature engineering → MySQL → SQL business analysis → Excel KPI analysis → recommendations.

## Key analyses
- Revenue, profit and margin
- On-time and late delivery
- Shipping-mode performance
- Category performance
- Market performance
- Product ranking
- Customer-segment performance
- Monthly trends and MoM growth
- Top products within each category using window functions

## Local setup
```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
python python\analysis.py
```

## MySQL
1. Open MySQL Workbench.
2. Run `sql/01_schema.sql`.
3. Import `data/cleaned/dataco_supply_chain_cleaned.csv` into the `orders` table using Workbench's import wizard.
4. Run `sql/02_business_analysis.sql`.

## Excel
Open `excel/DataCo_Analytics.xlsx` for KPI, monthly, category, shipping, market and product analysis.

## Limitations
The dataset is transactional and does not contain every operational driver needed for causal analysis. Recommendations are therefore descriptive and should not be treated as proof of causality.

## Power BI
Intentionally excluded from this version.
