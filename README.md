# 🛒 E-Commerce Sales & Customer Analytics Using SQL
To use SQL-driven e-commerce analytics to identify revenue and profit drivers, understand customer purchasing behavior, evaluate product and regional performance, and uncover opportunities for business improvement.

## 📌 Project Overview

This project analyzes **e-commerce sales and transaction data using MySQL** to understand business performance across revenue, profitability, customers, products, payment methods, and geographical regions.

The analysis uses SQL to transform transactional data into meaningful business insights that can support **sales optimization, customer analysis, product performance evaluation, and regional decision-making**.

---

## 🎯 Business Objective

The primary objective of this project is to:

* Analyze overall revenue and profit performance
* Identify monthly sales and profit trends
* Understand customer purchasing behavior
* Identify high-value and repeat customers
* Evaluate product category and sub-category performance
* Analyze regional sales performance
* Understand customer payment preferences
* Identify low-margin and potentially loss-making products
* Identify high-sales but low-margin state-category combinations
* Apply advanced SQL techniques to generate business insights

---

## 💼 Business Problem Statement

> **An e-commerce business needs to understand its sales performance, profitability, customer purchasing behavior, product performance, and regional trends in order to identify growth opportunities, improve customer retention, and detect areas of weak profitability.**

This project addresses these business requirements by analyzing order and order-detail data using SQL.

---

## 📊 Dataset Structure

The database contains two primary tables:

### 1. `orders`

Contains order-level and customer/location information.

| Column          | Description             |
| --------------- | ----------------------- |
| `order_id`      | Unique order identifier |
| `order_date`    | Date of the order       |
| `customer_name` | Customer name           |
| `state`         | Customer state          |
| `city`          | Customer city           |

### 2. `order_details`

Contains product and transaction-level information.

| Column         | Description          |
| -------------- | -------------------- |
| `order_id`     | Order identifier     |
| `amount`       | Sales amount         |
| `profit`       | Profit generated     |
| `quantity`     | Quantity sold        |
| `category`     | Product category     |
| `sub_category` | Product sub-category |
| `payment_mode` | Payment method       |

The two tables are connected using `order_id`.

---

## 🔍 Data Quality Checks

Before performing business analysis, the project checks the dataset for:

* Missing order IDs
* Missing sales amounts
* Duplicate order/category/sub-category combinations

These checks help ensure that the analysis is performed on consistent transaction data.

---

# 📈 Business Analysis Performed

## 1. Overall Revenue & Profitability

Calculated:

* Total revenue
* Total profit

This provides a high-level view of the company's financial performance.

---

## 2. Payment Mode Analysis

Identified the payment mode used most frequently by customers based on the number of distinct orders.

**Business use:** Helps understand customer payment preferences.

---

## 3. Product Portfolio Analysis

Calculated the number of:

* Unique product categories
* Unique product sub-categories

This provides an overview of the product assortment.

---

## 4. Regional Order Analysis

Identified the **top 5 states by number of orders**.

**Business use:** Helps identify regions generating the highest order volume.

---

## 5. Category Sales Volume

Calculated the total quantity of products sold for each category.

**Business use:** Helps identify categories with higher product demand.

---

## 6. Monthly Revenue & Profit Analysis

Calculated monthly:

* Revenue
* Profit

The order date was converted into a monthly format before aggregation.

**Business use:** Helps monitor sales and profitability trends over time.

---

## 7. Sub-Category Profitability Analysis

Calculated:

* Total sales
* Total profit
* Profit margin %

for each sub-category.

The analysis orders sub-categories by profit margin to identify lower-margin areas.

**Business use:** Helps identify products requiring further pricing or cost analysis.

---

## 8. Average Order Value by State

Calculated the Average Order Value (AOV) for each state.

**Business use:** Helps compare customer order values across geographical markets.

---

## 9. Top 10 Customers by Spending

Identified the top 10 customers based on their total monetary spending.

**Business use:** Helps identify high-value customers.

---

## 10. Category Revenue Contribution

Calculated the percentage of total revenue contributed by each product category.

**Business use:** Helps understand which categories contribute most to overall sales revenue.

---

# 👥 Advanced Customer Analysis

## 11. RFM-Style Customer Ranking

The project calculates customer-level:

* **Recency** — based on the customer's latest order date
* **Frequency** — number of distinct orders
* **Monetary Value** — total amount spent

SQL `NTILE(4)` window functions are then used to assign scores for these three dimensions.

### Business Application

This analysis can help businesses understand different customer purchasing patterns and identify customers based on their recent activity, purchase frequency, and monetary value.

---

## 12. Cumulative Revenue Analysis

Calculated daily revenue and the cumulative running total of revenue using a SQL window function.

**Business use:** Helps track how total revenue accumulates over the sales period.

---

## 13. Repeat Customer Analysis

Calculated:

* Number of repeat customers
* Total customers
* Repeat customer rate

A repeat customer is defined in this analysis as a customer with **more than 3 distinct orders**.

**Business use:** Provides an indicator of repeat purchasing behavior.

---

## 14. Month-over-Month Revenue Growth

Used the SQL `LAG()` window function to compare monthly revenue against the previous month and calculate monthly revenue growth percentage.

**Business use:** Helps identify periods of revenue growth or decline.

---

# 🎯 Strategic Business Analysis

## 15. High-Sales but Low-Margin State × Category Analysis

The project compares each **state + product category** combination against the average revenue and average profit margin.

It identifies combinations where:

* Revenue is **above average**
* Profit margin is **below average**

### Business Significance

These combinations represent areas where the business generates relatively strong sales volume but comparatively lower margins.

They can be investigated further for factors such as:

* Pricing
* Discounts
* Product costs
* Product mix
* Regional strategy

---

# 🧠 SQL Skills Demonstrated

This project demonstrates practical knowledge of:

### SQL Fundamentals

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* Aggregate functions
* `COUNT()`
* `SUM()`
* `AVG()`

### Data Quality

* NULL checking
* Duplicate detection

### Data Combination

* `INNER JOIN`

### Advanced SQL

* Common Table Expressions (`WITH`)
* Subqueries
* Conditional aggregation
* Date conversion and formatting
* Percentage calculations

### Window Functions

* `NTILE()`
* `LAG()`
* Running totals using `SUM() OVER()`

---

# 🛠️ Tools & Technologies

* **Database:** MySQL
* **Language:** SQL
* **Techniques:** Data Cleaning, Aggregation, Joins, CTEs, Subqueries, Window Functions
* **Analysis Areas:** Sales Analytics, Customer Analytics, Product Analytics, Profitability Analysis, Regional Analytics

---

# 📌 Key Business Areas Covered

| Business Area      | Analysis                                        |
| ------------------ | ----------------------------------------------- |
| Sales Performance  | Revenue, monthly sales, revenue growth          |
| Profitability      | Profit, profit margin, low-margin subcategories |
| Customer Analytics | Top customers, repeat customers, RFM ranking    |
| Product Analytics  | Categories, subcategories, quantity sold        |
| Regional Analytics | State orders, state-level AOV                   |
| Payment Analytics  | Payment mode usage                              |
| Strategic Analysis | State × Category sales vs. margin               |

---

# 🚀 Business Value

The analysis provides a structured view of e-commerce performance by connecting **sales, customers, products, profitability, and geography**.

The most strategic analysis identifies **state-category combinations with above-average sales but below-average profit margins**, helping highlight areas that may require additional investigation into pricing, costs, discounts, or product strategy.

---

# 📂 Project Files

```text
E-Commerce-SQL-Analytics/
│
├── e_commerce_sql_project.sql
└── README.md
```

---

# 💡 Project Outcome

> **The project demonstrates how SQL can be used to transform transactional e-commerce data into business-focused analysis covering revenue performance, profitability, customer behavior, product demand, regional performance, and growth trends.**

It also demonstrates the ability to move beyond basic SQL queries and apply **CTEs, subqueries, joins, and window functions** to solve practical business problems.

---

## 👩‍💻 Skills Demonstrated

**SQL | MySQL | Data Analysis | Data Cleaning | Business Analysis | Customer Analytics | Sales Analytics | Profitability Analysis | CTEs | Subqueries | Joins | Window Functions | RFM Analysis**
