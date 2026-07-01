Create table Inventory (
EmpID int,Empname Varchar(50), credit int)

insert into Inventory values ( 105, 'WER', 58000);


select *from Inventory

create procedure Amt
@add int 
as 
begin  
update Inventory set credit = credit+@add;
end 

Exec Amt 500;
Exec  amt 100;

Alter table inventory add Debit int

update Inventory set Debit= 0

CREATE PROCEDURE transferAmt
    @FromEmpID INT,
    @ToEmpID INT,
    @Amount INT
AS
BEGIN
    -- Deduct from sender
    UPDATE Inventory
    SET credit = credit - @Amount
    WHERE EmpID = @FromEmpID;

    -- Add to receiver
    UPDATE Inventory
    SET credit = credit + @Amount
    WHERE EmpID = @ToEmpID;
END;

Exec transferAmt 101,102,25;

select *from Inventory

CREATE PROCEDURE transferAmt1
    @FromEmpID INT,
    @ToEmpID INT,
    @Amount INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Debit from sender
    UPDATE Inventory
    SET Debit = Debit + @Amount,
        Credit = Credit - @Amount
    WHERE EmpID = @FromEmpID;

    -- Credit to receiver
    UPDATE Inventory
    SET Credit = Credit + @Amount
    WHERE EmpID = @ToEmpID;

    COMMIT;
END;

Exec transferAmt1 103,104, 30
select *from Inventory
Alter table inventory Add salary int
update Inventory set Salary = 50000
update inventory set credit = 0
update inventory set debit =0  

create procedure getAmt
@Empid int , @Credit int, @debit int 
as 
begin 
update inventory set credit= @credit - @debit where EmpID=@Empid
update inventory set debit =@debit + @Credit where EmpID =@Empid

End

Exec getAmt 101,102,2000

select *from Inventory

CREATE PROCEDURE getAmt2
    @EmpID INT,
    @Credit INT = 0,
    @Debit INT = 0
AS
BEGIN
    -- Update Credit and Debit
    UPDATE Inventory
    SET 
        Credit = Credit + @Credit,
        Debit  = Debit + @Debit
    WHERE EmpID = @EmpID;

    -- Display with calculated Remaining Salary
    SELECT 
        EmpID,
        EmpName,
        Salary,
        Credit,
        Debit,
        (Salary + Credit - Debit) AS RemainingSalary
    FROM Inventory
    WHERE EmpID = @EmpID;
END;

exec getAmt2 102,103,4000   
select *from Inventory 

