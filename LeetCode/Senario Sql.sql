--Scenario Based Questions
--Customers with Zero Orders
--LEFT JOIN + IS NULL
SELECT C.CustomerID,C.Name,
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID= O.CustomerID

--NOT EXISTS
SELECT 
       C.CustomerID,
       C.CustomerName
       FROM Customers C
       WHERE NOT EXITS
       (
           SELECT 1
           FROM Orders o
           WHERE o.customerID =c.CustomerID
           );

-- Using NOT IN
SELECT 
      CustomerID,
      CustomerName
FROM Customers
WHERE CustomerID NOT IN
(
  SELECT CustomerID
  FROM Orders 
);

----2.Second-highest Salary per department 
WITH CTE AS 
( 
   SELECT *,
            DENSE_Rank() OVER
            (
               PARTITION BY Department 
               ORDER BY Salary DESC
               ) AS SalaryRank 
               FROM Employee
)
SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary
FROM CTE
WHERE SalaryRank = 2;

--Using ROW_NUMBER()
WITH CTE AS
( 
   SELECT *,
            ROW_NUMBER() OVER 
            (
            PARTITION BY Department 
            ORDER By Salary Desc
            ) As RowNum 
        FROM Employees
)
SELECT *
FROM CTE
WHERE RowNum = 2;

--Rank()
WITH CTE AS 
( 
  SELECT *,
           RANK() OVER
           (
           PARTITION BY Department
           ORDER By Salary DESC 
           ) AS SalaryRank
           FROM Employee
)

SELECT *
FROM CTE
WHERE SalaryRank = 2;

----3. Top 3 product by category revenue 

--Using DENSE_RANK()
WITH ProductRevenue AS
(
    SELECT
        p.Category,
        p.ProductID,
        p.ProductName,
        SUM(s.Quantity * s.Price) AS Revenue
    FROM Products p
    JOIN Sales s
        ON p.ProductID = s.ProductID
    GROUP BY
        p.Category,
        p.ProductID,
        p.ProductName
),

RankedProducts AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               PARTITION BY Category
               ORDER BY Revenue DESC
           ) AS RankNo
    FROM ProductRevenue
)

SELECT
    Category,
    ProductName,
    Revenue
FROM RankedProducts
WHERE RankNo <= 3;