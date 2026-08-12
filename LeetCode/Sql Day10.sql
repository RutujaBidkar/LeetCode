-- ============================================================
-- Advanced SQL Data Analysis Practice
-- Problem: Top 2 Customers in Each Month
-- ============================================================

-- Step 1: Create the sales table

CREATE TABLE sales (
    sale_id INT,
    customer_id INT,
    sale_date DATE,
    product VARCHAR(100),
    category VARCHAR(100),
    amount DECIMAL(10,2)
);


-- Step 2: Insert sample data

INSERT INTO sales
(sale_id, customer_id, sale_date, product, category, amount)
VALUES
(1, 101, '2026-01-05', 'Laptop', 'Electronics', 60000),
(2, 102, '2026-01-10', 'Phone', 'Electronics', 30000),
(3, 101, '2026-02-15', 'Mouse', 'Accessories', 2000),
(4, 103, '2026-02-20', 'Laptop', 'Electronics', 55000),
(5, 102, '2026-03-05', 'Keyboard', 'Accessories', 3000),
(6, 101, '2026-03-15', 'Monitor', 'Electronics', 15000),
(7, 103, '2026-03-20', 'Phone', 'Electronics', 28000),
(8, 102, '2026-04-10', 'Laptop', 'Electronics', 65000);


-- ============================================================
-- Question:
-- Find the top 2 customers in each month based on
-- their total sales amount.
-- ============================================================


-- Step 3: Calculate monthly sales for each customer

WITH monthly_sales AS (

    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS month,
        customer_id,
        SUM(amount) AS total_sales

    FROM sales

    GROUP BY
        DATE_FORMAT(sale_date, '%Y-%m'),
        customer_id
),

-- Step 4: Rank customers within each month

customer_rank AS (

    SELECT
        month,
        customer_id,
        total_sales,

        RANK() OVER (
            PARTITION BY month
            ORDER BY total_sales DESC
        ) AS rank

    FROM monthly_sales
)

-- Step 5: Return top 2 customers

SELECT
    month,
    customer_id,
    total_sales,
    rank

FROM customer_rank

WHERE rank <= 2

ORDER BY
    month,
    rank;

    WITH customer_month AS (
    SELECT DISTINCT
        customer_id,
        DATE_FORMAT(sale_date, '%Y-%m') AS month
    FROM sales
),

previous_month AS (
    SELECT
        customer_id,
        month,
        LAG(month) OVER (
            PARTITION BY customer_id
            ORDER BY month
        ) AS previous_purchase_month
    FROM customer_month
)

SELECT
    customer_id,
    month,
    previous_purchase_month,
    
    CASE
        WHEN previous_purchase_month IS NOT NULL
        THEN 'Returning Customer'
        ELSE 'New Customer'
    END AS customer_type

FROM previous_month

ORDER BY
    customer_id,
    month;