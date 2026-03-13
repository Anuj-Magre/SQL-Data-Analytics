![SQL](https://img.shields.io/badge/SQL-Advanced-blue)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange)
![Data%20Analysis](https://img.shields.io/badge/Data%20Analysis-SQL-green)

# 🛒 Amazon USA Sales Analysis (SQL Project)

## 📊 Project Overview

This project analyzes an **Amazon-style e-commerce dataset** containing more than **20,000 sales records**.  
The analysis focuses on understanding **customer behavior, product performance, sales trends, inventory levels, and operational efficiency** using SQL.

The project simulates real-world **business analytics tasks performed by data analysts in e-commerce companies.**

Key areas analyzed include:

- Sales and revenue performance
- Customer lifetime value
- Product profitability
- Shipping delays
- Inventory monitoring
- Seller performance
- Customer segmentation

---

## 🧰 Tools & Technologies

- **MySQL**
- SQL (Advanced Queries)
- Window Functions
- Subqueries
- Data Cleaning
- GitHub

---

## 🗂 Dataset Description

The dataset represents a simplified **Amazon-like transactional system** including:

- Customers
- Products
- Sellers
- Orders
- Payments
- Shipping
- Inventory

Total Records: **20,000+ sales transactions**

---

## ⚙️ Project Workflow

The analysis followed a structured workflow similar to real-world data analytics projects:

1. **Database Design**
   - Created normalized relational schema for transactional data.

2. **Data Preparation**
   - Cleaned inconsistent values
   - Handled missing data
   - Verified relationships between tables

3. **Exploratory SQL Analysis**
   - Revenue analysis
   - Customer behavior analysis
   - Product performance evaluation

4. **Business Problem Solving**
   - Developed SQL queries to answer real-world e-commerce questions.

5. **Insight Generation**
   - Extracted actionable insights to support business decisions.

---

## 🏗 Database Schema

The database follows a **normalized relational schema** with fact and dimension tables.

### Entity Relationship Diagram

![ERD](https://github.com/Anuj-Magre/SQL-Data-Analytics/blob/main/amazon-sql-data-analysis/erd.png)

---

## 🧩 Database Structure

Tables included in the project:

- `customers`
- `products`
- `category`
- `sellers`
- `orders`
- `order_items`
- `payments`
- `shipping`
- `inventory`

Example schema creation:

```sql
create table order_items (
order_item_id int primary key,
order_id int,  -- fk
product_id int,  -- fk
quantity int,
price_per_unit float,
constraint order_items_fk_orders foreign key (order_id) references orders (order_id),
constraint order_items_fk_products foreign key (product_id) references products (product_id)
);
```
---

# 🎯 Business Problems Solved

This project answers **19 real-world e-commerce business questions** including:

1. Top selling products  
2. Revenue by category  
3. Average order value  
4. Monthly sales trends  
5. Customers with no purchases  
6. Least selling categories by state  
7. Customer lifetime value  
8. Inventory stock alerts  
9. Shipping delays detection 
10. Payment success rate  
11. Top performing sellers  
12. Product profit margin analysis 
13. Most returned products  
14. Orders pending shipment
15. Inactive sellers  
16. Customer segmentation (new vs returning) 
17. Top customers by state  
18. Revenue by shipping provider  
19. Revenue decline analysis by product

---

# 📈 Example SQL Analysis

## Top Selling Products

```sql
SELECT 
    p.product_id,
    p.product_name,
    COUNT(quantity) AS total_quantity_sold,
    ROUND(SUM(oi.total_sale),2) AS total_sales
FROM order_items oi
JOIN products p
ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_quantity_sold DESC
LIMIT 10;
```

---

## Customer Lifetime Value (CLTV)

```sql
SELECT 
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(SUM(total_sale),2) AS CLTV,
    DENSE_RANK() OVER(ORDER BY SUM(total_sale) DESC) AS customer_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY 1,2;
```

---

# 🔍 Key Business Insights

Key insights discovered during the analysis include:

- A small percentage of customers generate a large share of total revenue (high CLTV concentration).
- Certain product categories show significantly higher return rates.
- Shipping delays frequently occur when specific providers are used.
- Some sellers consistently outperform others in both revenue and order success rate.
- Inventory shortages can create lost revenue opportunities.
- Revenue decline trends help identify underperforming products requiring strategic intervention.

---

# 💼 Business Value

The insights from this analysis can help e-commerce businesses:

- Improve **inventory management** to avoid stock shortages.
- Identify **high-value customers** for targeted marketing campaigns.
- Detect **inefficient shipping providers** causing delivery delays.
- Optimize **product pricing and profitability strategies**.
- Reduce **product return rates** through category-level analysis.

---

# 🧠 Skills Demonstrated

This project showcases the following data analytics skills:

- Relational database design
- Advanced SQL querying
- Window functions
- Subqueries and joins
- Business problem solving using SQL
- Data-driven insights generation

---

# 📁 Repository Structure

```
amazon-sql-data-analysis
│
├── dataset/ # Raw dataset files
│ ├── category.csv
│ ├── customers.csv
│ ├── inventory.csv
│ ├── order_items.csv
│ ├── orders.csv
│ ├── payments.csv
│ ├── products.csv
│ ├── sellers.csv
│ └── shipping.csv
│
├── database_schema.sql
├── business_questions.sql 
├── sql_analysis_queries.sql 
├── erd.png 
└── README.md 
```

---

# 🎓 Learning Outcomes

Through this project I strengthened my ability to:

- Design normalized relational schemas
- Write complex SQL queries
- Solve real-world e-commerce business problems
- Extract insights from transactional data
- Build analytical thinking using SQL

---

# 📬 Connect With Me

LinkedIn  
https://www.linkedin.com/in/anujmagre  

Email  
anujmagre77@gmail.com  

---

⭐ If you found this project helpful, consider giving it a star!

