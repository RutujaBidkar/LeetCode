Use Practical;
CREATE TABLE Consumer
(
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(100),
  Age INT,
  Salary DECIMAL(10,2),
  Department VARCHAR(50)

);

INSERT INTO Consumer(EmployeeID, EmployeeName, Age, Salary, Department)
VALUES
(1, 'Amit', 25, 35000, 'HR'),
(2, 'Priya', 30, 50000, 'IT'),
(3, 'Rahul', 28, 45000, 'Finance'),
(4, 'Sneha', 35, 60000, 'IT'),
(5, 'Karan', 40, 70000, 'Admin');

--Create a Scalar Function that returns the Employee Name based on the EmployeeID.
CREATE FUNCTION fn_GetEmployeeNam
(
   @EmpID INT
)
RETURNS VARCHAR(100)
AS
BEGIN
          DECLARE @EmployeeName VARCHAR(100)
          
          SELECT @EmployeeName = EmployeeName
          FROM Consumer
          WHERE EmployeeID = @EmpID;

          RETURN @EmployeeName;
END;

SELECT dbo.fn_GetEmployeeNam(3) AS EmpNAME ;

--Create a scalar function that returns the salary of an employee based on EmployeeID.
CREATE FUNCTION fn_GetEmployeeSala
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

SELECT dbo.fn_GetEmployeeSala(3) AS EmpSalary;

--Create a scalar function that returns the employee's city.
CREATE FUNCTION fn_getempCity
(
   @EmpID INT
)
RETURNS VARCHAR(100)
AS
BEGIN   
      DECLARE @City VARCHAR(100)
      
      SELECT @City = City 
      FROM Consumer
      WHERE EmployeeID= @EmpID

      RETURN @City 
END;
GO 

SELECT dbo.fn_getempCity(4) AS EmpCity;
SELECT *FROM Consumer;

--Create a function that returns the Department of an employee.

CREATE FUNCTION fn_GetEmpDepartment
(
   @EmpID INT
)
RETURNS VARCHAR(100)
AS 
BEGIN 
      DECLARE @Department VARCHAR(100)

      SELECT @Department = Department
      From Consumer
      Where EmployeeID = @EmpID

      RETURN @Department 
END;
GO 

SELECT dbo.fn_GetEmpDepartment(4) As DeptEmp;

--Create a function that returns the Annual Salary of an employee.
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

 --Create a function that returns an employee's Bonus based on their salary.

 CREATE FUNCTION fn_getEmpBonu
 (
   @EmpID Int
)
RETURNS DECIMAL(10,2)
AS
BEGIN
     DECLARE @Salary DECIMAl (10,2)
     DECLARE @Bonus INT

     SELECT @Salary= Salary
     FROM Consumer
     WHERE EmployeeID = @EmpID

     IF @Salary >= 60000
     BEGIN
     SET @Bonus = 10000
     END

     ElSE IF @Salary >=50000
     BEGIN
     SET @Bonus =7000
     END

     ELSE 
     BEGIN
     SET @Bonus = 5000
     END
     RETURN @Bonus 
END;
SELECT *FROM Consumer;
SELECT dbo.fn_getEmpBonu(5) AS BonusSalary;


--Create a function that calculates the total salary.
CREATE FUNCTION fn_TotalSalary
(
    @Salary DECIMAL(10,2),
    @Bonus INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalSalary DECIMAL(10,2);

    SET @TotalSalary = @Salary + @Bonus;

    RETURN @TotalSalary;
END;
GO

-- Execute the function
SELECT dbo.fn_TotalSalary(50000, 7000) AS TotalSalary;

--Create a function that returns the total number of employees.
CREATE FUNCTION fn_totalEmp()

RETURNS INT
AS
BEGIN
      DECLARE @TotalEmp INT

      SELECT @TotalEmp = COUNT(*)
      FROM Consumer;

      RETURN @TotalEmp 

END;

SELECT dbo.fn_totalEmp() AS Empsalary;

--Create a function that returns the highest salary.
CREATE FUNCTION fn_maxsalary()
RETURNS DECIMAL(10,2)
AS
BEGIN
     DECLARE @MaxSalary DECIMAL(10,2)

     SELECT @MaxSalary= Max(salary)
     FROM Consumer

     RETURN @MaxSalary 

END;

SELECT dbo.fn_maxsalary() AS MaxSalary;

--Create a function that returns the lowest salary from the Consumer table.
CREATE FUNCTION fn_getMinSalary()
RETURNS DECIMAl(10,2)
AS
BEGIN 
      DECLARE @MinSalary DECIMAL(10,2)

      SELECT @MinSalary = Min(Salary)
      FROM Consumer

      RETURN @MinSalary 
END;

SELECT dbo.fn_getMinSalary() AS MinSalary;

--Create function that returns average salary
CREATE FUNCTION fn_AvgEmpSalary()
RETURNS DECIMAL(10,2)
AS
BEGIN
     DECLARE @AvgSalary DECIMAL(10,2)

     SELECT @AvgSalary = AVG(Salary)
     FROM Consumer

     RETURN @AvgSalary

END;

SELECT dbo.fn_AvgEmpSalary() As AvgSalary;

--EXIT OR NOT 
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

SELECT dbo.fn_CheckEmployeeExists(101) AS EmployeeExists;

--Depart Wise Salary
CREATE FUNCTION fn_SumSalaryByDept
(
    @Dept VARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalSalary DECIMAL(10,2);

    SELECT @TotalSalary = SUM(Salary)
    FROM Consumer
    WHERE Department = @Dept;

    RETURN @TotalSalary;
END;
GO

SELECT dbo.fn_SumSalaryByDept('IT') AS TotalSalary;

--Salary Status Function
CREATE FUNCTION fn_SalaryStatus
(
    @EmpID INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2);
    DECLARE @SalaryStatus VARCHAR(100);

    SELECT @Salary = Salary
    FROM Consumer
    WHERE EmployeeID = @EmpID;

    IF @Salary >= 60000
    BEGIN
        SET @SalaryStatus = 'HIGH';
    END
    ELSE
    BEGIN
        SET @SalaryStatus = 'MEDIUM';
    END

    RETURN @SalaryStatus;
END;
GO

SELECT dbo.fn_SalaryStatus(104) AS Status;













      


