CREATE DATABASE CursorPractice;
GO

USE CursorPractice;
GO

CREATE TABLE Employee
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employee VALUES
(1, 'Riya', 'HR', 25000),
(2, 'Aman', 'IT', 40000),
(3, 'Neha', 'Finance', 28000),
(4, 'Raj', 'IT', 50000),
(5, 'Kunal', 'Support', 22000);

SELECT * FROM Employee;

DECLARE 
    @EmpID INT,
    @EmpName VARCHAR(50),
    @Salary INT;

DECLARE EmployeeCursor CURSOR 
FOR
SELECT EmpID,EmpName,Salary
FROM Employee;

OPEN EmployeeCursor;

FETCH NEXTFROM EmployeeCursor
INTO EmpID, EmpName, Salary;

WHILE @@FETCH_STATUS = 0
BEGIN

    PRINT 'Employee Name: ' + @EmpName;
    
    FETCH NEXT FROM EmployeeCursor
    INTO EmpID, EmpName, Salary;

END;


DECLARE 
    @EmpID INT,
    @EmpName VARCHAR(50),
    @Salary INT;

DECLARE EmployeeCursor CURSOR
FOR
SELECT EmpID, EmpName, Salary
FROM Employee;

OPEN EmployeeCursor;

FETCH NEXT FROM EmployeeCursor
INTO @EmpID, @EmpName, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN

    PRINT 'Employee ID: ' + CAST(@EmpID AS VARCHAR);
    PRINT 'Employee Name: ' + @EmpName;
    PRINT 'Salary: ' + CAST(@Salary AS VARCHAR);
    PRINT '--------------------------';

    FETCH NEXT FROM EmployeeCursor
    INTO @EmpID, @EmpName, @Salary;

END;

CLOSE EmployeeCursor;

DEALLOCATE EmployeeCursor;

--Requirement:

--Salary < 30000 → increase 20% Else → increase 10%

DECLARE 
@EMPID INT,
@Salary INT;

DECLARE SalaryCursor CURSOR
FOR
SELECT EmpID,Salary
FROM Employee;

OPEN SalaryCursor;
FETCH NEXT FROM SalaryCursor
INTO @EmpID, @Salary;

WHILE @@FETCH_STATUS=0
BEGIN 
      IF @Salary <30000
      BEGIN 
      UPDATE Employee SET Salary= Salary + (Salary *20/100)
      WHERE EmpID= @EmpID;

    END

    FETCH NEXT FROM SalaryCursor
    INTO @EmpID, @Salary;

    END ;
CLOSE SalaryCursor;
DEALLOCATE SalaryCursor;


Select *from Employee;


--Print only employee names using cursor.
DECLARE @EmpName Varchar(50);
DECLARE  MyCursor Cursor
FOR
SELECT EmpName From Employee 

OPEN MyCursor; 
FETCH NEXT FROM MyCursor 
INTO @EmpName;

WHILE @@FETCH_STATUS= 0
BEGIN 
PRINT @EmpName;

FETCH NEXT FROM MyCursor
INTO @EmpName;
END;

CLOSE MyCursor;
DEALLOCATE MyCursor;


-- Print salaries one by one

DECLARE @Salary INT;

DECLARE SalCursor CURSOR
FOR
SELECT Salary FROM Employee;

OPEN SalCursor;

FETCH NEXT FROM SalCursor
INTO @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @Salary;

    FETCH NEXT FROM SalCursor
    INTO @Salary;
END;

CLOSE SalCursor;
DEALLOCATE SalCursor;

--Print Name and Salary 
Declare @EmpName VARCHAR(50);
DECLARE @Salary Int;

DECLARE EmpCursor CURSOR
FOR 
SELECT EmpName,Salary 
FROM Employee;

OPEN EmpCursor;

FETCH NEXT FROM  EmpCursor
INTO @EmpName,@salary;

WHILE @@FETCH_STATUS=0
BEGIN 
     Print 'Name:' + @EmpName+ 'Salary:' + CAST(@Salary AS VARCHAR);

FETCH NEXT FROM EmpCursor
INTO @EmpName, @Salary;
END;

CLOSE EmpCursor;
DEALLOCATE EmpCursor;

--Increase Salary by 10% Using cursor:
DECLARE @EmpoldSalary INT;
DECLARE @EmpNewSalary INT;

DECLARE EmpSalary CURSOR 
FOR 
SELECT Salary FROM Employee;

OPEN EmpSalary;
FETCH NEXT FROM EmpSalary INTO
@EmpoldSalary;

While @@FETCH_STATUS=0
BEGIN
SET @EmpNewSalary =@EmpoldSalary+ (@EmpoldSalary*10/100);
PRINT 'Old Salary:' + CAST(@EmpoldSalary AS VARCHAR);
PRINT 'NEW SALARY:' + CAST(@EmpNEWSalary AS VARCHAR);

FETCH NEXT FROM EmpSalary 
INTO @EmpoldSALARY;
END;

CLOSE EmpSalary;
DEALLOCATE EmpSalary;

--INCREASE IT DEPARTMENT SALARY 'IT' DEPARTMENT GET +5000 SA
DECLARE @EmpITSalary INT;
DECLARE @Department VARCHAR(50);

DECLARE EmpIT CURSOR 
FOR 
SELECT Department,Salary FROM Employee 

OPEN EmpIT ;

FETCH NEXT FROM EmpIT
INTO @Department,@EmpITSalary;

WHILE @@FETCH_Status = 0
BEGIN 
if @Department= 'IT'
BEGIN
SET @EmpITSalary =@EmpITSalary + 5000;
Print'Department:' + @Department + 'Updated Salary: ' + CAST(@EmpITSalary AS VARCHAR);

END;

FETCH NEXT FROM EMPIT
INTO @DEPARTMENT,@EmpITSALARY;
END;

CLOSE EmpIT;
DEALLOCATE EmpIT;


--Print Employees With Salary Greater Than 30000
DECLARE @EmpNam VARCHAR(50);
DECLARE @EmpSal INT
DECLARE HighSalary CURSOR 
FOR 
SELECT EmpName,Salary from Employee;

OPEN HighSalary;

FETCH NEXT FROM HighSalary 
INTO @EmpNam, @EmpSal;

WHILE @@FETCH_STATUS=0
BEGIN 
IF @EmpSal >30000 
BEGIN 
PRINT 'EmpName:'+ @EmpNam +
       'Salary:'+ CAST(@EmpSal AS VARCHAR);

END;

FETCH NEXT FROM HighSalary
INTO @EmpNam, @EmpSal;

END;
CLOSE HighSalary;
DEALLOCATE HighSalary;

--Count Total Employees Using Cursor


DECLARE @EmpName VARCHAR(50);
DECLARE @Count INT = 0;

DECLARE EmpCount CURSOR
FOR
SELECT EmpName
FROM Employee;

OPEN EmpCount;

FETCH NEXT FROM EmpCount
INTO @EmpName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Count = @Count + 1;

    FETCH NEXT FROM EmpCount
    INTO @EmpName;
END;

PRINT 'Total Employees: ' + CAST(@Count AS VARCHAR);

CLOSE EmpCount;
DEALLOCATE EmpCount;

-- Find Total Salary Using Cursor

DECLARE @Salary INT;
DECLARE @TotalSalary INT = 0;

DECLARE TotalSal CURSOR
FOR
SELECT Salary
FROM Employee;

OPEN TotalSal;

FETCH NEXT FROM TotalSal
INTO @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @TotalSalary = @TotalSalary + @Salary;

    FETCH NEXT FROM TotalSal
    INTO @Salary;
END;

PRINT 'Total Salary: ' + CAST(@TotalSalary AS VARCHAR);

CLOSE TotalSal;
DEALLOCATE TotalSal; 


-- Delete Employees With Salary Less Than 25000 Using Cursor

DECLARE @EmpID INT;
DECLARE @Salary INT;

DECLARE DeleteEmp CURSOR
FOR
SELECT ID, Salary
FROM Employee;

OPEN DeleteEmp;

FETCH NEXT FROM DeleteEmp
INTO @EmpID, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Salary < 25000
    BEGIN
        DELETE FROM Employee
        WHERE ID = @EmpID;

        PRINT 'Deleted Employee ID: ' + CAST(@EmpID AS VARCHAR);
    END;

    FETCH NEXT FROM DeleteEmp
    INTO @EmpID, @Salary;
END;

CLOSE DeleteEmp;
DEALLOCATE DeleteEmp;

-- Insurance Project Scenario Using Cursor

DECLARE @EmpID INT;
DECLARE @Salary INT;
DECLARE @NewSalary INT;

DECLARE SalaryUpdate CURSOR
FOR
SELECT ID, Salary
FROM Employee;

OPEN SalaryUpdate;

FETCH NEXT FROM SalaryUpdate
INTO @EmpID, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Salary < 30000
    BEGIN
        SET @NewSalary = @Salary + (@Salary * 20 / 100);
    END
    ELSE
    BEGIN
        SET @NewSalary = @Salary + (@Salary * 10 / 100);
    END;

    UPDATE Employee
    SET Salary = @NewSalary
    WHERE ID = @EmpID;

    PRINT 'Employee ID: ' + CAST(@EmpID AS VARCHAR) +
          ' Updated Salary: ' + CAST(@NewSalary AS VARCHAR);

    FETCH NEXT FROM SalaryUpdate
    INTO @EmpID, @Salary;
END;

CLOSE SalaryUpdate;
DEALLOCATE SalaryUpdate; 



