WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT sale_id) AS total_orders
    FROM sales
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_orders,
    
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        WHEN total_orders > 1 THEN 'Repeat Customer'
    END AS customer_type

FROM customer_orders
ORDER BY total_orders DESC;

SELECT
    customer_id,
    COUNT(sale_id) AS total_orders,
    SUM(amount) AS total_spent,
    AVG(amount) AS average_order_value

FROM sales

GROUP BY customer_id

ORDER BY total_orders DESC;


SELECT
    category,
    SUM(amount) AS category_revenue,

    ROUND(
        SUM(amount) * 100.0 /
        SUM(SUM(amount)) OVER (),
        2
    ) AS revenue_percentage

FROM sales

GROUP BY category

ORDER BY category_revenue DESC;


SELECT
    category,
    SUM(amount) AS category_revenue,

    ROUND(
        SUM(amount) * 100.0 /
        SUM(SUM(amount)) OVER (),
        2
    ) AS revenue_percentage

FROM sales

GROUP BY category

ORDER BY category_revenue DESC;

WITH product_sales AS (
    SELECT
        product,
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY product
),

ranked_products AS (
    SELECT
        product,
        total_sales,

        DENSE_RANK() OVER (
            ORDER BY total_sales DESC
        ) AS product_rank

    FROM product_sales
)

SELECT
    product,
    total_sales,
    product_rank

FROM ranked_products

WHERE product_rank <= 3;

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM sales
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_spent,

    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank

FROM customer_sales

ORDER BY customer_rank;