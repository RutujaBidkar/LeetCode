use Companydb
select * from Employee;


--1. Find the second highest salary from the Employee table.
Select Max(salary) From Employee
Where Salary < (Select Max(Salary) From Employee);

--2. Find duplicate records in a table
Select EmpName,Count(*)
From Employee
Group By EmpName
Having Count(*) >1;

--3.Retrieve employees who earn more than their manager
Select EmpName As EmplyeeName, Salary AS EmployeeSalary
From Employeee e
Join Employee m on e.manager.id= m.id
Where e.salary > m.salary;

--4. Count employees in each department having more than 5 employees
Select Department, Count(*) As Num_Employee
From Employee
Group By Department
Having Count(*) >5 ;

--5. Find employees who joined in the last 6 months
SELECT *
FROM employees
WHERE join_date >= CURRENT_DATE - INTERVAL '6 months';

SELECT *
FROM employees
WHERE join_date >= DATEADD(MONTH, -6, GETDATE());

--6. Get departments with no employees
Select d.department 
From Department d
Join Employee  e ON d.department_id =
Where e.id IS NULL;


--7. Write a query to find the median salary.
SELECT AVG(salary) AS median_salary
FROM (
    SELECT salary
    FROM employees
    ORDER BY salary
    LIMIT 2 - (SELECT COUNT(*) FROM employees) % 2
    OFFSET (SELECT (COUNT(*) - 1) / 2 FROM employees)
) AS median_subquery;
 
--8. Running total of salaries by department
Select Department, Salary
Sum(Salary) Over (Partition BY Department order by EmpID
From Employee 
