use companydb
Select *from Employee;

--Show Previous Salary
SELECT EmpName,
       Salary,
       LAG(Salary) OVER (ORDER BY EmpID) AS PreviousSalary
FROM Employee

--Show Next Salary
SELECT EmpName,
       Salary,
       LEAD(Salary) OVER(ORDER BY EmpID) As NextResult
FROM Employee

--Running Total Salary
SELECT EmpID,
       Salary,
       SUM(Salary) OVER(ORDER BY EmpId) As SumSalary
FROM Employee;

--Department Wise Total Salary
SELECT EmpName,
       Department,
       Salary,
       SUM(Salary) OVER (PARTITION BY Department) As DeptTotal
FROM Employee;

--Department Wise Average Salary
SELECT EmpName,
       Department,
       Salary,
       AVG(salary) OVER (PARTITION BY Department) AS DeptAvg
From Employee;

--Scalar Function to Calculate Bonus
CREATE FUNCTION dbo.fnBonus
(
    @salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
     RETURN @Salary *0.10
END;

SELECT EmpName,
       Salary,
       dbo.fnBonus(Salary) AS Bonus
FROM Employee;

--Function to Calculate Age
CREATE FUNCTION dbo.fnAge
(
   @DOB DATE
)
RETURNS INT
AS
BEGIN
     RETURN DATEDIFF(YEAR,@DOB,GETDATE())
END

SELECT dbo.fnAge('2002-12-13') As Age;

--Inline Table-Valued Function
CREATE FUNCTION dbo.fnEmployeeByDept
(
   @Dept Varchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
SELECT * 
FROM Employee
WHERE Department
);



