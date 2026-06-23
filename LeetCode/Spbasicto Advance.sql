use CompanyDB
Select *from Employee;

--1. Create a Stored Procedure to display all employees.
Create Procedure EmpDetails
As
Begin 
Select EmpID,EmpName,Department,Salary
From Employee
END

EXEC EmpDetails;


--2.Create a Stored Procedure to get employee details by EmployeeID.
Create Procedure EmpDettailsbyIDe
@ID int
AS
Begin
Select EmpName,Department, Salary,City
From Employee
Where EmpID =@ID
END

EXEC EmpDettailsbyID 1;

--3.Create a Stored Procedure to get employee details by EmployeeID.
Create Procedure NewEmpDetp
@ID Int,
@Name Varchar(50),
@dept Varchar(50),
@Sal Int,
@City Varchar(50)
As
Begin 
Insert Into Employee(EmpID,EmpName,Department,Salary,City) Values (
@ID,@Name,@dept,@Sal,@City)
End

Exec NewEmpDetp 1,'Amit','Sales',500000,'Solapur';
Select *from Employee;

Delete From Employee Where EmpID=14;

--4.Create a Stored Procedure to update an employee's salary.
Create procedure UpdateEmp
@ID int,
@Sal int
As
Begin 
Update Employee Set 
Salary =@Sal 
Where EmpID=@ID
End

EXEC UpdateEmp 14,800000


--5.Create a Stored Procedure to delete an employee by EmployeeID.
Create Procedure DelEmp
@ID Int
AS
Begin
Delete from Employee
Where EmpID=@ID
end

Exec DelEmp 14;

--6.Create a Stored Procedure to return employees whose salary is greater than a given amount.
Create Procedure EmpSalar
As
Begin
Select EmpName,Salary
From Employee
where Salary >=50000
End

Exec EmpSalar

--7 Create a Stored Procedure with an OUTPUT parameter that returns the total number of employees.
Create Procedure GetEmpCount
@Count Int Output
As
Begin
Select @Count=Count(*)
From Employee
End;

DECLARE @Count INT;

EXEC GetEmpCount @Count OUTPUT;
PRINT @Count;

--8. Create a Stored Procedure to calculate total salary of a department.
Create Procedure DeptEmp
@dept Varchar(50)
As
Begin
select *from Employee
Where Department =@dept
End

Exec DeptEmp 'Sales';

--9. Create a Stored Procedure that inserts data only if EmployeeID does not already exist.
CREATE PROCEDURE InsertEmployee
    @ID INT,
    @Name VARCHAR(50),
    @Dept VARCHAR(50),
    @Salary INT,
    @City VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1
               FROM Employee
               WHERE EmpID = @ID)
    BEGIN
        PRINT 'Employee ID already exists';
    END
    ELSE
    BEGIN
        INSERT INTO Employee
        (
            EmpID,
            EmpName,
            Department,
            Salary,
            City
        )
        VALUES
        (
            @ID,
            @Name,
            @Dept,
            @Salary,
            @City
        );

        PRINT 'Employee inserted successfully';
    END
END;

EXEC InsertEmployee
    15,
    'Ramesh',
    'Sales',
    400000,
    'Solapur';

--10. Create a Stored Procedure to display top 5 highest-paid employees.
   CREATE PROCEDURE TopEmp
AS
BEGIN
    SELECT TOP 5 *
    FROM Employee
    ORDER BY Salary DESC;
END;

Exec TopEmp 

CREATE PROCEDURE TopEmp1
AS
Begin 
Select top 5 *
From Employee
ORDER By Salary DESC;
END;

EXEC TopEmp1;
--11. Create a Stored Procedure using TRY-CATCH for error handling.
CREATE PROCEDURE InsertEmploye                                   
    @ID INT,
    @Name VARCHAR(50),
    @Dept VARCHAR(50),
    @Salary INT,
    @City VARCHAR(50)
AS
BEGIN
    BEGIN TRY

        INSERT INTO Employee
        (
            EmpID,
            EmpName,
            Department,
            Salary,
            City
        )
        VALUES
        (
            @ID,
            @Name,
            @Dept,
            @Salary,
            @City
        );

        PRINT 'Employee inserted successfully';

    END TRY

    BEGIN CATCH

        PRINT 'Error occurred while inserting employee';

    END CATCH
END;


EXEC InsertEmploye
    16,
    'Rasha',
    'Sales',
    700000,
    'Solapur';


--12.Create a Stored Procedure using a transaction.
CREATE PROCEDURE InsertEmployeeWithAudit         
    @ID INT,
    @Name VARCHAR(50),
    @Dept VARCHAR(50),
    @Salary INT,
    @City VARCHAR(50)
AS
BEGIN
    BEGIN TRY

        BEGIN TRANSACTION;

        -- Insert into Employee table
        INSERT INTO Employee
        (
            EmpID,
            EmpName,
            Department,
            Salary,
            City
        )
        VALUES
        (
            @ID,
            @Name,
            @Dept,
            @Salary,
            @City
        );

        -- Insert into Audit table
        INSERT INTO EmployeeAudit
        (
            EmpID,
            ActionType,
            ActionDate
        )
        VALUES
        (
            @ID,
            'INSERT',
            GETDATE()
        );

        COMMIT TRANSACTION;

        PRINT 'Data inserted successfully';

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        PRINT 'Transaction rolled back';
        PRINT ERROR_MESSAGE();

    END CATCH
END;


EXEC InsertEmployeeWithAudit
    17,
    'Ritima',
    'Sales',
    600000,
    'Solapur';


--13. Create a Stored Procedure that updates salary by percentage.
CREATE PROCEDURE IncreaseSalary
    @EmpID INT,
    @Percentage DECIMAL(5,2)
AS
BEGIN
    UPDATE Employee
    SET Salary = Salary + (Salary * @Percentage / 100)
    WHERE EmpID = @EmpID;

    PRINT 'Salary Updated Successfully';
END;

EXEC IncreaseSalary 15,10;


--14.Create a Stored Procedure to return employees hired within the last N months.
CREATE PROCEDURE EarlyEmp
@Months int 
As
Begin 
Select *from 
Employee
where HireDate >= DATEADD(Month,-@Months,GetDate());
END;

EXEC EarlyEmp 6;


--15. Create a Stored Procedure that dynamically selects data from any table name passed as a parameter.
CREATE PROCEDURE GetTableData
    @TableName VARCHAR(100)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = 'SELECT * FROM ' + @TableName;

    EXEC sp_executesql @SQL;
END;

Exec GetTableData 'Employee';

--16. Create a Stored Procedure to transfer money between two bank accounts.
CREATE PROCEDURE TransferSalary 
@FromEmpID Int,
@ToEmpID Int,
@Amount Decimal (10,2)
As
Begin 
Begin Try
Begin Transaction 

Update Employee 
Set Salary = Salary - @Amount
where EmpID = @ToEmpID

Commit Transaction 
print 'Transfer successful';
End Try 

Begin Catch 
Rollback Transaction;
print Error_Message();

END Catch 
End;

EXEC TransferSalary
    @FromEmpID = 10,
    @ToEmpID = 12,
    @Amount = 5000;

Select * from Employee;


--Intermediate  Question 
--Get Employees by Department
Create Procedure EmpBydep
@dept varchar(50)
As
Begin
Select
* from Employee
Where Department = @dept;
End

Exec EmpBydep 'sales';

--Get Employees Between a Salary Range
Create procedure EmpSalrange 
@Tosal int,
@Fromsal int
As
Begin
Select
* from Employee 
Where Salary between @Tosal And @Fromsal
End

Exec EmpSalrange 50000,200000;

--Return Average Salary of a Department using OUTPUT parameter.
Create Procedure AvgSal
@Dept varchar(50) ,
@Avgsal decimal(10,2) Output
As
Begin 
Select @Avgsal= Avg(salary)
From Employee
where Department = @Dept;
End;

Declare @Result Decimal(10,2);
Exec AvgSal
@Dept ='IT',
@Avgsal = @Result Output ;
print @Result;

--Return Highest Salary Employee Details.
Create Procedure EmpHighSalary
As
Begin 
Select Max(salary) As HighestSalary From 
Employee
End;

EXEC EmpHighSalary;

--Return Lowest Salary Employee Details.
Create Procedure EmpLowSalary
As
Begin
Select Min(Salary) As LowestSalary 
From Employee
End;

EXEC EmpLowSalary;

--To Get Emp Details With salary 
CREATE PROCEDURE EmplHighSalary
AS
BEGIN
    SELECT *
    FROM Employee
    WHERE Salary = (
        SELECT MAX(Salary)
        FROM Employee
    );
END;

Exec EmplHighSalary

--Second Highest Salary 
Create Procedure ScondHighSal
As
Begin 
Select 
* From Employee
Where Salary =  ( 
Select Max(Salary)
From Employee
Where Salary < 
(Select MAX(Salary)
From Employee)
);
End;

EXEC ScondHighSal

--Get Employees Whose Name Starts With a Given Letter.
CREATE PROCEDURE letterstartwith
    @Letter CHAR(1)
AS
BEGIN
    SELECT *
    FROM Employee
    WHERE EmpName LIKE @Letter + '%';
END;

Exec letterstartwith 'R';

--Count Employees in Each Department.
Create procedure CountbyDept
As
Begin 
Select Department,Count(*) As CountDepartment
From Employee 
Group by Department
End;

Exec CountbyDept;


--Input from User 
--Insert Employee Only If Salary > 400000.
Create Procedure EmploSal
@salary int
AS
Begin
Select salary from Employee
where Salary > @salary 
End;

Exec EmploSal 500000;

--Update Department of an Employee.
CREATE PROCEDURE UpdateDepartment
    @NewDept VARCHAR(50),
    @OldDept VARCHAR(50)
AS
BEGIN
    UPDATE Employee
    SET Department = @NewDept
    WHERE Department = @OldDept;
END;

EXEC UpdateDepartment 'IT', 'Sales';
Select *from Employee;

--Find Nth Highest Salary.

Create Procedure Nthhighestsal
@N int
As 
Begin 
Select Min(salary) As  NthhighSalary 
From (
Select Distinct Top (@N) Salary 
From Employee
Order By Salary DESC 
) AS T ;
END;

EXEC Nthhighestsal 5;


--Find Duplicate Employees Based on Name.
Create Procedure DupliEmpName
As
Begin 
Select EmpName,count(*) As DuplicateName
From Employee
Group By EmpName 
Having Count(*) > 1;
End;

Exec DupliEmpName 

--Delete Duplicate Records Using CTE and ROW_NUMBER().
Create Procedure DeleteduplicateEmp
As
Begin 
with CTE AS
( 
Select *, 
Row_Number() Over
( partition By EmpId
Order By EmpId
) AS RN 
From Employee
)
Delete 
From CTE 
where RN > 1;

Print 'Duplicated Record Deleted Successfully';
End ;

Exec DeleteduplicateEmp;


--Display Top 3 Salaries from Each Department.
CREATE PROCEDURE SalEmp
AS
BEGIN
;WITH CTE AS
(
SELECT *,
 DENSE_RANK() OVER
   (
       PARTITION BY Department
         ORDER BY Salary DESC
          ) AS RNK
 FROM Employee
    )
 SELECT *
  FROM CTE
  WHERE RNK <= 3;
END;















