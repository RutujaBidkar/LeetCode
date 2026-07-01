use practical

create table Amt(AccountNo int, Amount bigint) 
select *from Amt
insert into Amt values ( 105, 5000);

CREATE PROCEDURE TransferAmount
    @FromAccount INT,
    @ToAccount INT,
    @TransferAmount INT
AS
BEGIN
    BEGIN TRANSACTION;

    UPDATE Amt
    SET amount = amount -@TransferAmount
    WHERE AccountNo=@FromAccount;

    UPDATE Amt
    SET amount = amount + @TransferAmount
    WHERE AccountNo= @ToAccount ;

    COMMIT TRANSACTION;
END;

TransferAmount 101,102,500

select *from Amt

Alter table Amt add  Credit int
Alter table Amt add  Debit int



CREATE PROCEDURE TransferAmount1
    @FromAccount INT,
    @ToAccount INT,
    @TransferAmount INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Debit from sender
    UPDATE Amt
    SET 
        Amount = Amount - @TransferAmount,
        Debit  = Debit + @TransferAmount
    WHERE AccountNo = @FromAccount;

    -- Credit to receiver
    UPDATE Amt
    SET 
        Amount = Amount + @TransferAmount,
        Credit = Credit + @TransferAmount
    WHERE AccountNo = @ToAccount;

    COMMIT TRANSACTION;
END;

update Amt set Credit= 0
Update Amt set Debit = 0 

TransferAmount1 102,105,1500


CREATE PROCEDURE TransferAmount2
    @FromAccount INT,
    @ToAccount INT,
    @TransferAmount INT
AS
BEGIN
    -- Check sender account exists
    IF NOT EXISTS (SELECT 1 FROM Amt WHERE AccountNo = @FromAccount)
    BEGIN
        PRINT 'Invalid From Account Number';
        RETURN;
    END

    -- Check receiver account exists
    IF NOT EXISTS (SELECT 1 FROM Amt WHERE AccountNo = @ToAccount)
    BEGIN
        PRINT 'Invalid To Account Number';
        RETURN;
    END

    -- Check sufficient balance
    IF (SELECT Amount FROM Amt WHERE AccountNo = @FromAccount) < @TransferAmount
    BEGIN
        PRINT 'Insufficient Balance';
        RETURN;
    END

    BEGIN TRANSACTION;

    -- Debit sender
    UPDATE Amt
    SET 
        Amount = Amount - @TransferAmount,
        Debit  = Debit + @TransferAmount
    WHERE AccountNo = @FromAccount;

    -- Credit receiver
    UPDATE Amt
    SET 
        Amount = Amount + @TransferAmount,
        Credit = Credit + @TransferAmount
    WHERE AccountNo = @ToAccount;

    COMMIT TRANSACTION;

    PRINT 'Amount Transferred Successfully';
END;

TransferAmount2 101,102,5000