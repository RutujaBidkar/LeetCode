---Combine two tables 
Create table Person (
Personld INT PRIMARY KEY , lastName Varchar (255), 
firstName Varchar (255)
);
Create table Address (
addressld INT PRIMARY KEY,
personld INT ,
City Varchar (255),
State Varchar(255)
);

Insert Into Person (Personld,lastName,firstName) Values 
(1,'Wang','Allen'),
(2,'Alice','Bob');

Insert Into Address (addressld, personld,City,State)Values 
(1,2,'New York City', 'New York'),
(2, 3,'LeetCode','California');

--To show Result with the help of left join 
SELECT 
P.firstName,
p.LastName,
a.City,
a.state 
from Person p 
Left JOIN Address a 
ON p.Personld = a.personld;


---2nd 
Use PerformanceDB
--Find Second Highest salary
Create Table Employee (
id INT PRIMARY KEY,
salary INT);

Insert INTO Employee Values ( 1, 100);
Insert INTO Employee Values ( 2, 200);
Insert INTO Employee Values ( 3, 300);

Select MAX(salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary < (SELECT MAX (salary) FROM Employee );

--Alternative Method 
SELECT 
    (SELECT DISTINCT salary
     FROM Employee
     ORDER BY salary DESC
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;

Select *from Employee

---3rd  FIND HIGHEST SALARY 
CREATE FUNCTION getNthHighestSalary (@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    SELECT @result = salary
    FROM (
        SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
        FROM Employee
    ) t
    WHERE rnk = @N;

    RETURN @result;
END;
SELECT dbo.getNthHighestSalary(2);   

 
 --4th RANK SCORES   
 use PerformanceDB
CREATE TABLE SCORES1 (  
  id INT PRIMARY KEY,
  score DECIMAL(5,2)
  );
INSERT INTO SCORES1(id, score) VALUES
(1, 3.50),
(2, 3.65),
(3, 4.00),
(4, 3.85),
(5, 4.00),
(6, 3.65);

SELECT Score,DENSE_RANK() OVER (ORDER BY score DESC) AS rank 
FROM SCORES1
ORDER BY score DESC;

--5Th  Find Consecutive Number 
Use PerformanceDB
CREATE TABLE Logs (
id INT PRIMARY KEY,
num VARCHAR(50)
);
INSERT INTO Logs VALUES 
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2);

SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT 
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev1,
        LAG(num, 2) OVER (ORDER BY id) AS prev2
    FROM Logs
) t
WHERE num = prev1 AND num = prev2; 

---6th FIND EMPLOYEE EARNING MORE THAN THEIR MANAGERS 
Select *from Employee
Alter Table Employee Add  Name VARCHAR(50), managerID INT 
INSERT INTO  EMPLOYEE VALUES( 4, 90000,'Max',null);


SELECT e1.Name AS Employee 
FROM Employee e1 
JOIN Employee e2 
ON e1.managerID = e2.id
WHERE e1.salary > e2.salary 

----7th Find Duplicate Emails 
CREATE TABLE Person (
id INT PRIMARY KEY ,
Email VARCHAR (50)
);
INSERT INTO PERSON VALUES (1,'a@b.com');
INSERT INTO PERSON VALUES (2,'c@d.com');
INSERT INTO PERSON VALUES (3,'a@b.com');
Select *from Person

SELECT Email 
FROM Person 
GROUP BY Email  
HAVING COUNT(Email) >1 ;

---8th FIND CUSTOMERS WHO NEVER ORDER 
CREATE TABLE Customers  (
id INT PRIMARY KEY, 
name VARCHAR (50) 
);

CREATE TABLE Orders (
id INT PRIMARY KEY ,
CustomerId INT, 
FOREIGN KEY (CustomerId) REFERENCES Customers(id) );

INSERT INTO Customers (id, name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');

INSERT INTO Orders (id, customerId) VALUES
(1, 3),
(2, 1);

SELECT c.name AS Customers 
FROM Customers c 
JOIN Orders  o
on c.id = o.customerId 
where o.customerId IS NULL ;

--9th Department highest salary 
Alter Table Employee ADD Salary int, departmentID int;
Select *from Employee
update Employee set departmentID= 1 where id =105 ;

Create table Department( Id int, Name varchar); 
Insert Into Department values ( 101,'IT');
Insert Into Department values ( 102,'Sales');SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d
    ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE departmentId = e.departmentId
);









