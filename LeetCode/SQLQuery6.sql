DECLARE @n INT = 121;
DECLARE @r INT;
DECLARE @rev INT = 0;
DECLARE @temp INT;

SET @temp = @n;

WHILE @n > 0
BEGIN
    SET @r = @n % 10;
    SET @rev = @rev * 10 + @r;
    SET @n = @n / 10;
END

IF @temp = @rev
    PRINT 'Palindrome';
ELSE
    PRINT 'Not Palindrome';
