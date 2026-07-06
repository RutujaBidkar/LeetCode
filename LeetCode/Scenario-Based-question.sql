---Scenario Based Interview Questions 
--1. Customers With Zero Orders 
--Scenarion: Marking Wants a list of signed -up Customers who have never placed an order 
--Table: Customers(Customer_id,Name,Signup_date),
-- Orders(order_id,Customer_id,order_date,Amount)
--Question: Return Customer_id,And Name for customers with no order records 
SELECT Cust.Customer_id,
       Cust.Name,
       FROM Customers Cust
       LEFT JOIN Orders Ord
       ON Cust.CustomerID = Ord.CustomerID
       WHERE Ord.OrderID IS NULL;

--2.Second Highest salary Per department 
--Scenarion : HR needs the second highest distinct Salary In each department, including ties 
--Table: Employee(emp_id,name, dept_id,salary),
--        departments(dept_id,dept_name)
--Question : Write a queryto return employees whhose salary rank is 2 within the department 
WITH 2ndRANK AS(
            SELECT Emp *,
            DENSE_RANK() OVER (
            PARTITION BY dept_id ORDER BY Salary DESC )
            AS SecondRank 
            FROM Employee Emp 
            )
            SELECT Dept_ID,Emp_ID,Name,Salary
            FROM 2ndRANK 
            WHERE SecondRank 

--3. Top 3 product by category revenue
--Scenario : A e-commerce team wants best sellers by category Bases
--Table : Products(Product_id,Product_Name,Category),
--        Order_items(order_id, Product_id, Qty, unit_price 
--Question : Find the top 3 products per category by total revenue.
WITH top3 AS(
             SELECT P.category,p.Product_id,
             SUM(OrdItem.Quantity * OrdItem.Unit_Price) AS revenue
             FROM Order_Items OrdItem 
             JOIN Product P ON 
             P.Product_id = OrdITem.Product_id
             GROUP BY P.category,P.Product_id
             )
             r AS (
             SELECT *, DENSE_RANK() OVER(
             PARTITION BY category Order BY Revenue DESC ) AS Rk
             FROM top3
             )
             SELECT Category, Product_id, revenue
             FROM r
             WHERE Rk <= 3;

--4.Duplicate Customer Emails 
--Scenario : A CRM Table has Duplicate emails Because users signed up Multiple times
--Table  : Customers (Customer_Id,Emails,Name,updated_at)
--Question : Identify Duplicate rows to remove, keeping the newest record per email.

WITH x AS(
         SELECT Customer_id,Email,
         Row_Number() OVER (Partition By LOWER(Email) ORDER BY Updated_at DESC, Customer_Id DESC ) rn
         FROM Customers 
         WHERE Email IS NOT NULL
         )
         SELECT Customer_id, Email
         FROM x
         WHERE rn > 1;

--5.Month- over- month Sales growth 
--scenario: Finance wants monthly sales and the percentage growth from the previous month
-- Tables: orders(order_id,order_date, amount)
--Question : Calculate monthly sales and MOM growth percentage.
WITH m AS (
          SELECT Date_Trunc('month',order_date) As Month,SUM(Amount) AS Sales
          FROM Orders GROUP BY 1
          )
          SELECT month,sales,
          ROUND(100.0 * (sales -LAG(sales) OVER (ORDER By Month)) /
          NULLIF(LAG(sales) OVER(ORDER BY month), 0) 2) AS mom_pct
          FROM m;

--6.Running total per customer 
--Scenarion : A payment team wants cumulative spend after each payment 
--Tables : payments (payment_id,customer_id, payment_date, amounr)
--Question  : Show each payment with the customer_level running total
SELECT customer_id, payment_date, Amount,
       SUM(Amount) OVER(
       PARTITION BY Customer_id
       ORDER BY Payment_date
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
       FROM payments;

--7. 7 days rolling average sales 
SELECT Sale_date,Sale_amount,
       AVG(Sales_Amount) OVER(Order By Sale_date
       ROWS BETWEEN 6 PRECEDING AND CURRENT ROW 
       ) AS Avg_7d
       FROM Daily_sales;

--8.Orders Shipped late 
SELECT o.order_id, s.shipped_date
       FROM orders o 
       JOIN Shipments s ON s.order_id = o.order_id
       WHERE s.shipped_date > o.order_date + INTERVAl '2 day';

--9.Employee Earning more than manager 
SELECT e.name AS employee, e.salary,
        m.name AS manager, m.salary AS manager_salary
        FROM employee e 
        JOIN Employee m ON 
        m.emp_id =e.manager_id
        WHERE e.Salary > m.Salary;

--10.Customers who bought every product 
SELECT C.Customer_id, C.name
      FROM Customers c
      WHERE NOT EXISTS (
      SELECT 1 FROM Products p
      WHERE p.category = 'Electronics'
      AND NOT EXISTS 
      ( SELECT 1
      FROM orders o 
      JOIN Order_items oi ON oi.order_id= o.orderid
      WHERE o.customer_id =c.customer_id AND 
      oi.producct_id = p.product_id

--11. 7 - day repeat purchase retention 
WITH f AS (
          SELECT Customer_id, MIN(order_date) AS first_date
          FROM orders 
          GROUP BY customer_id
)
SELECT DISTINCT f.customer_id
FROM f
JOIN orders o ON o.customer_id = f.customer_id 
WHERE o.order_date > f.first_date 
   AND o.order_date  < = f.first_date + INTERVAL '7 day';

--12.3+ consecutive login days 
WITH d AS ( 
            SELECT DISCTINCT user_id, Login_date :: date AS dt 
            FROM logins
            ),
            g As ( 
            SELECT user_id, dt,
            dt-(Row_Number() OVER (PARTITION BY User_id ORDER BY dt)) :: int AS grp 
            FROM g
            GROUP BY user_id, grp 
            HAVING COUNT(*) > = 3;

--




