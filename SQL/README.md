# DataCo Supply Chain Analytics — SQL

This SQL layer is aligned with the Python analysis and CV-ready Excel workbook.

## Files

- `01_schema.sql` — MySQL 8+ database and table schema.
- `02_load_guide.sql` — instructions and example `LOAD DATA LOCAL INFILE`.
- `03_business_analysis.sql` — business questions, KPI queries, operational analysis, product/customer analysis and management insights.

## Dataset

The project uses the real DataCo Smart Supply Chain dataset.

The analytical dataset intentionally removes customer PII/security fields:
- Customer name
- Customer email
- Customer password
- Customer street
- Customer/customer order ZIP codes
- Product image
- Product description

## KPI definitions

- Revenue = `SUM(Sales)`
- Profit = `SUM(Order_Profit_Per_Order)`
- Profit Margin = Profit / Revenue
- On-Time Rate = `AVG(On_Time_Flag)`
- Late Rate = `AVG(Late_Flag)`
- Shipping Delay = Actual Shipping Days - Scheduled Shipping Days

## Recommended workflow

1. Run `01_schema.sql`.
2. Load `data/cleaned/dataco_supply_chain_cleaned.csv`.
3. Run `03_business_analysis.sql`.
4. Compare KPI results with the Excel dashboard and Python notebook.

This gives you a consistent Python → MySQL → Excel analytics pipeline for interviews.
