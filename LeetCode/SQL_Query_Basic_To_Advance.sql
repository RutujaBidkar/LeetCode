--Basic to advance Query 

--SELECT & FROM
SELECT * FROM Orders;
SELECT Order_id, Customer_id, revenue FROM Orders;
SELECT DISTINCT city FROM Customers;
SELECT DISTINCT city, region FROM Customers;
SELECT order_id, revenue * 1.18 As revenue_with_gst FROM ders;
SELECT CONCAT(first_name, ' ' , last_name) AS Full_name FROM employees;
SELECT UPPER(city) AS City_upper FROM Customers;
SELECT LOWER(Email) AS email_clean FROM Customers;
SELECT TRIM(Name) As Name_Clean FROM Customers;
SELECT LENGTH(email) AS Email_Length FROM Users;
SELECT Round(revenue, 2) As revenue_rounded FROM orders;
SELECT NOW() AS Current_timestamp;
SELECT order_id, COALESCE(discount, 0) AS discount FROM orders;
SELECT order_id, IFNULL(notes, 'NO notes') AS notes FROM or ders;
SELECT order_id, NULLIF(status, 'pending') As status FROM orders

--WHERE 
SELECT * FROM orders WHERE status='completed';
SELECT * FROM orders WHERE revenue > 500000;
SELECT * FROM orders WHERE revenue BETWEEN  10000 AND 500000;
SELECT * FROM orders WHERE CITY IN('Delhi', 'Mumbai');
SELECT * FROM orders WHERE CiTY NOT IN ('Delhi','Mumbai')
SELECT * FROM Customers Where EMAIL LIKE '%@gmail.com';
SELECT * FROM Customers WHERE name LIKE 'RAJ%';
SELECT * FROM Customers WHERE name Like '%Shrama';
SELECT * FROM orders WHERE discount IS NULL;
SELECT * FROM orders WHERE discount IS NOT NULL;
SELECT * FROM orders WHERE status = 'completed' AND revenue > 10000;
SELECT * FROM orders WHERE city = 'Delhi' OR city ='Mumbai';
SELECT * FROM orders WHERE NOT status = 'Cancelled'
SELECT * FROM orders WHERE revenue >10000 AND City ='Delhi' And status ="completed"
SELECT * FROM orders WHERE city = 'Delhi' OR city = 'Mumbai' AND revenue > 50000;
SELECT * FROM orders WHERE YEAR(order_date) = 2024;
SELECT * FROM orders WHERE MONTH (order_date) =3;
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-03-31';
SELECT * FROM orders WHERE DAYOFWEEKK(order_date) =2;

--ORDER BY & LIMIT 
SELECT * FROM orders ORDER BY revenue DESC;
SELECT * FROM orders ORDER BY city ASC, revenue DESC;
SELECT * FROM orders ORDER BY order_date DESC;
SELECT * FROM orders ORDER BY revenue DESC LIMIT 5;
SELECT * FROM orders LIMIT 10 OFFSET 20;
SELECT * FROM orders ORDER BY order_date DESC LIMIT 1;

--Aggregate Function 
SELECT COUNT(*) FROM orders;
SELECT COUNT(DISTINCT Customer_ID) FROM orders;
SELECT SUM(revenue) FROM orders;
SELECT AVG(revenue) FROM orders;
SELECT MAX(revenue), MIN(revenue) FROM orders;
SELECT COUNT(*), SUM(revenue), AVG(revenue), MAX(revenue), MIN(revenue) FROM orders;
SELECT SUM(revenue) FROM orders WHERE status ="completed"
SELECT ROUND(AVG(revenue), 2) AS avg_revenue FROM orders;
SELECT SUM(units * price) AS total_value FROM order_items;
SELECT COUNT(*) AS total, COUNT(discount) AS with_discount,
       COUNT(*) -COUNT(discount) AS without_discount FROM orders;

--Group by 
SELECT city, COUNT(*) AS total_orders FROM orders GROUP BY City;
SELECT city, SUM(revenue) AS total_revenue FROM orders GROUP BY City;
SELECT city, AVG(revenue) As Avg_revenue FROM orders GROUP BY city;
SELECT city, MAX(revenue) AS Max_revenue FROM orders GROUP BY city;
SELECT city, COUNT(DISTINCT customer_id) AS unique_customers FROM orders GROUP BY city;
SELECT city, status, COUNT(*) AS total FROM orders GROUP BY City, Status;
SELECT city, SUM(revenue) AS total_revenue FROM orders GROUP BY city ORDER BY total_revenue DESC;
SELECT YEAR(order_date) AS yr, MONTH(order_date) AS mo, SUM(revenue) AS revenue FROM orders GROUP BY yr, mo ORDER BY yr,mo;
SELECT City, SUM(revenue) AS total_revenue FROM orders GROUP BY total_revenue DESC LIMIT 5;
SELECT status, COUNT(*) AS Count, ROUND(AVG(revenue), 0) AS avg_reg FROM orders GROUP BY status;

--HAVING 
SELECT city,SUM(revenue) AS total FROM orders GROUP BY city HAVING total > 500000;
SELECT city, COUNT(*) AS orders FROM orders GROUP BY city HAVING orders > 100;
SELECT customer_id, COUNT(*) AS total_orders FROM orders GROUP BY city HAVING total_order >=5;
SELECT city, SUM(revenue) AS total FROM orders GROUP BY city HAVING total BETWEEN 100000 AND 500000;
SELECT product_id, AVG(revenue) AS avg_rev FROM orders  GROUP BY city HAVING unique_customers > 50 ORDER BY unique_customers DESC;

--JOINS 
--INNER JOIN
SELECT o.order_id, c.name, o.revenue
FROM Orders o INNER JOIN Customers c ON 
c.customerID = o.customerID

--LEFT JOIN 
SELECT c.name, o.order_id, o.revenue
FROM customers c LEFT JOIN orders o  ON
c.customer_ID = o.customer_ID 

--Customers With no orders 
SELECT c.name, c.city FROM Customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;

--Three table Join 
SELECT o.order_id, C.name, p.product_name, oi.quantity 
FROM orders o 
JOIN Customers c ON o.customer_ID = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

--SELF JOIN Employee AND Manager 
SELECT e.name AS employee, m.name AS manager 
FROM employee e LEFT JOIN employee m ON e.manager_id =m.employee_id;

--Join With aggregation
SELECT c.city, COUNT(o.order_id) AS total_order, SUM(o.revenue) AS total_revenue
FROM customers c JOIN orders o ON  c.CustomerID = o.CustomerID
GROUP BY c.City ORDER BY total_revenue DESC;

--JOIN with Filter
SELECT c.name, o.order_id, o.revenue
FROM Customers c JOIN orders o ON c.CustomerID= o.customerID
WHERE o.revenue > 500000 AND c.city ='Delhi';


--FULL OUTER JOIN 
SELECT C.name, o.order_id FROM Customers C LEFT JOIN orders o ON c.customerID = o.CustomerID
UNION
SELECT c.name, o.order_id FROM customers c RIGHT JOIN orders ON C.CustomerID = o.CustomerID;

SELECT * FROM orders WHERE revenue > (SELECT AVG (revenue) FROM orders;

SELECT * FROM Customers WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);

SELECT MAX(revenue) FROM orders WHERE revenue < (SELECT MAX(revenue) FROM orders);

--Orders above each city's average

SELECT o.* FROM orders o
JOIN(SELECT city, AVG(revenue) AS avg_rev FROM Orders GROUP BY City) city_avg
ON o.city = city_avg.city WHERE o.revenue > city_avg.avg_rev;

--Correlated subquery 
SELECT * FROM orders o1 WHERE revenue > ( SELECT AVG(revenue) FROM orders o2 WHERE o2.customer_id = o1.customer_id);

--EXITS
SELECT * FROM Customers c WHERE EXISTS (
SELECT 1 FROM orders o WHERE o.customer_id = c.CustomerID AND o.revenue > 1000000);
