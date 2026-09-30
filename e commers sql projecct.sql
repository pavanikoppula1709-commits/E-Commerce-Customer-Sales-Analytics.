create database E_Commerce;
use E_Commerce;

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date VARCHAR(50), 
    customer_name VARCHAR(100),
    state VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE order_details (
    order_id VARCHAR(50),
    amount DECIMAL(10, 2),
    profit DECIMAL(10, 2),
    quantity INT,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    payment_mode VARCHAR(50)
);
select * from orders;
select * from order_details;
-- checking the missing values --
SELECT 
    COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS missing_orders,
    COUNT(CASE WHEN amount IS NULL THEN 1 END) AS missing_amounts
FROM order_details;
-- checking duplicate records -- 
SELECT order_id, category, sub_category, COUNT(*)
FROM order_details
GROUP BY order_id, category, sub_category
HAVING COUNT(*) > 1;

-- 1. What is the overall revenue and total profit generated across all orders? --
SELECT 
    SUM(amount) AS total_revenue,
    SUM(profit) AS total_profit
FROM order_details;

-- 2. Which payment mode is most frequently used by customers? --
SELECT 
    payment_mode,
    COUNT(DISTINCT order_id) AS total_orders
FROM order_details
GROUP BY payment_mode
ORDER BY total_orders DESC
LIMIT 1;

-- 3. How many unique product categories and sub-categories are available in the dataset? --
SELECT 
    COUNT(DISTINCT category) AS unique_categories,
    COUNT(DISTINCT sub_category) AS unique_sub_categories
FROM order_details;

-- 4. What are the top 5 states with the highest number of orders? --
SELECT 
    state,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY state
ORDER BY total_orders DESC
LIMIT 5;

-- 5. What is the total quantity of products sold for each product category? --
SELECT 
    category,
    SUM(quantity) AS total_quantity_sold
FROM order_details
GROUP BY category
ORDER BY total_quantity_sold DESC;

-- 6. What is the total sales amount and total profit month-over-month? --
SELECT 
    DATE_FORMAT(STR_TO_DATE(o.order_date, '%d-%m-%Y'), '%Y-%m') AS sales_month,
    SUM(d.amount) AS monthly_revenue,
    SUM(d.profit) AS monthly_profit
FROM orders o
JOIN order_details d ON o.order_id = d.order_id
GROUP BY sales_month
ORDER BY sales_month ASC;
 
-- 7. Which sub-categories are operating at a net loss or have the lowest profit margins? --
SELECT 
    sub_category,
    SUM(amount) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(amount)) * 100, 2) AS profit_margin_pct
FROM order_details
GROUP BY sub_category
ORDER BY profit_margin_pct ASC;

-- 8. What is the Average Order Value (AOV) per customer state? -- 
SELECT 
    o.state,
    ROUND(SUM(d.amount) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_details d ON o.order_id = d.order_id
GROUP BY o.state
ORDER BY average_order_value DESC;

-- 9. Who are the top 10 customers based on total monetary spend? --
SELECT 
    o.customer_name,
    SUM(d.amount) AS total_spend
FROM orders o
JOIN order_details d ON o.order_id = d.order_id
GROUP BY o.customer_name
ORDER BY total_spend DESC
LIMIT 10;

-- 10. What percentage of total sales revenue does each product category contribute? -- 
SELECT 
    category,
    SUM(amount) AS category_revenue,
    ROUND((SUM(amount) * 100.0 / (SELECT SUM(amount) FROM order_details)), 2) AS revenue_contribution_pct
FROM order_details
GROUP BY category
ORDER BY revenue_contribution_pct DESC;

-- 11. How can we categorize customers into Recency, Frequency, and Monetary (RFM) ranks using SQL window functions? --
WITH customer_metrics AS (
    SELECT 
        o.customer_name,
        MAX(o.order_date) AS last_order_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(d.amount) AS monetary_value
    FROM orders o
    JOIN order_details d ON o.order_id = d.order_id
    GROUP BY o.customer_name
)
SELECT 
    customer_name,
    last_order_date,
    frequency,
    monetary_value,
    NTILE(4) OVER (ORDER BY last_order_date DESC) AS recency_score,
    NTILE(4) OVER (ORDER BY frequency ASC) AS frequency_score,
    NTILE(4) OVER (ORDER BY monetary_value ASC) AS monetary_score
FROM customer_metrics;

-- 12. What is the cumulative running total of sales revenue ordered chronologically by order date? -- 
WITH daily_sales AS (
    SELECT 
        o.order_date,
        SUM(d.amount) AS daily_revenue
    FROM orders o
    JOIN order_details d ON o.order_id = d.order_id
    GROUP BY o.order_date
)
SELECT 
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY order_date ASC) AS running_total_revenue
FROM daily_sales;

-- 13. What percentage of total customers have placed more than 3 distinct orders? -- 
WITH customer_orders AS (
    SELECT 
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_name
)
SELECT 
    COUNT(CASE WHEN total_orders > 3 THEN 1 END) AS repeat_customers,
    COUNT(*) AS total_customers,
    ROUND((COUNT(CASE WHEN total_orders > 3 THEN 1 END) * 100.0 / COUNT(*)), 2) AS repeat_customer_rate_pct
FROM customer_orders;

-- 14. What is the percentage growth in revenue for each month compared to the previous month using window functions? --
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(o.order_date, '%d-%m-%Y'), '%Y-%m') AS sales_month,
        SUM(d.amount) AS revenue
    FROM orders o
    JOIN order_details d ON o.order_id = d.order_id
    GROUP BY sales_month
)
SELECT 
    sales_month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY sales_month ASC) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue, 1) OVER (ORDER BY sales_month ASC)) / 
        LAG(revenue, 1) OVER (ORDER BY sales_month ASC)) * 100, 2
    ) AS mom_growth_pct
FROM monthly_revenue
WHERE sales_month IS NOT NULL
ORDER BY sales_month ASC;

-- 15. Which combination of State and Category generates above-average sales volume but below-average profit margins? --
WITH group_metrics AS (
    SELECT 
        o.state,
        d.category,
        SUM(d.amount) AS total_revenue,
        ROUND((SUM(d.profit) / SUM(d.amount)) * 100, 2) AS profit_margin_pct
    FROM orders o
    JOIN order_details d ON o.order_id = d.order_id
    GROUP BY o.state, d.category
),
averages AS (
    SELECT 
        AVG(total_revenue) AS avg_revenue,
        AVG(profit_margin_pct) AS avg_margin
    FROM group_metrics
)
SELECT 
    g.state,
    g.category,
    g.total_revenue,
    g.profit_margin_pct
FROM group_metrics g, averages a
WHERE g.total_revenue > a.avg_revenue
  AND g.profit_margin_pct < a.avg_margin
ORDER BY g.total_revenue DESC;