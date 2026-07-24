-- 1. Find employees whose salary is between 50,000 and 70,000
SELECT *
FROM Employee
WHERE Salary BETWEEN 50000 AND 70000;


-- 2. Find employees who do not belong to DepartmentID 10
SELECT *
FROM Employee
WHERE DepartmentID <> 10;


-- 3. Find employees whose name ends with 'a'
SELECT *
FROM Employee
WHERE EmployeeName LIKE '%a';


-- 4. Find the highest salary in each department
SELECT DepartmentID,
       MAX(Salary) AS Highest_Salary
FROM Employee
GROUP BY DepartmentID;


-- 5. Find the lowest salary in each department
SELECT DepartmentID,
       MIN(Salary) AS Lowest_Salary
FROM Employee
GROUP BY DepartmentID;


-- 6. Find the total salary paid in each department
SELECT DepartmentID,
       SUM(Salary) AS Total_Salary
FROM Employee
GROUP BY DepartmentID;


-- 7. Find departments where the average salary is greater than 60,000
SELECT DepartmentID,
       AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY DepartmentID
HAVING AVG(Salary) > 60000;


-- 8. Find the third-highest salary
WITH SalaryRank AS (
    SELECT EmployeeID,
           EmployeeName,
           Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS Salary_Rank
    FROM Employee
)
SELECT *
FROM SalaryRank
WHERE Salary_Rank = 3;


-- 9. Find employees who earn more than EmployeeID = 5
SELECT *
FROM Employee
WHERE Salary > (
    SELECT Salary
    FROM Employee
    WHERE EmployeeID = 5
);


-- 10. Find the department with the highest total salary
SELECT TOP 1
       DepartmentID,
       SUM(Salary) AS Total_Salary
FROM Employee
GROUP BY DepartmentID
ORDER BY Total_Salary DESC;