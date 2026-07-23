--NEW DAY SQL QUERY DAY 7
Use BankingDB 
SELECT * FROM Employee
--Find the highest salary in each department.
SELECT DepartmentID,
       MAX(Salary) AS HighestSalary
FROM Employee
GROUP BY DepartmentID

--Find departments where the highest salary is greater than 70,000.
SELECT DepartmentID,
       MAX(Salary) AS Highest_Salary
FROM Employee
GROUP BY DepartmentID
HAVING MAX(Salary) > 70000;

--Find the total number of employees and the average salary for each department.
SELECT DepartmentID,
       COUNT(EmployeeID) AS Total_Employees,
       AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY DepartmentID;

--Find departments that have more than 2 employees.
SELECT 
       DepartmentID,
       COUNT(EmployeeID) AS EmpCount
FROM Employee
GROUP BY DepartmentID
HAVING COUNT(EmployeeID) > 2;

--Find the department with the highest average salary.
SELECT DepartmentID,
       AVG(Salary) AS Avg_Salary
FROM Employee
GROUP BY DepartmentID;

SELECT TOP 1
       DepartmentID,
       AVG(Salary) AS Avg_Salary
FROM Employee
GROUP BY DepartmentID
ORDER BY Avg_Salary DESC;

--Find the second-highest salary in the Employee table.
WITH SecondHigh AS (
SELECT EmployeeID,
       EmployeeName,
       Salary,
       DENSE_RANK() 
       OVER (ORDER BY Salary DESC) AS Scond_High_Salary
FROM Employee
)
SELECT * FROM SecondHigh
WHERE Scond_High_Salary = 2;

--Find the third-highest salary in the Employee table.
WITH ThirdSalary AS (
SELECT 
      EmployeeID,
      EmployeeName,
      Salary,
      DENSE_RANK() 
      OVER(ORDER BY Salary DESC) AS Third_RankSalary
FROM Employee
)
SELECT *
FROM ThirdSalary 
WHERE Third_RankSalary = 3;

--Find employees who earn more than the average salary of all employees.
SELECT EmployeeID,
       EmployeeName,
       Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);

--Find employees who earn the highest salary in the Employee table.
SELECT MAX(Salary)
FROM Employee;

SELECT EmployeeID,
       EmployeeName,
       Salary
FROM Employee
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
);

--Find employees who earn the lowest salary in the Employee table.
SELECT MIN(Salary) 
FROM Employee

SELECT EmployeeID,
       EmployeeName,
       Salary
FROM Employee 
WHERE Salary = (
                SELECT MIN(Salary)
                FROM Employee
                );

--Find employees whose salary is greater than the salary of employee EmployeeID = 5
SELECT *
FROM Employee
WHERE Salary > (
    SELECT Salary
    FROM Employee
    WHERE EmployeeID = 5
);

--Find employees who earn more than the average salary of their own department.
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

