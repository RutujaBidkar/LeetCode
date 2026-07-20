--DAY2 SQL Series 
--1. Find the 3rd highest salary without using TOP or LIMIT

WITH SalaryRank AS
(
    SELECT
           EmployeeID,
           EmployeeName,
           Salary,
           DENSE_RANK() OVER
           (
               ORDER BY Salary DESC
           ) AS Salary_Rank
    FROM Employee
)
SELECT
       EmployeeID,
       EmployeeName,
       Salary
FROM SalaryRank
WHERE Salary_Rank = 3;

--2. Delete duplicate records while keeping the latest record

WITH DuplicateRecords AS
(
    SELECT
           EmployeeID,
           EmployeeEmail,
           EmployeeName,
           CreatedDate,
           ROW_NUMBER() OVER
           (
               PARTITION BY EmployeeEmail
               ORDER BY CreatedDate DESC
           ) AS RN
    FROM Employee
)
DELETE FROM DuplicateRecords
WHERE RN > 1;

--3. Find employees who joined in the same month and year

SELECT
       YEAR(JoiningDate) AS Joining_Year,
       MONTH(JoiningDate) AS Joining_Month,
       COUNT(*) AS Employee_Count
FROM Employee
GROUP BY
       YEAR(JoiningDate),
       MONTH(JoiningDate)
HAVING COUNT(*) > 1;

--4. Find the department with the highest total salary expense

SELECT TOP 1
       DepartmentID,
       SUM(Salary) AS Total_Salary_Expense
FROM Employee
GROUP BY DepartmentID
ORDER BY Total_Salary_Expense DESC;

--5. 