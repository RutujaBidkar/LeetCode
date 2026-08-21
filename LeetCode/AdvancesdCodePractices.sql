CREATE TABLE EmployeeSales (
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    sale_date DATE,
    sales DECIMAL(10,2)
);

INSERT INTO EmployeeSales
(employee_id, employee_name, department, sale_date, sales)
VALUES
(101, 'Amit', 'IT', '2026-01-05', 5000),
(101, 'Amit', 'IT', '2026-02-10', 7000),
(101, 'Amit', 'IT', '2026-03-15', 6000),

(102, 'Priya', 'HR', '2026-01-12', 4000),
(102, 'Priya', 'HR', '2026-02-20', 5000),
(102, 'Priya', 'HR', '2026-03-18', 8000),

(103, 'Rahul', 'IT', '2026-01-08', 9000),
(103, 'Rahul', 'IT', '2026-02-14', 3000),
(103, 'Rahul', 'IT', '2026-03-22', 10000);


Select * from EmployeeSales

--Write a SQL query to find each employee's monthly sales and their previous month's
WITH monthly_sales AS (
     SELECT 
           employee_name,
           Month(sale_date) AS month,
           SUM(sales) AS monthly_sales
     FROM EmployeeSales
     GROUP BY employee_name, Month(sale_date)
     )
     SELECT 
           employee_name,
           month,
           monthly_sales,
           LAG(monthly_sales) OVER (
           PARTITION BY employee_name
           ORDER BY month)
           AS Previous_month_sales
           FROM monthly_sales

CREATE TABLE Empl (
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO Empl
(employee_id, employee_name, department, salary)
VALUES
(101, 'Amit', 'IT', 60000),
(102, 'Priya', 'HR', 50000),
(103, 'Rahul', 'IT', 75000),
(104, 'Sneha', 'HR', 65000),
(105, 'Vikas', 'Finance', 80000),
(106, 'Neha', 'Finance', 70000),
(107, 'Karan', 'IT', 75000);

--Find the employee(s) who have the highest salary in each department.
SELECT employee_name,department,Max(salary)
FROM Empl
GROUP BY department, employee_name

With High_sal AS (
SELECT employee_name,
       department,
       salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY Salary DESC) AS rnk
FROM Empl) 

SELECT 
      employee_name,
      department,
      salary
      FROM High_sal
      WHERE rnk = 1

--Find employees whose salary is greater than the average salary of their own department.
WITH AvgSalary AS (
    SELECT
        employee_name,
        department,
        salary,
        AVG(salary) OVER (
            PARTITION BY department
        ) AS department_avg
    FROM Empl
)
SELECT
    employee_name,
    department,
    salary
FROM AvgSalary
WHERE salary > department_avg;


--Find the second-highest salary in each department 
WITH ScondHigh AS (
    SELECT
        employee_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS secondRnk
    FROM Empl
)
SELECT
    employee_name,
    department,
    salary
FROM ScondHigh
WHERE secondRnk = 2;

--Question 5 — Find all employees whose salary is greater than the overall company average salary.
SELECT employee_name,
       department,
       salary,
       AVG(salary) OVER() AS cpmpany_avg
       FROM Empl

SELECT 
      employee_name,
      department,
      AVG(salary) 
FROM Empl 
GROUP BY department
HAVING  AVG(salary) > salary