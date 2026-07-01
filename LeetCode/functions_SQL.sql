Use CompanyDB;

--Start FROM SCARCH
--String Functions
--UPPERCASELETTER
SELECT UPPER('rutuja') AS Capital ;

--LOWERCASELETTER
SELECT LOWER ('SQL SERVER') As Lowerletter;

--FIND A LENGTH
SELECT LEN('DATABASE') AS leng;

--SUBSTRING
SELECT SUBSTRING ('SQLSERVER' ,1,6);

--NUMERIC FUNCTIONS
--ROUND()
SELECT ROUND(123.4567,2);


--ABS RETURN POSITIVE NUMBER 
SELECT ABS(-100);

--DATE FUNCTION
SELECT GETDATE();

--YEAR()
SELECT YEAR(GETDATE());


--MONTH()
SELECT MONTH(GETDATE());

--Aggregate FUNCTION 
SELECT COUNT(*) FROM Employee;

--SUM()
SELECT SUM(salary) FROM Employee;

--AVG()
SELECT AVG(Salary) FROM Employee;

--MAX()
SELECT Max(salary) From Employee;

--MIN() 
SELECT Min(Salary) From Employee;


--Scalar Function
CREATE FUNCTION Sq
(
@num INT
)
RETURNS INT
AS
BEGIN
RETURN @num * @num ;
END;

SELECT dbo.sq (8);

--Calculate Bonus
CREATE FUNCTION SalBonus
(
@Salary INT
)
RETURNS INT
AS
BEGIN 
     RETURN @Salary * 10/100;
END;

SELECT dbo.SalBonus(80000);

--Table-Valued Function
CREATE FUNCTION GetEmpByDept
(@Dept VARCHAR(50)
)
RETURNS TABLE
AS
Return 
(
SELECT *FROM 
Employee
Where Department = @dept
);

SELECT *FROM dbo.GetEmpByDept ('IT');


ALTER FUNCTION sq 
(
@Num INT
)
RETURNS INT 
As
BEGIN
RETURN @Num * @Num * @Num ;
END;





