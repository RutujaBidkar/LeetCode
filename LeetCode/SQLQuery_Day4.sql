--DAY 4 SQL_Query 
--Identify the first and last order date for each customer 
SELECT Customer_ID, MIN(Order_date) As First_Salary, MAX(Order_date) As Last_Salary 
FROM Orders 
GROUP BY Customer_id;

--Find churned customers (no orders in the last 6 month)
SELECT Cusomer_id
FROM Orders
GROUP BY Customer_id 
HAVING MAX(order_date) < DATEADD(MONTH, -6, GETDATE())

--Calculate cumulative revenue by day 
SELECT order_date,
SUM(Total_amount) OVER (ORDER BY Order_date) AS Cumulative_revenue
FROM Orders;

--Identify top- performing departments by average salary 
SELECT department_id, AVG(Salary) AS  AVG avg_salary 
FROM Employee 
GROUP BY department_id
ORDER BY avg_salary DESC;

-- FIND customers who ordered more than the average number of orders per customer (Male)

WITH customer_orders AS(
SELECT Customer_ID, COUNT(*) AS order_count
FROM Orders
GROUP BY customer_ID
)
SELECT * FROM customer_orders
WHERE order_count > (SELECT AVG(Order_Count) FROM customer_orders);

--Calculate revenue generated from new customers(first- time orders)
WITH first_orders AS (
SELECT customer_id, MIN(order_date) AS first_order_date
FROM Orders 
GROUP BY customer_id
)
SELECT SUM(o.total_amount) AS new_revenue
FROM Orders o 
JOIN first_orders f ON o.customer_id = f.customer_id
WHERE o.order_date = f.first_order_date;


--List All customers who have placed an order 
SELECT c.name, c.email
FROM Customers
WHERE c.customer_id IN 
(SELECT CustomerID
FROM Orders);

--List total number of orders placed by each customer 
SELECT c.name, COUNT(o.order_id) AS total_orders 
FROM customer c 
LEFT JOIN Orders o 
ON c.customerId = o.customer_Id
GROUP BY c.name
ORDER BY total_orders DESC;

--Display the total amount spent by each customer
SELECT c.name, COALESCE(SUM(o.total_amount),0) As total_spent
FROM Customer c
LEFT JOIN Orders o ON c.customer_Id = o.customer_Id
GROUP BY c.name
ORDER BY total_spent DESC;


--List Customers Who have not placed any order 
SELECT c.name, c.email
FROM Customer c
WHERE c.customer_id NOT IN
(SELECT customer_id FROM Orders);

