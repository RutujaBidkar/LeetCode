create table stud ( ID int , Name char(50), City char(30), country char(30), MobileNumber bigint, Age int, Gender char);
insert into stud values(101, 'RutujaBidkar', 'solapur',  'India',7896547894, 23, 'F')
insert into stud values(102, 'PallaviKamble','kholapur',  'India',8894459789, 24, 'F')
insert into stud values(103, 'siddhiThokal', 'Pune', 'UK',9874554789, 20, 'F')
insert into stud values(104, 'RuturajBidkar', 'Mumbai',  'UA',99887747894, 19, 'M')
insert into stud values(105, 'AravYadav', 'Gujrat',  'India',7756547894, 17, 'M')
insert into stud values(106, 'Amnolpatil', 'satara',  'India',7896547894, 18, 'F')
select *from stud
update  stud set Gender='M' where id=106;


we have create a function to apply all the command to get the date fromthe table.....


CREATE FUNCTION Demos()
RETURNS TABLE
AS
RETURN
(
    SELECT ID, Name, City, MobileNumber, Age
    FROM Stud
);

select *from Demos()

CREATE FUNCTION standa (@a INT)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM stud
    WHERE ID = @a
);

select *from standa

CREATE FUNCTION devu (@a CHAR(1))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM stud
    WHERE Gender = @a
);

SELECT * FROM devu('M');







