-- ============================================================
-- Schema for the Sales Data Analysis project (MySQL)
-- ============================================================

CREATE DATABASE IF NOT EXISTS sales_analytics;
USE sales_analytics;

-- Fact table: one row per order line item
CREATE TABLE IF NOT EXISTS sales (
    order_id     INT PRIMARY KEY,
    order_date   DATE NOT NULL,
    customer_id  VARCHAR(20) NOT NULL,
    product      VARCHAR(100) NOT NULL,
    category     VARCHAR(50)  NOT NULL,
    region       VARCHAR(50)  NOT NULL,
    quantity     INT NOT NULL,
    unit_price   DECIMAL(12,2) NOT NULL
);

-- Dimension table: customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id    VARCHAR(20) PRIMARY KEY,
    customer_name  VARCHAR(120) NOT NULL,
    region         VARCHAR(50)
);

-- Load the CSV into `sales` (adjust the path as needed):
--
-- LOAD DATA LOCAL INFILE 'data/sales_data.csv'
-- INTO TABLE sales
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (order_id, order_date, customer_id, product, category, region, quantity, unit_price);
