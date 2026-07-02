Create a Scalar Function to Return Employee Salary
CREATE FUNCTION fn_GetEmployeeSalary
(
    @EmpID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2);

    SELECT @Salary = Salary
    FROM Consumer
    WHERE EmployeeID = @EmpID;

    RETURN @Salary;
END;
GO

SELECT dbo.fn_GetEmployeeSalary(101) AS EmployeeSalary;

Create a Stored Procedure to Display Employees by Department
CREATE PROCEDURE sp_GetEmployeesByDepartment
(
    @Department VARCHAR(50)
)
AS
BEGIN
    SELECT *
    FROM Consumer
    WHERE Department = @Department;
END;
GO

EXEC sp_GetEmployeesByDepartment 'IT';

Create a scalar function that returns the salary of an employee using Employe
CREATE FUNCTION fn_GetEmployeeSalary
(
    @EmpID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2);

    SELECT @Salary = Salary
    FROM Consumer
    WHERE EmployeeID = @EmpID;

    RETURN @Salary;
END;
GO

SELECT dbo.fn_GetEmployeeSalary(101) AS EmployeeSalary;

Create a function that returns employee name using EmployeeID.
CREATE FUNCTION fn_GetEmployeeName
(
    @EmpID INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Name VARCHAR(100);

    SELECT @Name = EmployeeName
    FROM Consumer
    WHERE EmployeeID = @EmpID;

    RETURN @Name;
END;
GO

SELECT dbo.fn_GetEmployeeName(102) AS EmployeeName;

Create a function to calculate annual salary (Salary * 12).
CREATE FUNCTION fn_GetAnnualSalary
(
    @EmpID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @AnnualSalary DECIMAL(10,2);

    SELECT @AnnualSalary = Salary * 12
    FROM Consumer
    WHERE EmployeeID = @EmpID;

    RETURN @AnnualSalary;
END;
GO

SELECT dbo.fn_GetAnnualSalary(103) AS AnnualSalary;

Check Employee Exists using Function

CREATE FUNCTION fn_CheckEmployeeExists
(
    @EmpID INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT;

    IF EXISTS (SELECT 1 FROM Consumer WHERE EmployeeID = @EmpID)
        SET @Exists = 1;
    ELSE
        SET @Exists = 0;

    RETURN @Exists;
END;
GO

SELECT dbo.fn_CheckEmployeeExists(104) AS IsExists;

Get Employees by Department (Stored Procedure)
CREATE PROCEDURE sp_GetEmployeesByDepartment
(
    @Department VARCHAR(50)
)
AS
BEGIN
    SELECT EmployeeID,
           EmployeeName,
           Department,
           Salary,
           City
    FROM Consumer
    WHERE Department = @Department;
END;
GO

EXEC sp_GetEmployeesByDepartment 'IT';

Increase Salary by Percentage (Stored Procedure)
CREATE PROCEDURE sp_IncreaseSalary
(
    @EmpID INT,
    @Percent DECIMAL(10,2)
)
AS
BEGIN
    UPDATE Consumer
    SET Salary = Salary + (Salary * @Percent / 100)
    WHERE EmployeeID = @EmpID;

    SELECT * 
    FROM Consumer
    WHERE EmployeeID = @EmpID;
END;
GO

EXEC sp_IncreaseSalary 105, 10;

Get Max Salary using Function
CREATE FUNCTION fn_GetMaxSalary()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @MaxSalary DECIMAL(10,2);

    SELECT @MaxSalary = MAX(Salary)
    FROM Consumer;

    RETURN @MaxSalary;
END;
GO

SELECT dbo.fn_GetMaxSalary() AS MaxSalary;

Get Total Salary by Department

CREATE FUNCTION fn_GetDeptTotalSalary
(
    @Department VARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = SUM(Salary)
    FROM Consumer
    WHERE Department = @Department;

    RETURN @Total;
END;
GO

SELECT dbo.fn_GetDeptTotalSalary('HR') AS TotalSalary;
