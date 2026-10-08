# DataCo Supply Chain & Manufacturing Analytics

An end-to-end Supply Chain & Manufacturing Analytics project built using the real **DataCo Smart Supply Chain dataset**. The project combines Python, MySQL, Excel, and Jupyter Notebook to analyze revenue, profitability, customers, products, markets, shipping performance, and delivery operations.

---

## 📌 Project Overview

This project analyzes **180,519 order-item transactions** from the DataCo Smart Supply Chain dataset.

The objective is to transform raw transactional data into actionable business insights across:

- Revenue and profitability
- Product and category performance
- Customer segments
- Market and regional performance
- Shipping and delivery operations
- Discounts and margins
- Customer value
- Monthly business trends
- Operational bottlenecks

The project follows a complete analytics workflow:

**Raw Data → Data Cleaning → Feature Engineering → Exploratory Analysis → SQL Analysis → Excel Dashboard → Business Insights**

---

## 📊 Dataset

**Dataset:** DataCo Smart Supply Chain for Big Data Analysis

The dataset contains:

- 180,519 order-item records
- 53 original columns
- Customer information
- Product information
- Order information
- Shipping information
- Sales and profit information
- Market and geographical information

The dataset is used for analytical and educational purposes.

---

## 🔐 Data Privacy & Cleaning

The original dataset contains customer-identifying and unnecessary fields.

The following fields were removed from the analytics dataset:

- Customer Email
- Customer Password
- Customer First Name
- Customer Last Name
- Customer Street
- Customer Zipcode
- Order Zipcode
- Product Image
- Product Description

The cleaned dataset contains only the fields required for analysis.

---

## 🛠️ Technology Stack

### Python
- Pandas
- NumPy
- Matplotlib
- Jupyter Notebook

### SQL
- MySQL
- Aggregations
- GROUP BY
- JOIN
- CASE statements
- CTEs
- Window functions
- Business KPI analysis

### Excel
- KPI dashboard
- Pivot-style analysis
- SUMIFS
- COUNTIFS
- AVERAGEIF
- IF
- XLOOKUP
- Charts
- Conditional analysis

### Tools
- VS Code
- MySQL Workbench
- Git
- GitHub

---

## 🔄 Project Workflow

```text
DataCo Raw Dataset
        ↓
Data Cleaning
        ↓
Column Standardization
        ↓
Feature Engineering
        ↓
Exploratory Data Analysis
        ↓
MySQL Database
        ↓
Business SQL Analysis
        ↓
Excel KPI Dashboard
        ↓
Business Insights & Recommendations

supply-chain-manufacturing-analytics/
│
├── SQL/
│   ├── 01_schema.sql
│   ├── 02_load_guide.sql
│   └── 03_business_analysis.sql
│
├── data/
│   ├── raw/
│   │   ├── DataCoSupplyChainDataset.csv
│   │   └── DescriptionDataCoSupplyChain.csv
│   │
│   └── cleaned/
│       └── dataco_supply_chain_cleaned.csv
│
├── excel/
│   └── DataCo_CV_Ready_Excel_Analytics.xlsx
│
├── notebooks/
│   └── DataCo_Complete_Analytics_Notebook.ipynb
│
├── python/
│   └── analysis.py
│
├── reports/
│   └── business_insights.md
│
├── README.md
└── requirements.txt