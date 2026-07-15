--SQL DAY 2 Series 
--1. Find customers who have placed at least one order.
--Customer(CustomerID, CustomerName)
--Orders(OrderID, CustomerID, OrderDate)
--1. Find customers who have placed at least one order

SELECT 
       Cust.CustomerID,
       Cust.CustomerName,
       Ord.OrderID,
       Ord.OrderDate
FROM Customer Cust
INNER JOIN Orders Ord
ON Cust.CustomerID = Ord.CustomerID;

--2.Find customers who have never placed an order.
SELECT 
       Cust.CustomerID,
       Cust.CustomerName,
       Ord.OrderID,
       Ord.OrderDate
FROM Customer Cust
LEFT JOIN Orders Ord
ON cust.CustomerID = ord.CustomerID
WHERE ord.OrderID IS NULL 

--3.Find employees who do not have a department assigned.
SELECT 
       Emp.EmployeeID,
       Emp.EmployeeName,
       Dept.DepartmentID
       Dept.DepartmentName 
       From Employee Emp
       LEFT JOIN 
       Department Dept
       ON Emp.DepartmentID = 
       Dept.DepartmentID
       WHERE Dept.DepartmentName IS NULL;

--4.Display the department name along with the highest-paid employee in each department.
SELECT 
      Dept.DepartmentName,
      Emp.EmployeeName,
      Emp.Salary
FROM Employee Emp
INNER JOIN Department Dept 
ON Emp.DepartmentID = Dept.DepartmentID
WHERE Emp.Salary =
(
           SELECT MAX(E2.Salary)
           FROM Employee E2
           WHERE E2.DepartmentID = Emp.DepartmentID 

);

--5.Find duplicate records in an Employee table based on Employee Email.
SELECT EmployeeEmail, COUNT(*) AS DuplicateEmail
FROM Employee 
GROUP BY EmployeeEmail
HAVING COUNT(*) > 1;

--6.Find employees whose salary is greater than their department's average salary.
SELECT
       Emp.EmployeeName,
       Dept.Department
       Emp.Salary
       FROM Employee Emp
       INNER JOIN Department Dept
       ON Emp.DepartmentID = Dept.DepartmentID
       WHERE Emp.Salary >
       (
           SELECT AVG(E2.Salary)
           FROM Emplpoyee E2
           WHERE E2.DepartmentID = Emp.DepartmentID;
      );

--7.Find the second-highest salary in each department.
--7. Find the second-highest salary in each department

SELECT
       DepartmentName,
       EmployeeName,
       Salary
FROM
(
    SELECT
           Dept.DepartmentName,
           Emp.EmployeeName,
           Emp.Salary,
           DENSE_RANK() OVER
           (
              PARTITION BY Emp.DepartmentID
              ORDER BY Emp.Salary DESC
           ) AS Salary_Rank
    FROM Employee Emp
    INNER JOIN Department Dept
    ON Emp.DepartmentID = Dept.DepartmentID
) Result
WHERE Salary_Rank = 2;

--8. Find departments where the average salary is greater than 70000

SELECT 
       Dept.DepartmentName,
       AVG(Emp.Salary) AS Average_Salary
FROM Employee Emp
INNER JOIN Department Dept
ON Emp.DepartmentID = Dept.DepartmentID
GROUP BY Dept.DepartmentName
HAVING AVG(Emp.Salary) > 70000;

--9.Find employees who earn the same salary as another employee.

SELECT 
       Salary,
       COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Salary
HAVING COUNT(*) > 1;

--10. Find top 3 highest-paid employees

SELECT TOP 3
       EmployeeID,
       EmployeeName,
       Salary
FROM Employee
ORDER BY Salary DESC;

--11. Rank employees based on salary within each department.

SELECT
       EmployeeID,
       EmployeeName,
       DepartmentID,
       Salary,
       RANK() OVER
       (
           PARTITION BY DepartmentID
           ORDER BY Salary DESC
       ) AS Salary_Rank
FROM Employee;

--12.Find the highest salary employee from each department using ROW_NUMBER().

SELECT
       EmployeeID,
       EmployeeName,
       DepartmentID,
       Salary
FROM
(
    SELECT
           EmployeeID,
           EmployeeName,
           DepartmentID,
           Salary,
           ROW_NUMBER() OVER
           (
               PARTITION BY DepartmentID
               ORDER BY Salary DESC
           ) AS RN
    FROM Employee
) Emp
WHERE RN = 1;

--13. Calculate the running total of employee salaries ordered by joining date.

SELECT
       EmployeeID,
       EmployeeName,
       JoiningDate,
       Salary,
       SUM(Salary) OVER
       (
           ORDER BY JoiningDate
       ) AS Running_Total
FROM Employee;

--14.Find the difference between an employee's salary and the previous employee's salary.
SELECT 
       EmployeeID,
       EmployeeName,
       Salary,
       LAG(Salary) OVER
       (
       ORDER BY JoiningDate)
       AS Previous_Salary,
       Salary - LAG(Salary) OVER
       (
       ORDER BY JoiningDate
       ) AS Salary_Difference
       FROM Employee ;

--15.Find the difference between an employee's salary and the next employee's salary.
SELECT 
      EmployeeID,
      EmployeeName,
      Salary,
      LEAD(Salary) OVER(
      ORDER BY JoiningDate)
      AS NextEmp_Salary,
      Salary- LEAD(Salary) OVER
      (
      ORDER BY JoiningDate) AS
      Salary_Difference
      FROM Employee;
