-- 1. Find employees with a salary greater than 60,000
SELECT *
FROM Employee
WHERE Salary > 60000;


-- 2. Find employees from DepartmentID 10
SELECT *
FROM Employee
WHERE DepartmentID = 10;


-- 3. Find employees whose name starts with 'A'
SELECT *
FROM Employee
WHERE EmployeeName LIKE 'A%';


-- 4. Find the total number of employees
SELECT COUNT(EmployeeID) AS Total_Employees
FROM Employee;


-- 5. Find the average salary for each department
SELECT DepartmentID,
       AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY DepartmentID;


-- 6. Find departments with more than 2 employees
SELECT DepartmentID,
       COUNT(EmployeeID) AS Total_Employees
FROM Employee
GROUP BY DepartmentID
HAVING COUNT(EmployeeID) > 2;


-- 7. Find employees earning more than the average salary
SELECT EmployeeID,
       EmployeeName,
       Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);


-- 8. Find employees with the highest salary
SELECT EmployeeID,
       EmployeeName,
       Salary
FROM Employee
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
);


-- 9. Find the second-highest salary using DENSE_RANK()
WITH SalaryRank AS (
    SELECT EmployeeID,
           EmployeeName,
           Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank
    FROM Employee
)
SELECT *
FROM SalaryRank
WHERE Salary_Rank = 2;


-- 10. Find employees earning more than the average salary
-- of their own department
SELECT EmployeeID,
       EmployeeName,
       DepartmentID,
       Salary
FROM Employee AS E
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DepartmentID = E.DepartmentID
);