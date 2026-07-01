DECLARE @n INT = 153;
DECLARE @temp INT;
DECLARE @r INT;
DECLARE @s INT = 0;

SET @temp = @n;

WHILE @n > 0
BEGIN
    SET @r = @n % 10;
    SET @s = @s + (@r * @r * @r);
    SET @n = @n / 10;
END

IF @s = @temp
    PRINT 'Armstrong Number';
ELSE
    PRINT 'Not an Armstrong Number';
