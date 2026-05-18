Use CTE;
CREATE TABLE Customer
(
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    JoiningDate DATE
);

INSERT INTO Customer
(EmpName, Department, Salary, JoiningDate)
VALUES
('Ravi', 'IT', 50000, '2022-01-10'),
('Amit', 'HR', 35000, '2021-03-15'),
('Sneha', 'IT', 70000, '2023-07-20'),
('Pooja', 'Finance', 45000, '2020-11-11'),
('Rahul', 'HR', 30000, '2022-06-01');

--Get All Employee 
Create Procedure GetAllEmployee
As
Begin 
Select * from Employee;
END;

ExEC GetAllEmployee;

--Get Employees By Department
CREATE PROCEDURE GetEmployee
@Dept VARCHAR(50)
AS
BEGIN
SELECT *
FROM Employee 
WHERE Department= @Dept;
END;

EXEC GetEmployee 'HR'

--Get Employees With Salary Greater Than Given Salary
CREATE PROCEDURE Highs
@sal INT 
AS
BEGIN 
SELECT * FROM Employee
WHERE Salary > @sal
End ;
EXEC Highs 60000

--INSERT USING STORED PROCEDURE
CREATE PROCEDURE InsertEmployee
(
    @EmpName VARCHAR(50),
    @Department VARCHAR(50),
    @Salary INT,
    @JoiningDate DATE
)
AS
BEGIN
    INSERT INTO Employee(EmpName, Department, Salary, JoiningDate)
    VALUES(@EmpName, @Department, @Salary, @JoiningDate);
END;

EXEC InsertEmployee
'Karan',
'IT',
60000,
'2024-01-15';

--UPDATE USING STORED PROCEDURE
CREATE PROCEDURE UpdateEmployeeSalary
(
@EmpID INT,
@newSalary INT
)
AS 
Begin 
UPDATE Employee
Set Salary =@newSalary
Where EmpID = @EmpID;
END;

EXEC UpdateEmployeeSalary 1, 80000 ;

--DELETE USING STORED PROCEDURE
CREATE PROCEDURE DeleteEmployee
(
@EmpID INT
)
AS
BEGIN 
DELETE From Employee Where EmpID =@EmpID
END;

EXEC DeleteEmployee 6

--Get Employees By Department And Salary
CREATE PROCEDURE getEmploye
(
@Dept VARCHAR(50),
@Salary Int
)
AS 
BEGIN 
SELECT * FROM Employee 
WHERE Department = @Dept
AND Salary = @Salary
END;

EXEC GetEmploye 'IT' , 78000;

--Count Employees Department Wise
CREATE PROCEDURE countEmpDept
AS
BEGIN 
SELECT Department, 
       COUNT(*) AS TotalEmployees 
       FROM Employee
       GROUP By Department;

END;
EXEC countEmpDept;

--Find Average Salary Department Wise
CREATE PROCEDURE AvgSalaryDepartmentWise
AS
BEGIN
    SELECT Department,
           AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY Department;
END;

EXEC AvgSalaryDepartmentWise;

--Salary Category
CREATE PROCEDURE CheckSal
(
@EMPID INT 
)
AS 
BEGIN 
DECLARE @Salary INT;

SELECT @Salary = salary
FROM Employee
WHERE EmpID = @EMPID
IF @Salary > = 50000
    PRINT 'HIGH Salary';
ELSE 
    PRINT 'LOW Salary';
END;


EXEC CheckSal 1;

--STORED PROCEDURE WITH OUTPUT PARAMETER
--Get Total Employees
CREATE PROCEDURE GetTotalEmployees
(
    @TotalCount INT OUTPUT
)
AS
BEGIN
    SELECT @TotalCount = COUNT(*)
    FROM Employee;
END;
DECLARE @Count INT;

EXEC GetTotalEmployees @Count OUTPUT;

PRINT @Count;


--STORED PROCEDURE WITH TOP
--Highest Salary Employee
CREATE PROCEDURE HighestSalaryEmployee
AS
BEGIN
    SELECT TOP 1 *
    FROM Employee
    ORDER BY Salary DESC;
END;

EXEC HighestSalaryEmployee;


--Salary increment 10%
CREATE PROCEDURE SalaryIncrement
AS
Begin 
UPDATE Employee
SET Salary = 
CASE When Salary < 30000 THEN Salary + (Salary *20/100)
ELSE Salary + (Salary *10/100)
End;
End;

EXEC SalaryIncrement;
SELECT * FROM sys.procedures;