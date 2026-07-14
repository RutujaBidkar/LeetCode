-- DAY 1 OF SQL QUERY 

--1.Retrieve all employee details from the Employees table.
SELECT * 
FROM Employee;

--2.Display only EmployeeName and Salary from the Employees table.
SELECT 
      EmployeeName,
      Salary
FROM Employee;

--3.Find employees whose salary is greater than 50,000.
SELECT 
      EmployeeName, 
      Salary 
FROM Employee 
WHERE Salary > 50000

--4.Display employees whose department is 'IT'.
SELECT 
      EmployeeName,
      Department
FROM Employee
WHERE Department = 'IT';

--5.Retrieve employees hired after '2023-01-01'.
SELECT 
        EmployeeName,
        HiredDate
FROM Employee 
WHERE HiredDate > '2023-01-01';

--6.Find employees whose salary is between 40,000 and 80,000.
SELECT 
      EmployeeName,
      Salary,
FROM Employee 
WHERE Salary BETWEEN 40000 AND 80000

--7.Display employees whose name starts with 'A'.
 SELECT 
       EmployeeName
FROM Employee
WHERE EmployeeName Like 'A%'

--8.Find employees working in IT or HR departments.
SELECT 
      EmployeeName,
      Department
FROM Employee 
WHERE Department IN ('IT','HR');

--9.Display employees ordered by salary in descending order.
SELECT 
      EmployeeName,
      Salary
FROM Employee 
ORDER BY Salary DESC;

--10.Retrieve the top 5 highest-paid employees.
SELECT TOP 5
       EmployeeName,
       Salary
FROM Employee
ORDER BY Salary DESC;

--11.Find the total number of employees.
SELECT COUNT(EmployeeID) AS TotolEmp
FROM Employee;

--12.Calculate the average salary of employees.
SELECT AVG(Salary) AS AvgSalary
FROM Employee;

--13.Find the maximum and minimum salary.
SELECT MAX(Salary) 
FROM Employee;

SELECT MIN(Salary)
FROM Employee

--14.Display departments having more than 5 employees.
SELECT Department, Count(*) AS Employeecount
FROM Employee
GROUP BY Department 
HAVING COUNT(*) >5;

--15.Find the total salary paid by each department.
SELECT Department,SUM(Salary)
FROM Employee 
GROUP BY Department 

--16.Display employee names along with their department names.
SELECT 
      Emp.EmployeeName,
      Dept.DepartmentName
      FROM Employee Emp 
      INNER JOIN 
      Department Dept
      ON Emp.DepartmentID = Dept.DepartmentID

--17.Find employees who do not belong to any department
SELECT 
      Emp.EmployeeName,
      FROM Employee Emp
      LEFT JOIN 
      Department Dept
      ON Emp.departmentID= Dept.departmentID
      WHERE Department IS NULL;

--18.Display all departments, even if they have no employees.
SELECT 
      Dept.Department
      FROM Department Dept
      LEFT JOIN
      Employee Emp
      ON Dept.DepartmentID = Emp.DepartmentID 
      WHERE Employee IS NULL


--19.Find the second-highest salary.
SELECT Salary
FROM
(
    SELECT Salary,
           DENSE_RANK() OVER(ORDER BY Salary DESC) AS RankSalary
    FROM Employee
) AS E
WHERE RankSalary = 2;

--20. Find employees earning more than the average salary

SELECT 
       EmployeeID,
       EmployeeName,
       Salary
FROM Employee
WHERE Salary > 
(
    SELECT AVG(Salary)
    FROM Employee
);