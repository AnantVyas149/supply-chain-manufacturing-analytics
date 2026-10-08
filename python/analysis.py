from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
df = pd.read_csv(ROOT / "data/cleaned/dataco_supply_chain_cleaned.csv", parse_dates=["Order_Date","Shipping_Date"])

def pct(x): return round(x * 100, 2)

print("=== DATACO SUPPLY CHAIN KPI SUMMARY ===")
print("Order items:", df["Order_Item_ID"].nunique())
print("Orders:", df["Order_ID"].nunique())
print("Customers:", df["Customer_ID"].nunique())
print("Revenue:", round(df["Sales"].sum(),2))
print("Profit:", round(df["Order_Profit_Per_Order"].sum(),2))
print("Profit margin %:", round(df["Order_Profit_Per_Order"].sum()/df["Sales"].sum()*100,2))
print("On-time delivery %:", pct(df["On_Time_Flag"].mean()))
print("Late delivery %:", pct(df["Late_Flag"].mean()))
print("Average actual shipping days:", round(df["Actual_Shipping_Days"].mean(),2))

monthly = df.assign(Month=df["Order_Date"].dt.to_period("M").astype(str)).groupby("Month").agg(
    Revenue=("Sales","sum"), Profit=("Order_Profit_Per_Order","sum"),
    Orders=("Order_ID","nunique"), On_Time=("On_Time_Flag","mean")
).reset_index()
monthly["On_Time"] *= 100
monthly.to_csv(ROOT/"reports/monthly_performance_runtime.csv", index=False)

plt.figure(figsize=(11,5))
plt.plot(monthly["Month"], monthly["Revenue"])
plt.xticks(rotation=60)
plt.title("Monthly Revenue")
plt.tight_layout()
plt.savefig(ROOT/"reports/monthly_revenue.png", dpi=150)
plt.close()

print("\nTop 10 products by revenue:")
print(df.groupby("Product_Name")["Sales"].sum().sort_values(ascending=False).head(10))
