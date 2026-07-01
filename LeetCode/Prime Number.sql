DECLARE @n INT = 13;
DECLARE @i INT = 2;
DECLARE @flag INT = 1;

IF @n <= 1
    SET @flag = 0;

WHILE @i <= @n / 2 AND @flag = 1
BEGIN
    IF @n % @i = 0
        SET @flag = 0;
    SET @i = @i + 1;
END

IF @flag = 1
    PRINT 'Prime Number';
ELSE
    PRINT 'Not Prime Number';
