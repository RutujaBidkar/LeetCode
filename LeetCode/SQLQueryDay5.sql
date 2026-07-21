--DAY 5 SQL QUERY:

1. Find the top 2 highest-paid employees in each department.
 With TopEmployee AS(
 SELECT 
       EmployeeID,
       EmployeeName,
       Department,
       Salary
       ROW_NUMBER()
       Over( PARTITION BY Department ORDER BY Salary DESC ) AS Salary_Rank 
       FROM Employee 
)
SELECT Employee, 
       EmployeeName,
       Department,
       Salary
FROM Employee 
WHERE Salary_Rank <=2;

--2.Find employees whose salary is higher than the previous employee's salary based on joining date.
With Salary_Data AS (
SELECT 
      EmployeeID,
      EmployeeName,
      Salary,
      JoiningDate,
      LAG(Salary)
      OVER(ORDER BY JoiningDate ) AS Previous_Salary
      FROM Employee
 ) 
SELECT 
      EmployeeID,
      EmployeeName,
      Salary,
      JoiningDate,
      Previous_Salary 
FROM SalaryData
WHERE Salary > Previous_Salary;

--3.Find the department with the second-highest average salary.
WITH DeptAvg AS 
(
SELECT 
       Department,
       AVG(Salary) AS Avg_Salary 
FROM Employee
GROUP BY Department 
),
RankedDepartments AS
(
SELECT 
       Department,
       Avg_Salary,
       DENSE_RANK() OVER
       ( ORDER BY Avg_Salary 
       DESC ) AS Salary_Rank
       FROM DeptAvg
)
SELECT Department,
       Avg_Salary
FROM RankedDepartment
WHERE Salary_Rank =2;

--4.Find employees who have the same salary as the highest-paid employee in another department.
With Highestpaid AS(
SELECT 
       EmployeeID,
       EmployeeName,
       Salary,
       Departent
DENSE_RANK()
OVER(
      PARTITION BY Department Order BY Salary DESC) AS HighestPaidEmployee
      FROM Employee
      )
SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary
From HighestPaid E1
INNER JOIN HighestPaid E2
ON E1.Salary = E2.salary
AND E1.Department <> E2.Department
WHERE E1.Salary_Rank =1
AND  E2.Salary_Rank = 1;

--5. Find the first and last employee who joined each department

WITH EmployeeDetails AS
(
    SELECT
           EmployeeID,
           EmployeeName,
           Department,
           JoiningDate,

           ROW_NUMBER() OVER
           (
               PARTITION BY Department
               ORDER BY JoiningDate ASC
           ) AS First_Employee,

           ROW_NUMBER() OVER
           (
               PARTITION BY Department
               ORDER BY JoiningDate DESC
           ) AS Last_Employee

    FROM Employee
)
SELECT
       Department,
       EmployeeID,
       EmployeeName,
       JoiningDate,
       CASE
           WHEN First_Employee = 1 THEN 'First Employee'
           WHEN Last_Employee = 1 THEN 'Last Employee'
       END AS Employee_Type
FROM EmployeeDetails
WHERE First_Employee = 1
   OR Last_Employee = 1;

--6.Find the percentage contribution of each department's salary to the total company salary.
SELECT Departent,
       SUM(Salary) AS Department_Total_Salary,
       SUM(Salary) * 100.0
       /
       SUM(SUM(Salary)) OVER() AS Salary_Percentage
FROM Employee
GROUP BY Department;

--7.Find departments where the salary of every employee is greater than 50,000.
SELECT EmployeeID,
       Department,
       MIN(Salary) As MIN_Salary
FROM Employee
GROUP BY Department
HAVING MIN(Salary) > 50,0000

--8. Find departments where at least one employee earns more than 100000

SELECT
       Department,
       MAX(Salary) AS Highest_Salary
FROM Employee
GROUP BY Department
HAVING MAX(Salary) > 100000;

--9.Find the average salary excluding the highest and lowest salary.

SELECT
       (
           SUM(Salary) - MIN(Salary) - MAX(Salary)
       )
       /
       NULLIF(COUNT(*) - 2, 0) AS Average_Salary
FROM Employee;

--10.Find the difference between the highest and lowest salary in each department.
SELECT
       Department,
       MAX(Salary) AS Highest_Salary,
       MIN(Salary) AS Lowest_Salary,
       MAX(Salary) - MIN(Salary) AS Salary_Difference
FROM Employee
GROUP BY Department;

--11.Find employees who joined in the last 6 months.
SELECT 
       EmployeeID,
       EmployeeName,
       Department,
       JoiningDate
FROM Employee 
WHERE JoiningDate >= DATEADD(MONTH, -6, GETDATE());


--12.Find employees who have completed more than 2 years in the company.

SELECT 
       EmployeeID,
       EmployeeName,
       Department,
       JoiningDate
FROM Employee 
WHERE JoiningDate <  DateADD(YEAR, -2, GETDATE());

--13. Find the month with the highest number of employee joinings

WITH MonthlyJoinings AS
(
    SELECT
           YEAR(JoiningDate) AS Joining_Year,
           MONTH(JoiningDate) AS Joining_Month,
           COUNT(*) AS Employee_Count
    FROM Employee
    GROUP BY
           YEAR(JoiningDate),
           MONTH(JoiningDate)
),
RankedMonths AS
(
    SELECT
           Joining_Year,
           Joining_Month,
           Employee_Count,
           ROW_NUMBER() OVER
           (
               ORDER BY Employee_Count DESC
           ) AS RN
    FROM MonthlyJoinings
)
SELECT
       Joining_Year,
       Joining_Month,
       Employee_Count
FROM RankedMonths
WHERE RN = 1;