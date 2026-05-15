CREATE DATABASE CompanyDB;
GO

USE CompanyDB;

CREATE TABLE Employee
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    JoiningDate DATE
);

INSERT INTO Employee VALUES
(1,'Riya','HR',25000,'2022-01-10'),
(2,'Aman','IT',50000,'2021-03-15'),
(3,'Neha','IT',60000,'2020-07-20'),
(4,'Rahul','Finance',45000,'2019-11-01'),
(5,'Priya','HR',30000,'2023-02-18'),
(6,'Karan','IT',70000,'2018-09-25'),
(7,'Sneha','Finance',40000,'2022-05-14');

Select *from Employee;

---Window Function 
--1.Show all employees with row numbers based on highest salary.
Select *, Row_Number() OVER(ORDER BY Salary DESC) AS RowNum
FROM Employee;

--SELECT *, Row_Number() Over(Partition BY EmpName order by EmpName ASC) FROM Employee

--2. Display employees with row numbers department-wise. 
Select *, ROW_NUMBER () OVER(ORDER BY Department ASC ) as Depat
FROM Employee

Select *, ROW_NUMBER() OVER(PARTITION BY DEPARTMENT ORDER BY Salary DESC ) AS RowNumber
FROM Employee;

--3. Find Lastest Joined Employee 
Select * FROM
(
SELECT * , ROW_NUMBER() OVER(ORDER BY JoiningDate DESC) AS RN 
FROM Employee ) A
Where RN =1;

--4. Find top-ranked employee from each department. 
Select * FROM (
Select *, RANk() OVER( PARTITION BY DEPARTMENT ORDER BY Salary DESC)
AS RNK 
FROM Employee) A
WHERE RNK =1;

--5 Show Salary Ranks in Ascending Order 
Select *, RANK() Over(Order by Salary ASC) AS SalaryRank 
FROM Employee;

--6. FIND Employee Having RANK =1
Select * FROM 
( Select *, RANK() OVER(ORDER BY Salary DESC) AS RNK 
FROM EMPlOYEE) A
WHERE RNK = 1;

--7.Display Duplicate Salary Ranks 
Select *, Rank() Over( ORDER BY Salary DESC) AS SalaryRank
FROM Employee;

--8. Rank Employee based on Joining date 
Select *, RANk() OVER(ORDER BY joiningDate ASC ) AS JoiningRANk
FROM Employee;

--9.FIND Second Highest salary using RANK()
SELECT * FROM
(
SELECT *, RANK() OVER(ORDER BY Salary DESC ) AS RNK 
FROM EMPLOYEE ) A 
WHERE RNK =2;

--10. Show lowest Salary Employee rank in each Department
Select * FROM(
Select *, RANK() Over(Partition BY Department Order BY Salary Asc) AS RNK 
FROM Employee
) A 
WHERE RNK =1;

--11.Display dense rank according to salary
Select *, DENSE_RANk() OVER (Order by salary DESC) AS DenRank
FROM Employee;

--12.Find top 3 salaries using DENSE_RANK() 
SELECT * FROM (
SELECT *, DENSE_RANK() OVER(ORDER By Salary  DESC ) AS DR
FROM Employee) A 
Where DR <=3;

--13. Show department-wise dense salary ranking 
Select *, 
DENSE_RANK() OVER 
(
PARTITION BY Department 
ORDER BY Slary DESC)
AS DeptDenseRank
FROM Employee;

--14. Find Employee Having Dense rank =2 
SELECT * 
FROM
(
SELECT *, DENSE_RANK() OVER(ORDER BY Salary DESC) AS DR 
FROM Employee) A
WHERE DR =2;

--15.Compare RANK() and DENSE_RANK() 
Select *, 
RANK() OVER(ORDER BY Salary DESC) AS RankNum,
DENSE_RANK() OVER (ORDER BY Salary DESC) As DenseRankNum
FROM Employee;

--16. Find second highest salary employee using DENSE_RANK()
Select * FROM  (
Select *, DENSE_RANK() over(Order By Salary DESC) as HIG
FROM Employee) A
Where HIG =2;

--17.show dense rank based on joining date 
SELECT *, DENSE_RANK() OVER(ORDER BY JoiningDATE ASC) AS JOININGDENSE
FROM Employee;

--18.Display dense ranks in ascending salary order
Select *, 
DENSE_RANK() over(ORDER BY Salary ASC) AS DR
FROM Employee

--19.Find lowest salary dense rank in each department
Select * FROM 
(
SELECT *, DENSE_RANK() OVER(Partition By Department Order BY salary ASC) AS DR 
FROM Employee) A
Where DR =1;

--20.Show all employees with dense ranking partitioned by department
SELECT *, DENSE_RANK() Over( Partition By  Department Order by Salary DESC) 
AS Dept
FROM Employee;

--21. Divide employees into 2 salary groups 
SELECT *, NTILE(2) OVER (ORDER BY Salary DESC) AS  SalG
FROM Employee;

--22. Divide employees into 3 equal salary buckets
SELECT *, 
NTILE(3) OVER (ORDER By SALARY DESC) AS SB
FROM EMployee;

--23.Divide employees into 3 equal salary buckets
SELECT *,
NTILE(4) OVER(ORDER BY JoiningDate ASC) AS JoiningGroup
FROM Employee;

--24.show which quartile each employee belongs to
SELECT *,
NTILE(4) OVER(ORDER BY Salary DESC) AS Quartile
FROM Employee;

--25.Divide employees department-wise into 2 groups
SELECT *,
NTILE(2) OVER
(
    PARTITION BY Department
    ORDER BY Salary DESC
) AS DeptGroup
FROM Employee;

--26.LEAD()  Show next employee salary
Select *, LEAD(Salary) OVER(ORDER BY Salary DESC) AS NEXTSAl
FROM Employee;

--27.Find salary difference between current and next employee
SELECT *, LEAD(Salary) OVER (ORDER BY Salary DESC) -Salary As SalDiff
FROM Employee;

--28. Display next joining date for each employee
Select *, Lead(JoiningDate) OVER (ORDER BY JoiningDate) AS NextJoin
FROM Employee;

--29.Show next employee name based on salary order
SELECT EmpName,Salary,LEAD(EmpName) OVER(ORDER BY Salary DESC) AS NextEm
from Employee;

--30. Find employee whose Next salary is higher 
Select * FROM (
Select *, LEAD(Salary) OVER (ORDER BY Salary) AS NextSalary
From Employee) A 
Where NextSalary> Salary;

--LAG() Window Function
--1.Show previous employee salary
SELECT *,
LAG(Salary) OVER(ORDER BY Salary DESC) AS PreviousSalary
FROM Employee;

--2.Find difference between current and previous salary
SELECT *,
Salary - LAG(Salary) OVER(ORDER BY Salary DESC) AS SalaryDifference
FROM Employee;

--3.Display previous joining date
SELECT *,
LAG(JoiningDate) OVER(ORDER BY JoiningDate) AS PreviousJoiningDate
FROM Employee;

--4.Show previous employee name
SELECT *,
LAG(EmpName) OVER(ORDER BY Salary DESC) AS PreviousEmployee
FROM Employee;

--5.Compare current salary with previous salary
SELECT EmpName,
Salary,
LAG(Salary) OVER(ORDER BY Salary DESC) AS PreviousSalary
FROM Employee;

--6.FIRST_VALUE()
SELECT *,
FIRST_VALUE(Salary) OVER(ORDER BY Salary DESC) AS HighestSalary
FROM Employee;

--7.LAST_VALUE()
SELECT *,
LAST_VALUE(Salary) OVER
(
ORDER BY Salary
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS LastSalary
FROM Employee;

--8.SUM() OVER()
SELECT *,
SUM(Salary) OVER(ORDER BY Salary) AS RunningTotal
FROM Employee;

--9.AVG() OVER()
SELECT *,
AVG(Salary) OVER() AS AvgSalary
FROM Employee;

--10.MIN() and MAX()
SELECT *,
MAX(Salary) OVER() AS MaxSalary
FROM Employee;

SELECT *,
MIN(Salary) OVER(PARTITION BY Department) AS MinSalary
FROM Employee;

