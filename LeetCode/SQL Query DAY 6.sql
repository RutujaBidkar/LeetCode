--SQL Query DAY 6 
use BankingDB
CREATE TABLE Employee
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO Employee
(
    EmployeeID,
    EmployeeName,
    DepartmentID,
    Salary,
    HireDate
)
VALUES
(1, 'Amit', 10, 50000, '2022-01-15'),
(2, 'Priya', 20, 60000, '2021-06-10'),
(3, 'Rahul', 10, 55000, '2023-03-20'),
(4, 'Sneha', 30, 70000, '2020-11-05'),
(5, 'Vikas', 20, 65000, '2022-08-18'),
(6, 'Neha', 10, 58000, '2024-01-12'),
(7, 'Rohit', 30, 75000, '2019-09-25'),
(8, 'Pooja', 20, 62000, '2023-07-30');

CREATE TABLE Department
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
INSERT INTO Department
(
    DepartmentID,
    DepartmentName
)
VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance');

SELECT EmployeeName,
       Salary 
FROM Employee;

--Find employees with salary greater than 60,000
SELECT EmployeeID,
       EmployeeName,
       Salary
FROM Employee 
WHERE Salary > 60000;

--Write a query to display all employees who belong to DepartmentID = 10.
SELECT *
FROM Employee
WHERE DepartmentID = 10;

--Find employees whose salary is between 50,000 and 65,000.
SELECT  * 
FROM Employee 
WHERE Salary BETWEEN 500000 AND 65000

--Find all employees whose name starts with the letter A.
SELECT *
FROM Employee 
WHERE EmployeeName Like 'A%';

--Find all employees whose name ends with the letter a.
SELECT * 
FROM Employee 
WHERE EmployeeName LIKE '%A';

--Find employees whose name contains the letter h.
SELECT * 
FROM Employee
WHERE EmployeeName LIKE '%h%';

--Find employees from multiple departments
SELECT *
FROM Employee
WHERE DepartmentID IN (10, 20);

--Find employees whose salary is NOT between 50,000 and 65,000.
SELECT * 
FROM Employee 
WHERE Salary NOT BETWEEN(50000,65000)

--Find all employees who do not belong to DepartmentID 10.
SELECT * 
FROM Employee
WHERE DepartmentID NOT IN(10);

SELECT * 
FROM Employee
WHERE DepartmentID <>10;

--Find employees whose salary is greater than 60,000 AND who belong to DepartmentID 20.
SELECT * 
FROM Employee
WHERE Salary > 60000 AND DepartmentID IN(20) 

--Find employees who belong to DepartmentID 10 OR have a salary greater than 70,000.
SELECT * 
FROM Employee
WHERE Salary > 70000
OR DepartmentID = 10;

--Display all employees sorted by salary from highest to lowest.
SELECT *
FROM Employee
ORDER BY Salary DESC;

--Display all employees sorted by EmployeeName in alphabetical order.
SELECT  *
FROM Employee
ORDER BY EmployeeName ASC;

--Ṭop 3 highest-paid employees
SELECT TOP 3 *
FROM Employee
ORDER BY Salary DESC;

--Find the total number of employees in the Employee table.
SELECT COUNT(EmployeeID) AS Total_Employee
FROM Employee

--Find the average salary of all employees.
SELECT AVG(Salary) AS AVG_Salary
FROM Employee 

--Find the highest salary in the Employee table.
SELECT MAX(Salary) AS Highest_Salary 
FROM Employee;

--Find the lowest salary in the Employee table.
SELECT MIN(Salary) AS Lowest_Salary
FROM Employee;

--Find the total salary paid to all employees.
SELECT SUM(Salary) AS Total_Salary
FROM Employee

--Find the total salary paid for each DepartmentID.
SELECT DepartmentID,
       SUM(Salary) AS Total_Salary
FROM Employee
GROUP BY DepartmentID;

--Find the number of employees in each DepartmentID.
SELECT DepartmentID,
       COUNT(EmployeeID) AS EmpCount
FROM Employee 
GROUP BY DepartmentID

--Find the average salary for each DepartmentID
SELECT DepartmentID,
       AVG(Salary)
FROM Employee
GROUP BY DepartmentID

--Find departments where the average salary is greater than 60,000.
SELECT DepartmentID,
       AVG(Salary)
FROM Employee
GROUP BY DepartmentID
HAVING Avg(Salary) > 60000 

--Find the department with the highest total salary.
SELECT TOP 1
       DepartmentID,
       SUM(Salary) AS Total_Salary
FROM Employee
GROUP BY DepartmentID
ORDER BY Total_Salary DESC;


