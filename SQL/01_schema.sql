-- DataCo Supply Chain Analytics
-- MySQL 8+ schema
-- PII fields intentionally excluded.
-- Matches the cleaned DataCo analytics dataset used in Python and Excel.

CREATE DATABASE IF NOT EXISTS dataco_supply_chain;
USE dataco_supply_chain;

DROP TABLE IF EXISTS supply_chain_orders;

CREATE TABLE supply_chain_orders (
    Order_ID BIGINT,
    Order_Item_ID BIGINT,
    Order_Date DATETIME,
    Shipping_Date DATETIME,
    Transaction_Type VARCHAR(50),
    Order_Status VARCHAR(50),
    Delivery_Status VARCHAR(100),
    Shipping_Mode VARCHAR(50),
    Market VARCHAR(50),
    Order_Region VARCHAR(100),
    Order_Country VARCHAR(100),
    Order_State VARCHAR(100),
    Order_City VARCHAR(100),
    Customer_ID BIGINT,
    Customer_Segment VARCHAR(50),
    Category_ID INT,
    Category_Name VARCHAR(150),
    Department_ID INT,
    Department_Name VARCHAR(100),
    Product_Card_ID INT,
    Product_Name VARCHAR(255),
    Product_Price DECIMAL(12,2),
    Order_Item_Product_Price DECIMAL(12,2),
    Order_Item_Quantity INT,
    Order_Item_Discount DECIMAL(12,2),
    Order_Item_Discount_Rate DECIMAL(8,4),
    Sales DECIMAL(14,2),
    Order_Item_Total DECIMAL(14,2),
    Order_Profit_Per_Order DECIMAL(14,2),
    Order_Item_Profit_Ratio DECIMAL(8,4),
    Actual_Shipping_Days INT,
    Scheduled_Shipping_Days INT,
    Shipping_Delay_Days INT,
    Late_Delivery_Risk INT,
    On_Time_Flag TINYINT,
    Late_Flag TINYINT,
    Order_Month VARCHAR(7),
    Quarter VARCHAR(2),

    INDEX idx_order_id (Order_ID),
    INDEX idx_customer_id (Customer_ID),
    INDEX idx_product_id (Product_Card_ID),
    INDEX idx_category (Category_Name),
    INDEX idx_order_date (Order_Date),
    INDEX idx_market (Market),
    INDEX idx_shipping_mode (Shipping_Mode),
    INDEX idx_delivery_status (Delivery_Status)
);
