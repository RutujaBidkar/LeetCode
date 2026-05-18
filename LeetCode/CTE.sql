Create Database CTE;

Use CTE;

CREATE TABLE Employee
(
EmpID INT PRIMARY KEY,
EmpName VARCHAR(50),
Department VARCHAR(50),
Salary INT,
ManagerID INT,
JoiningDate Date
);

INSERT INTO Employee VALUES
(1, 'Rohit', 'IT', 50000, NULL, '2021-01-10'),
(2, 'Amit', 'HR', 40000, 1, '2021-02-15'),
(3, 'Neha', 'IT', 60000, 1, '2021-03-20'),
(4, 'Priya', 'Finance', 45000, 2, '2021-04-25'),
(5, 'Karan', 'IT', 70000, 3, '2021-05-30'),
(6, 'Sneha', 'HR', 38000, 2, '2021-06-12'),
(7, 'Raj', 'Finance', 52000, 4, '2021-07-18');

SELECT * FROM Employee;

WITH CTE_Name
AS
(
    SELECT EmpName
    FROM Employee
)
SELECT * FROM CTE_Name;

WITH EmployeeDetails
AS
(
    SELECT EmpID,
           EmpName,
           Department,
           Salary
    FROM Employee
)
SELECT *
FROM EmployeeDetails;

--1.Show employees with salary greater than average salary.
With High_Sal
As
(
Select AVG(Salary) AS AvgSal FROM 
Employee
)
SELECT E.EmpID, E.EmpName,E.Department,E.Salary
From Employee E
CROSS JOIN High_Sal A Where E.Salary> A.AvgSal;

--2Find Highest Salary Department Wise Using CTE
WITH DepartmentSalary
AS
(
    SELECT EmpName,
           Department,
           Salary,
           ROW_NUMBER() OVER
           (
               PARTITION BY Department
               ORDER BY Salary DESC
           ) AS RowNum
    FROM Employee
)

SELECT EmpName,
       Department,
       Salary
FROM DepartmentSalary
WHERE RowNum = 1;

--Remove Duplicate 
With Duplicate_CTE
AS
(
Select *, ROW_NUMBER() OVER
(Partition By EmpId,EmpName, Salary
Order BY EmpId )
AS Ronum
From Employee
)
Delete From Duplicate_CTE
Where Ronum >1;

--Find total Employee Department Wise 
With Dpt_Count
AS (
SELECT Department,
COUNT(*) AS TotalEmployees
FROM Employee
GROUP BY Department
)
SELECT * FROM Dpt_Count;

--Show Employees Joinined Afgter 2021 Using CTE
WITH Joinedafter2020
AS
(
SELECT *FROM Employee 
WHERE JoiningDate > '2020-12-31'
)
SELECT * FROm Joinedafter2020;

--Display all employees using CTE
With EmpCTE As(
Select *from Employee
)
Select *from EmpCTE

--Show employees with salary greater than 50000
With SalCTE As (
Select * FROM Employee Where Salary > 50000
)
SELECT * FROM SalCTE

--Show employees from IT department
With ITCTE AS(
Select * FROM Employee 
Where Department = 'IT'
)
Select *FROM ITCTE

--Count employees department wise
With ContCTE As (
Select Department, Count(*) As Count_Emp
From Employee
Group By Department 
)
Select * From ContCTE

--Find average salary department wise
With AvgCTE As (
Select Department, AVG(Salary)  As AVG_sal
From Employee
Group By Department
)
Select *from AvgCTE;

--Find employees earning more than average salary
WITH AvgSal AS
(
    SELECT AVG(Salary) AS AverageSalary
    FROM Employee
)
SELECT *
FROM Employee
WHERE Salary >
(
    SELECT AverageSalary FROM AvgSal
);

(
    SELECT AverageSalary FROM AvgSal
);

--7. Find highest salary department wise
With MaxCTE As(
Select Department, Max(Salary) AS Max_Sal
From Employee
Group By Department)

Select * From MaxCTE;

--Rank employees based on salary
With SalRank As (
Select EmpName,Department,Salary, Rank() Over(Order by Salary Desc ) as SalRank
From Employee )
Select *From SalRank;

--
Start questions regarding Common table expression 

Here are beginner-to-advanced SQL practice questions on Common Table Expressions (CTE) using an Employee table.

Create Sample Table
CREATE TABLE Employee (
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    JoiningDate DATE,
    ManagerID INT
);
Insert Sample Data
INSERT INTO Employee VALUES
(1, 'Amit', 'HR', 40000, '2021-01-10', NULL),
(2, 'Neha', 'IT', 60000, '2020-03-15', 1),
(3, 'Raj', 'IT', 55000, '2022-06-20', 2),
(4, 'Priya', 'Finance', 70000, '2019-09-25', 1),
(5, 'Karan', 'HR', 45000, '2023-01-05', 1),
(6, 'Sneha', 'Finance', 80000, '2018-07-11', 4),
(7, 'Vikas', 'IT', 50000, '2021-11-30', 2),
(8, 'Pooja', 'HR', 38000, '2022-02-14', 1);
Beginner Level CTE Questions
1. Display all employees using CTE
WITH EmpCTE AS
(
    SELECT * FROM Employee
)
SELECT * FROM EmpCTE;
2. Show employees with salary greater than 50000
WITH HighSalary AS
(
    SELECT * FROM Employee
    WHERE Salary > 50000
)
SELECT * FROM HighSalary;
3. Show employees from IT department
WITH ITDept AS
(
    SELECT * FROM Employee
    WHERE Department = 'IT'
)
SELECT * FROM ITDept;
4. Count employees department wise
WITH DeptCount AS
(
    SELECT Department,
           COUNT(*) AS TotalEmployees
    FROM Employee
    GROUP BY Department
)
SELECT * FROM DeptCount;
5. Find average salary department wise
WITH AvgSalary AS
(
    SELECT Department,
           AVG(Salary) AS AvgSal
    FROM Employee
    GROUP BY Department
)
SELECT * FROM AvgSalary;
Intermediate Level CTE Questions
6. Find employees earning more than average salary
WITH AvgSal AS
(
    SELECT AVG(Salary) AS AverageSalary
    FROM Employee
)
SELECT *
FROM Employee
WHERE Salary >
(
    SELECT AverageSalary FROM AvgSal
);
7. Find highest salary department wise
WITH MaxSalary AS
(
    SELECT Department,
           MAX(Salary) AS HighestSalary
    FROM Employee
    GROUP BY Department
)
SELECT *
FROM MaxSalary;
8. Rank employees based on salary
WITH SalaryRank AS
(
    SELECT EmpName,
           Department,
           Salary,
           RANK() OVER(ORDER BY Salary DESC) AS RankNo
    FROM Employee
)
SELECT * FROM SalaryRank;

-- Find second highest salary
WITH SecondHigh AS
(
    SELECT MAX(Salary) AS SecondHighestSalary
    FROM Employee
    WHERE Salary < (SELECT MAX(Salary) FROM Employee)
)

SELECT *
FROM Employee
WHERE Salary = (SELECT SecondHighestSalary FROM SecondHigh);

--Or With Help of Dense_Rank() Function 
With SalaryCTE As (
SELECT EmpName,
       Salary,
       DENSE_RANK() Over(ORDER By Salary DESC ) AS DRANk
       From Employee
       
 )
 Select * From SalaryCTE Where DRANk = 2 ;

             
--Find duplicate salaries
WITH DuplicateSalary AS
(
    SELECT Salary,
           COUNT(*) AS Total
    FROM Employee
    GROUP BY Salary
    HAVING COUNT(*) > 1
)
SELECT * FROM DuplicateSalary;

--Remove duplicate records using CTE
With RemoveDup AS (
Select *, ROW_NUMBER() OVER 
(
Partition By EmpName, Department, Salary
ORDER BY EmpID
)
AS RowNum 
FROm Employee
)
Delete FROM RemoveDup 
WHERE RowNum > 1;

--Find employees joined after 2020
With JoinedEmp As(
Select  EmpName, JoiningDate
From Employee 
Where Year(JoiningDate) > 2020
)
Select * From JoinedEmp;

--or 
With JoinedEmp As (
Select * From Employee
Where JoiningDate > '2020-12-31'
)
Select * from JoinedEmp

--Use multiple CTEs together
WITH DeptAvg AS
(
    SELECT Department,
           AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY Department
),
HighEmp AS
(
    SELECT *
    FROM Employee
    WHERE Salary > 50000
)
SELECT H.EmpName,
       H.Department,
       D.AvgSalary
FROM HighEmp H
JOIN DeptAvg D
ON H.Department = D.Department;