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



