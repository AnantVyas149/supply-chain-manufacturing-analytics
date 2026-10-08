-- DataCo Supply Chain Analytics
-- Business analysis queries
-- MySQL 8+
USE dataco_supply_chain;

-- ============================================================
-- 1. DATA QUALITY / BASIC PROFILE
-- ============================================================

SELECT COUNT(*) AS order_items
FROM supply_chain_orders;

SELECT
    COUNT(DISTINCT Order_ID) AS orders,
    COUNT(DISTINCT Customer_ID) AS customers,
    COUNT(DISTINCT Product_Card_ID) AS products,
    COUNT(DISTINCT Category_Name) AS categories
FROM supply_chain_orders;

SELECT
    MIN(Order_Date) AS first_order_date,
    MAX(Order_Date) AS last_order_date
FROM supply_chain_orders;

-- Check duplicate order-item IDs
SELECT Order_Item_ID, COUNT(*) AS row_count
FROM supply_chain_orders
GROUP BY Order_Item_ID
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- Missing-value audit for important business fields
SELECT
    SUM(Order_ID IS NULL) AS missing_order_id,
    SUM(Customer_ID IS NULL) AS missing_customer_id,
    SUM(Product_Card_ID IS NULL) AS missing_product_id,
    SUM(Sales IS NULL) AS missing_sales,
    SUM(Order_Profit_Per_Order IS NULL) AS missing_profit,
    SUM(Shipping_Delay_Days IS NULL) AS missing_delay
FROM supply_chain_orders;


-- ============================================================
-- 2. EXECUTIVE KPIs
-- ============================================================

SELECT
    ROUND(SUM(Sales), 2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order) / NULLIF(SUM(Sales),0) * 100, 2) AS Profit_Margin_Pct,
    COUNT(DISTINCT Order_ID) AS Orders,
    COUNT(DISTINCT Customer_ID) AS Customers,
    COUNT(*) AS Order_Items,
    ROUND(AVG(Actual_Shipping_Days), 2) AS Avg_Shipping_Days,
    ROUND(AVG(Shipping_Delay_Days), 2) AS Avg_Delay_Days,
    ROUND(AVG(On_Time_Flag) * 100, 2) AS On_Time_Rate_Pct,
    ROUND(AVG(Late_Flag) * 100, 2) AS Late_Rate_Pct,
    ROUND(AVG(Order_Item_Discount_Rate) * 100, 2) AS Avg_Discount_Rate_Pct
FROM supply_chain_orders;


-- ============================================================
-- 3. MONTHLY PERFORMANCE
-- ============================================================

SELECT
    Order_Month,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Profit_Margin_Pct,
    COUNT(DISTINCT Order_ID) AS Orders,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Order_Month
ORDER BY Order_Month;


-- ============================================================
-- 4. CATEGORY PERFORMANCE
-- ============================================================

SELECT
    Category_Name,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Profit_Margin_Pct,
    COUNT(*) AS Order_Items,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Category_Name
ORDER BY Revenue DESC;


-- Top 10 categories
SELECT
    Category_Name,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit
FROM supply_chain_orders
GROUP BY Category_Name
ORDER BY Revenue DESC
LIMIT 10;


-- ============================================================
-- 5. PRODUCT PERFORMANCE
-- ============================================================

SELECT
    Product_Card_ID,
    Product_Name,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Profit_Margin_Pct,
    COUNT(*) AS Order_Items,
    SUM(Order_Item_Quantity) AS Quantity,
    ROUND(AVG(Order_Item_Discount_Rate)*100,2) AS Avg_Discount_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct
FROM supply_chain_orders
GROUP BY Product_Card_ID, Product_Name
ORDER BY Revenue DESC;


-- High-revenue but low-margin products
SELECT
    Product_Card_ID,
    Product_Name,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Margin_Pct
FROM supply_chain_orders
GROUP BY Product_Card_ID, Product_Name
HAVING SUM(Sales) >= 100000
   AND SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0) < 0.10
ORDER BY Revenue DESC;


-- ============================================================
-- 6. MARKET / REGION
-- ============================================================

SELECT
    Market,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Margin_Pct,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Market
ORDER BY Revenue DESC;

SELECT
    Order_Region,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Order_Region
ORDER BY Revenue DESC;


-- ============================================================
-- 7. CUSTOMER SEGMENTS
-- ============================================================

SELECT
    Customer_Segment,
    COUNT(DISTINCT Customer_ID) AS Customers,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Margin_Pct,
    ROUND(AVG(Order_Item_Discount_Rate)*100,2) AS Avg_Discount_Pct
FROM supply_chain_orders
GROUP BY Customer_Segment
ORDER BY Revenue DESC;


-- Top customers by revenue
SELECT
    Customer_ID,
    Customer_Segment,
    COUNT(DISTINCT Order_ID) AS Orders,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Margin_Pct
FROM supply_chain_orders
GROUP BY Customer_ID, Customer_Segment
ORDER BY Revenue DESC
LIMIT 20;


-- ============================================================
-- 8. SHIPPING / OPERATIONS
-- ============================================================

SELECT
    Shipping_Mode,
    COUNT(*) AS Order_Items,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(AVG(Actual_Shipping_Days),2) AS Avg_Shipping_Days,
    ROUND(AVG(Scheduled_Shipping_Days),2) AS Avg_Scheduled_Days,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct,
    ROUND(AVG(Late_Flag)*100,2) AS Late_Rate_Pct
FROM supply_chain_orders
GROUP BY Shipping_Mode
ORDER BY Revenue DESC;


-- Delivery status
SELECT
    Delivery_Status,
    COUNT(*) AS Order_Items,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100,2) AS Share_Pct,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Delivery_Status
ORDER BY Order_Items DESC;


-- ============================================================
-- 9. DELIVERY BOTTLENECKS
-- ============================================================

-- Countries with the worst delivery performance, minimum 100 items
SELECT
    Order_Country,
    COUNT(*) AS Order_Items,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days,
    ROUND(AVG(Late_Flag)*100,2) AS Late_Rate_Pct,
    ROUND(SUM(Sales),2) AS Revenue
FROM supply_chain_orders
GROUP BY Order_Country
HAVING COUNT(*) >= 100
ORDER BY Late_Rate_Pct DESC, Avg_Delay_Days DESC
LIMIT 20;


-- High-revenue products with poor delivery performance
SELECT
    Product_Card_ID,
    Product_Name,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days,
    ROUND(AVG(Late_Flag)*100,2) AS Late_Rate_Pct,
    ROUND(AVG(On_Time_Flag)*100,2) AS On_Time_Rate_Pct
FROM supply_chain_orders
GROUP BY Product_Card_ID, Product_Name
HAVING SUM(Sales) >= 100000
ORDER BY Late_Rate_Pct DESC, Revenue DESC
LIMIT 20;


-- ============================================================
-- 10. DISCOUNT ANALYSIS
-- ============================================================

SELECT
    ROUND(Order_Item_Discount_Rate*100,1) AS Discount_Pct,
    COUNT(*) AS Order_Items,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Margin_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Order_Item_Discount_Rate
ORDER BY Order_Item_Discount_Rate;


-- ============================================================
-- 11. ABC / PARETO PRODUCT ANALYSIS
-- ============================================================

WITH product_revenue AS (
    SELECT
        Product_Card_ID,
        Product_Name,
        SUM(Sales) AS Revenue
    FROM supply_chain_orders
    GROUP BY Product_Card_ID, Product_Name
),
ranked AS (
    SELECT
        *,
        SUM(Revenue) OVER (ORDER BY Revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_Revenue,
        SUM(Revenue) OVER () AS Total_Revenue
    FROM product_revenue
)
SELECT
    Product_Card_ID,
    Product_Name,
    ROUND(Revenue,2) AS Revenue,
    ROUND(Cumulative_Revenue / Total_Revenue * 100,2) AS Cumulative_Revenue_Pct,
    CASE
        WHEN Cumulative_Revenue / Total_Revenue <= 0.80 THEN 'A'
        WHEN Cumulative_Revenue / Total_Revenue <= 0.95 THEN 'B'
        ELSE 'C'
    END AS ABC_Class
FROM ranked
ORDER BY Revenue DESC;


-- ============================================================
-- 12. CUSTOMER VALUE / RFM-STYLE ANALYSIS
-- ============================================================

WITH customer_metrics AS (
    SELECT
        Customer_ID,
        Customer_Segment,
        MAX(Order_Date) AS Last_Order_Date,
        COUNT(DISTINCT Order_ID) AS Frequency,
        SUM(Sales) AS Monetary_Value
    FROM supply_chain_orders
    GROUP BY Customer_ID, Customer_Segment
)
SELECT
    Customer_ID,
    Customer_Segment,
    Last_Order_Date,
    DATEDIFF((SELECT MAX(Order_Date) FROM supply_chain_orders), Last_Order_Date) AS Recency_Days,
    Frequency,
    ROUND(Monetary_Value,2) AS Monetary_Value,
    CASE
        WHEN Monetary_Value >= 3000 THEN 'Very High'
        WHEN Monetary_Value >= 1500 THEN 'High'
        WHEN Monetary_Value >= 750 THEN 'Medium'
        ELSE 'Low'
    END AS Customer_Value_Band
FROM customer_metrics
ORDER BY Monetary_Value DESC;


-- ============================================================
-- 13. ORDER STATUS
-- ============================================================

SELECT
    Order_Status,
    COUNT(*) AS Order_Items,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100,2) AS Share_Pct,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit
FROM supply_chain_orders
GROUP BY Order_Status
ORDER BY Order_Items DESC;


-- ============================================================
-- 14. MANAGEMENT INSIGHT QUERIES
-- ============================================================

-- Revenue concentration: top 10 products' share of total revenue
SELECT
    ROUND(
        SUM(CASE WHEN rn <= 10 THEN Revenue ELSE 0 END)
        / SUM(Revenue) * 100, 2
    ) AS Top_10_Product_Revenue_Share_Pct
FROM (
    SELECT
        Product_Card_ID,
        SUM(Sales) AS Revenue,
        ROW_NUMBER() OVER (ORDER BY SUM(Sales) DESC) AS rn
    FROM supply_chain_orders
    GROUP BY Product_Card_ID
) x;


-- Most profitable categories
SELECT
    Category_Name,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Profit,
    ROUND(SUM(Order_Profit_Per_Order)/NULLIF(SUM(Sales),0)*100,2) AS Margin_Pct
FROM supply_chain_orders
GROUP BY Category_Name
ORDER BY Profit DESC
LIMIT 10;


-- Categories with weak delivery + meaningful revenue
SELECT
    Category_Name,
    ROUND(SUM(Sales),2) AS Revenue,
    ROUND(AVG(Late_Flag)*100,2) AS Late_Rate_Pct,
    ROUND(AVG(Shipping_Delay_Days),2) AS Avg_Delay_Days
FROM supply_chain_orders
GROUP BY Category_Name
HAVING SUM(Sales) >= 500000
ORDER BY Late_Rate_Pct DESC;



