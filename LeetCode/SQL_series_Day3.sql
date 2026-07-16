--Sql Query Day 3
--Find Duplicate records 
SELECT CoustomerName, Email COUNT(*)
FROM Table Employee 
GROUP BY Email
HAVING COUNT(*) > 1

--Retrive The second highest salary From Emp
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee 

--Find Emp Without Department
SELECT e.*
FROM Employee 
LEFT JOIN Department d
ON e.departmentID = d.departmentID
WHERE d,department IS NULL;

--Calculate the total revenue per product(paypal)
SELECT  productID, SUM(quantity * price) AS total_revenue
FROM Sales 
GROUP BY product_id;

--get the top 3 highest-paid employee 
SELECT TOP3 *
FROM Employee 
ORDER BY Salary Desc;

--Customers Who made purchases but never returned 
SELECT DISTINCT c.customer_id
FROM Customers c
JOIN Orders o.ON c.customerID = o.customerID
WHERE c.customerID NOT IN (SELECT customerID From Returns);

--Show the count of orders per customer(Male)
SELECT Customer_iD, Gender, COUNT(*) AS Order_Count
FROM Orders 
GROUP BY Customer_id 
HAVING Gender = 'Male';

--Retrive all employee Who joined in 2023
SELECT EmployeeName, DateofJoining
FROM Employee 
WHERE DateofJoining = 2023

--Calculate average order value per customer
SELECT customerID, AVG(total_amount) AS avg_order_value
FROM Orders 
GROUP BY customer_id;

--Get the latest order placed by each customer(uber)
SELECT CustomerID, (Order_date) AS latest_order_date
FROM Orders 
ORDER BY CustomerID Desc;

SELECT customerID, MAX(order_date) As Latest_order
FROM Orders 
GROUP BY customerID

--FIND products that were never sold()
SELECT p.product_id
FROM Productsp
LEFT JOIN Sales s ON p.product_id = s.product_id
WHERE s.product_id IS NULL;

--Identify the most selling product
SELECT Top 1 product_id, SUM(quantity) AS total_qty
FROM Sales
GROUP BY product_ID
ORDER BY total_qty DESC;

--Get total revenue and number of orders per region (meta)
SELECT region, SUM(total_amount) AS total_revenue, COUNT(*) 
FROM Orders 
GROUP BY region;

--Count customers with more than 5 orders 
SELECT COUNT(*) As customer_count
FROM (
  SELECT Customer_id FROM Orders
  GROUP BY customer_id
  HAVING COUNT(*) > 5
  ) AS subquery;

--Retrive customers with orders above average order value 
SELECT * 
FROM Orders
WHERE total_amount > (SELECT AVG(total_amount) FROM Orders);

--Find All employee hired on weekends 
SELECT *
FROM Employee WHERE DATENAME (WEEKDAY, HireDate) IN ('Saturday','Sunday');

--Find all employee with salary between 500000 and 100000
SELECT Salary 
FROM Employee 
WHERE Salary BETWEEN 500000 AND 100000

--Get monthly sales revenue and order count 
SELECT FORMAT(date, 'YYYY-MM') AS month,
SUM(Amount) As total_revenue,
COUNT(order_id) AS order_count
FROM Orders
GROUP By FORMAT(date, 'YYYY-MM');

--Rank Employee by salary within each department(Amazon)
SELECT employee_ID, department_id, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC)
FROM Employee;

--Find Customers who placed orders every month in 2023
SELECt customer_id 
FROM Orders 
WHERE YEAR(order_date) = 2023
GROUP BY customer_id
HAVING COUNt(DISTINCT FORMAT (order_date, 'YYYY-MM')) = 12;

--Identify customers with revenue below the 10th percentile
WITH cte AS (
  SELECT customer_id, SUM(total_amount) As total_revenue
  FROM Orders
  GROUP BY Customer_id
)
SELECT customer_id, total_revenue
FROM cte 
WHERE total_revenue < 
( 
    SELECT percentile_cont(0.1) WITHIN GROUP( ORDER BY total_revenue) FROM cte
    );



--List all customers who have placed at least one order.
SELECT c.customerID, c.customerName, c.city
FROM customer c
INNER JOIN  Orders o
ON c.customerID  = o.customerID

--List all customers who have never placed any order.
SELECT c.customerID, c.customerName, c.city
FROM customer c
LEFT JOIN Order o
ON c.customerID = o.customerID
WHERE o.orderID IS NULL;

--List customers and their order count 
SELECT c.customerID, c.customerName, c.city 
COUNT(o.orderID) AS Order_count
FROM Customer c
LEFT JOIN Orders o 
ON c.customerID = o.customerID
GROUP BY c.customer_id, c.customer_Name, c.city
ORDER BY c.customerID

--Find total amount spent by each customer.
SELECT c.customerID, c.customerName,
COALESCE(SUM(o.amount),0) As total_Amount
FROM Customer c
LEFT JOIN Order o
ON c.customerID = o.customerID
GROUP BY c.customer_id, c.customer_name
ORDER BY c.customerID;


--LIST all employee who belong to the 'HR' Department 
SELECT Emp.Employee_Name, d.department_Name
FROM Employee Emp
INNER JOIN Department d
ON Emp.departmentId = d.departmentId
WHERE d.department_Name='HR';

--List the number of employee in each department 
SELECT Emp.Employee_Name, d.department_Name , COUNT(Emp.Employee_ID)
FROM Employee Department d 
ON Emp.departmentID = d.departmentID 
GROUP BY d.department_Name
ORDER BY d.department_Name;

--List all employee along with their department names
SELECT e.name, d.department_name
FROM Employee 
INNER JOIN Department d
ON e.departmentID = d.departmentID
ORDER BY e.name;

--list the name of employee who are in departments other than 'HR'
SELECT e.name, d.department_name 
FROM Employee e 
INNER JOIN Department d
ON e.departmentID = d.departmentID 
WHERE d.department_name <> 'HR'
ORDER BY e.name;






