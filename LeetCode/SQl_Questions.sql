--SQL scenario based questions 
--1.Customers with zero orders
SELECT c.customer_id,c.name
FROM customers c
LEFT JOIN Orders o
ON c.customerID = o.customerID
WHERE o.order_id IS Null;

--2.Second-highest Salary per department 
WITH r AS (
            SELECT e.*,DENSE_RANK() OVER (
            PARTITION BY dept_id ORDER BY Salary DESC
            )  As dr
            FROM employee e 
           )
           SELECT dept_id,emp_id,name,salary 
           FROM r
           WHERE dr = 2;

--3. Top 3 product by category revenue 
WITH rev AS (
             SELECT p.category,p.product_id,
             SUM(oi.quantity * oi.unit_price) AS revenue DESC
             ) AS rk
             FROM rev
             )
             SELECT category, product_id, revenue
             FROM r
             WHERE rk<=3

--4. Duplicate Customer emails
WITH x AS (
            SELECT customer_id,email,
            ROW_NUMBER() OVER (PARTITION BY LOWEER(email) ORDER BY
            updated_at DESC, customer_id Desc ) rn 
            FROM customers 
            WHERE email IS NOT NULL
          )
          SELECT customer_id,email
          FROM x
          WHERE rn >1;

--5.Month -over- Month Sales growth 
WITH m AS(
         SELECT DATE_TRUNC('month',order_date) As month,SUM(amount) AS Sales
         FROM orders
         GROUP BY 1
         )
         SELECT month,sales,
         ROUND(100.0 *(sales - LAG(sales) OVER(ORDER BY month)) /
         NULLIF(LAG(sales) OVER(ORDER BY Month), 0) 2) AS mom_pct
         FROM m;

