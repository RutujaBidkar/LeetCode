Use CompanyDB
CREATE TABLE Consumer
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    Age INT,
    City VARCHAR(50)
);

INSERT INTO Consumer (EmployeeID, EmployeeName, Department, Salary, Age, City)
VALUES
(101, 'Amit',   'HR',        35000.00, 25, 'Pune'),
(102, 'Priya',  'IT',        60000.00, 30, 'Mumbai'),
(103, 'Rahul',  'Finance',   45000.00, 28, 'Nagpur'),
(104, 'Sneha',  'IT',        70000.00, 35, 'Pune'),
(105, 'Karan',  'Admin',     40000.00, 40, 'Nashik'),
(106, 'Neha',   'HR',        38000.00, 27, 'Mumbai'),
(107, 'Vikas',  'Finance',   55000.00, 32, 'Pune'),
(108, 'Pooja',  'IT',        65000.00, 29, 'Nagpur'),
(109, 'Rohit',  'Admin',     42000.00, 38, 'Mumbai'),
(110, 'Anjali', 'HR',        48000.00, 31, 'Pune');

SELECT  * FROM Consumer;

--Create a scalar function that returns the salary of an employee.
CREATE FUNCTION fn_getEmpSalary
(
   @EmpID INT
)
RETURNS DECIMAL (10,2)
AS
BEGIN
     DECLARE @salary DECIMAL (10,2)

     SELECT @Salary = Salary
     FROM Consumer
     WHERE EmployeeID = @EmpID

     RETURN @salary 

END;

SELECT dbo.fn_getEmpSalary(105) As EmpSalary ;

SELECT * FROM Consumer;

--Create a stored procedure that displays all employees belonging to a given department.
CREATE PROCEDURE Emp_Department
    @Dept VARCHAR(100)
AS
BEGIN
    SELECT EmployeeID,
           EmployeeName,
           Department,
           Salary,
           Age,
           City
    FROM Consumer
    WHERE Department = @Dept;
END;
GO

EXEC Emp_Department 'IT';

--Create a stored procedure that increases the salary of an employee.
CREATE PROCEDURE Increment
( 
     @EmpID INT,
     @Increment DECIMAl(10,2)
)
As
BEGIN
      UPDATE Consumer SET 
      Salary = Salary *@Increment /100
      WHERE @EmpID

      SELECT * 
      FROM Consumer
      WHERE EmployeeID = @EmpID
END;
GO

--Create a function that returns the annual salary of an employee.
CREATE FUNCTION fn_getAnnualSalary
(
  @EmpID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
     DECLARE @Salary DECIMAL(10,2)

     SELECT @Salary = Salary * 12 
     FROM Consumer
     WHERE EmployeeID = @EmpID

     RETURN @Salary

END;

SELECT dbo.fn_getEmpSalary(102);

--Create a stored procedure that returns the salary of an employee using an OUTPUT parameter.
CREATE PROCEDURE sp_GetEmployeeSalary
(
   @EmpID INT
)


SELECT  *FROM Consumer;

--Create a function that calculates the tax amount based on salary.
CREATE FUNCTION fn_getTax_Amount
(
    @EmpID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2)
    DECLARE @Tax DECIMAL(10,2)

    SELECT @Salary = Salary
    FROM Consumers
    WHERE EmployeeID = @EmpID;

    IF @Salary >= 70000
        SET @Tax = @Salary * 0.20;

    ELSE IF @Salary >= 50000
        SET @Tax = @Salary * 0.10;

    ELSE
        SET @Tax = @Salary * 0.05;

    RETURN @Tax;
END;
GO

--Create a scalar function that calculates the tax amount of an employee based on their salary.
CREATE FUNCTION fn_GetTaxAmount
(
    @EmpID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2)
    DECLARE @Tax DECIMAL(10,2)

    -- Get salary of employee
    SELECT @Salary = Salary
    FROM Consumers
    WHERE EmployeeID = @EmpID;

    -- Apply tax rules
    IF @Salary >= 70000
        SET @Tax = @Salary * 0.20;

    ELSE IF @Salary >= 50000
        SET @Tax = @Salary * 0.10;

    ELSE
        SET @Tax = @Salary * 0.05;

    RETURN @Tax;
END;
GO
