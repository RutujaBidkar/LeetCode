use CompanyDB

Select  *from Employee;
--Show employees with salary > 50000. 
Select Salary,EmpName 
From Employee Where  
Salary >50000

--Find employees whose name starts with 'A'.
Select EmpName
From Employee where 
EmpName Like'A'

--Find employees whose name Ends with 'A'.
Select EmpName 
From Employee
Where EmpName 
like '%A';

--Show employees hired after 2022.
Select JoiningDate
From Employee
Where Year(JoiningDate) > '2022'

--Display unique department names.
Select Distinct Department From 
Employee

--Find employees with NULL manager.
Alter Table Employee
Add Manager Varchar(50);

 Update Employee set
 Manager = 'Null';

Select EmpName,Manager
From Employee
Where Manager='Null';

--Sort employees by salary descending.
Select Salary
From Employee Order By
Salary DESC;

--Show top 5 highest salaries.
Select Top(5)Salary 
From Employee;

-- Find Employee Between Salary 25000-70000
Select EmpName,Salary 
From Employee Where 
Salary Between 25000 And 45000;

--Display employees from HR and IT.
Select EmpName,Department
From Employee
Where Department IN ('HR','IT');


CREATE TABLE Employee
(
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    City VARCHAR(50)
);

INSERT INTO Employee VALUES
(1,'Amit','IT',50000,'Pune'),
(2,'Neha','HR',40000,'Mumbai'),
(3,'Raj','IT',60000,'Pune'),
(4,'Priya','Finance',55000,'Delhi'),
(5,'Karan','HR',45000,'Mumbai'),
(6,'Sneha','IT',70000,'Pune'),
(7,'Rohit','Finance',50000,'Delhi'),
(8,'Pooja','IT',65000,'Pune'),
(9,'Vikas','HR',42000,'Mumbai'),
(10,'Anjali','Finance',58000,'Delhi');

Select *from Employee

--Count total employees.
Select Count(*) As Total_Emp
From Employee;

Select Department, 
Count(*) As Total_Emp
From Employee
GROUP By Department;

--Find total salary of all employees.
Select SUM(Salary) As Total_Sal
From Employee;

--Find average salary.
Select Avg(Salary) As Avg_Sal
From Employee;

--Find Maximum Salary
Select Max(Salary) As Max_sal
From Employee;

--Find maximum salary.
Select Min(Salary) AS Min_Sal
From Employee;

--Count employees department wise.
Select Department, Count(*) As Cut_Dept
From Employee
Group By Department;

--Find total salary department wise.
Select Department, SUM(Salary) As Dept_Sal
FROM Employee
Group by Department;

--Find average salary department wise.
Select Department, AVG(Salary) AS Avg_Sal
From Employee
GROUP BY Department;

--Find highest salary department wise.
Select Department, Max(Salary) AS Max_Sal
From Employee
Group By Department;

--Find lowest salary department wise.
Select Department, Min(Salary) AS Min_Sal
From Employee
GROUP By Department;

--Count employees city wise.
Select  City, Count(*) AS Emp_City
From Employee
Group By City;

--Find total salary city wise.
Select City, Sum(Salary) As Total_Sal
From Employee
GROUP By City

--Find departments having more than 2 employees.
SELECT Department,Count(*) AS Emp_Count
FROM Employee
Group BY Department
Having Count(*) > 2;

--Find cities having more than 3 employees
Select City ,Count(*) AS City_Cnt
FROM Employee 
GROUP BY City
Having count(*) >3;

--Find departments with average salary > 50000.
Select Department, AVG(Salary) As Avg_sal
From Employee
GROUP By Department 
Having AVG(Salary) > 50000

--Find cities with total salary > 100000.
SELECT City, Sum(Salary) as City_Sal
FROM Employee
GROUP By City
Having Sum(Salary) >100000

--Find departments where maximum salary > 60000.
Select Department, Max(Salary) As Max_Sal
From Employee
group by Department
Having Max(salary) >60000

--Find departments where minimum salary < 45000.
Select Department, Min(Salary) AS Min_sal
FROM Employee
Group by Department 
Having Min(Salary) < 45000

--Count employees in Pune.
Select City, Count(*) As Count_City
From Employee
Where City= 'Pune'
GROUP BY City;

--Find average salary in Mumbai.
Select Avg(Salary) As Avg_sal
FROM Employee 
Where City ='Mumbai'

--Find total salary of IT department.
Select Sum(Salary) As Sum_IT
From Employee 
Where Department= 'IT';

--Find highest salary in HR.
Select Max(Salary) As max_Sal
from Employee 
Where department = 'HR';

--Find lowest salary in Finance.
Select min(salary) As min_sal
From Employee
Where Department= 'Finance';

--Count distinct departments.
Select Distinct Department
From Employee

--Count distinct cities.
Select Distinct City
From Employee;

--Find department wise salary difference.
Select Department, 
           Max(Salary)-Min(salary) as salary_diff
From Employee
Group By Department;

--Find city wise average salary.
Select City,Avg(Salary) AS Avg_sal
From Employee
Group By City

--Find departments with total salary between 100000 and 200000
Select Department, Sum(Salary) As Tot_sal
From Employee
Group By Department
Having Sum(salary) Between 100000 and 200000

--Find departments with average salary between 40000 and 60000.
Select Department, Avg(Salary) AS Avg_Sal
From Employee 
Group by Department
Having Avg(Salary) Between 40000 and 60000 

--Show departments ordered by total salary.
Select Department, 
Sum(Salary) As Total_sal
From Employee
Group By Department
Order by Total_sal;

--Find top department by employee count.
Select TOP 1  Department, Count(*) As Count_Dept
From Employee 
Group By Department
Order by Count_Dept Desc;

--Find city with highest average salary.
Select City , Max(Salary)  As max_Sal
From Employee
Group By City;

--Find department with lowest total salary.
Select Department, Min(Salary) As Min_Sal
From Employee
Group by Department;

--Count employees with salary > 50000 department wise.
Select Department,Count(*) As Count_Dept
From Employee
Where Salary >5000
GRoup By Department;

