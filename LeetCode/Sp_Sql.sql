Use CompanyDB
Select *from Employee


--GET A Table data 
Create Procedure Getdata
AS
Begin 
Select *FROM Employee
END;
EXEC Getdata;

--Stored Procedure With WHERE Condition
CREATE PROCEDURE GetITEmployee
As
Begin 
Select *FROM Employee
Where Department ='IT'
END;

EXEC GetITEmployee;

--stored Procedure With Parameter
CREATE PROCEDURE GetEmployeeIT 
@ID INT 
AS
BEGIN
SELECT *FROM Employee
Where EmpID= @ID;
END;

EXEC GetEmployeeIT 3;

--Multiple Parameters
CREATE PROCEDURE GetEmpployeeDeptSalary 
@Dept VARCHAR(50),
@Salary INT
As
BEGIN 
SELECT * FROM Employee
WHERE Department =@Dept
AND Salary > = @salary;
END;

EXEC GetEmpployeeDeptSalary 'IT',5000;

--INSERT Using Stored Procedure
CREATE PROCEDURE  AddEmployee
@EmpID INT,
@EmpName VARCHAR(50),
@Department VARCHAR(50),
@Salary INT,
@joiningDate DATE 
As
BEGIN 
INSERT INTO Employee VALUES(@EmpID,@EmpName, @Department , @Salary, @joiningDate );
END;

EXEC AddEmployee 13,'Rutu' ,'sales', 80000,'15-05-2026';


--UPDATE Using Stored Procedure
CREATE PROCEDURE UpdateSalary
@ID Int,
@NewSalary INT
AS
BEGIN 
UPDATE Employee
SET Salary = @NewSalary
WHERE EmpID= @ID;
END;

EXEC UpdateSalary 5,60000;

Select *from Employee;

--DELETE Using Stored Procedure

CREATE PROCEDURE DeleteEmployee
@ID INT
AS
BEGIN 
DELETE FROM Employee
WHERE EmpID= @ID;
END;

EXEC DeleteEmployee 13;

--ALTER Stored Procedure
ALTER PROCEDURE GetEmployee
AS
BEGIN 
SELECT EmpName,Salary 
FROM Employee;
END;


--Create procedure to show all HR employees.
CREATE PROCEDURE HREmployee
As
BEGIN 
Select *From 
Employee
Where Department = 'HR'
End;

EXEC HREmployee

--Create procedure to find employee by name.
CREATE PROCEDURE EmpbyName
@EmployeeName Varchar(50)
AS
Begin 
Select *from Employee 
Where EmpName =@EmployeeName
End;

EXEC EmpbyName Kunal;

--Create procedure to increase salary by 15%.
CREATE PROCEDURE EmpSal
AS
BEGIN
UPDATE Employee
Set Salary = Salary +( Salary *15/100)
END;

EXEC EmpSal;
Select *from Employee;

--Create procedure to delete employees from HR department.
CREATE PROCEDURE HRDept
@Dept VARCHAR(50)
AS
BEGIN 
DELETE FROM Employee 
WHERE Department = @Dept;
END;

EXEC HRDept 'HR';

--Create procedure to count total employees.
CREATE PROCEDURE  CountEmp
AS
BEGIN 
SELECT COUNT(EmpID)
From Employee
END;

EXEC CountEmp;

--Create procedure to show highest salary.
CREATE PROCEDURE Highsal
AS
BEGIN 
Select MAX(salary)
FROM Employee
END;

EXEC Highsal;















