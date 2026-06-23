use CompanyDB;
SELECT * FROM Employee;


--Start From Scarch 
CREATE PROCEDURE GetEmployee
As
BEGIN 
SELECT * FROM Employee
END;

EXEC GetEmployee;

--Stored PROCEDURE WITH WHERE CONDITIOn 
CREATE PROCEDURE ITEmp
AS
BEGIN 
SELECT Department 
FROM Employee
WHERE Department = 'IT';
END;

EXEC ITEmp;

CREATE PROCEDURE ITEmpDetails
AS
BEGIN 
SELECT *FROM 
Employee
WHERE DEPARTMENT = 'IT';
END;

EXEC ITEmpDetails;

--Stored Procedure with Parameter Get employee by ID
CREATE PROCEDURE GEtEmpBYID
@ID INT
AS
BEGIN 
SELECT * FROM 
Employee
WHERE EmpID= @ID ;
END;

EXEC GEtEmpBYID 10;

--INSERT DATA INTO EMPLOYEE TABLE
CREATE PROCEDURE Insertemp
@EmpID INT,
@EmpName VARCHAR(50),
@Department VARCHAR(50),
@Salary INT,
@City VARCHAR(50)
AS
BEGIN
INSERT INTO Employee VALUES(@EmpID,@EmpName, @Department,@Salary,@City);
END;

EXEC Insertemp 7, 'Sita', 'IT', 70000, 'Pune';
Select *from Employee;

--UPDATE STORED PROCEDURE 
CREATE PROCEDURE UpdateSal 
@ID INT,
@Name Varchar(50)
AS
BEGIN 
UPDATE Employee Set
EmpName = @Name where 
EmpID =@ID;
END;

EXEC UpdateSal 12, 'Pratik' 

--DELETE USING STORED PROCEDURE 
CREATE PROCEDURE DELETEEmp
@ID INT
AS
BEGIN 
DELETE FROM Employee
WHERE EmpID =@ID;
END;

EXEC DELETEEmp 7;

CREATE CLUSTERED INDEX IDEMP ON Employee(EmpID ASC);
SELECT *FROM Employee;

--COUNT EMPLOYEES
CREATE PROCEDURE CntEmp
AS
BEGIN 
SELECT COUNT(*) AS TotEmp
FROM Employee;
END;

EXEC CntEmp;

--STORE PROCEDURE WITH MULTIPLE PARAMETER
CREATE PROCEDURE GetDeptSalary
@Dept VARCHAR(50),
@salary Int
AS
BEGIN 
SELECT * 
FROM Employee
WHERE Department= @Dept
AND Salary > @salary;
END;

EXEC GetDeptSalary 'IT', 60000;

--Create procedure to show all HR employees.
CREATE PROCEDURE HREmp
As
BEGIN 
SELECT * FROM Employee
WHERE Department = 'HR';
END;

EXEC HREmp;

--Create procedure to find highest salary.
CREATE PROCEDURE HighSa
AS
BEGIN 
SELECT MAX(Salary)
FROM Employee;
END;

EXEC Highsa

--Create procedure to count employees department wise
CREATE PROCEDURE DeptCount
AS
BEGIN
Select Department,COUNT(*)
FROM Employee
GROUP BY Department
END;

--Create procedure to update department.
CREATE PROCEDURE UptDept
@ID Int,
@Dep VARCHAR(50)
As
BEGIN
UPDATE Employee Set Department= @Dep
WHERE EmpID =@ID;
END;

EXEC UpdDept 7,'Sale';


--FUNCTION BY SQUARE 
CREATE FUNCTION Square
(
@Num INT
)
RETURNS INT
AS
BEGIN 
RETURN @Num * @Num;
END;

SELECT Square (8) AS RESULT;

--ADDITION FUNCTION
CREATE FUNCTION Addi
(
@A INT,
@B INT
)
RETURNS INT
AS
BEGIN 
    RETURN @A + @B;
END;

SELECT Addi(7+4);

--Anual Salary
CREATE FUNCTION dbo.AnnualSalary
(
@Salary INT
)
RETURNS INT
AS
BEGIN 
RETURN @Salary * 12;
END;

SELECT EmpName,
       Salary,
       dbo.AnnualSalary(Salary) AS AnnualSalary
FROM Employee;

--Employees BY DEPARTMENT 
CREATE FUNCTION GetDeptEmp
(
@Dept VARCHAR(50)
)
RETURNS TABLE
AS
RETURN 
(
SELECT * FROM 
Employee
WHERE Department = @Dept
);

SELECT dbo.GetDeptEmp 

--Create function to find cube of number
CREATE FUNCTION cub
(
@Num INT
)
Returns Int
As
BEGIN
Return @Num *@Num *@Num ;
END;

SELECT dbo.cub(8) AS cubevalue;




