use companydb
CREATE TABLE Department
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

INSERT INTO Department
VALUES
(1, 'HR', 'Pune'),
(2, 'IT', 'Mumbai'),
(3, 'Finance', 'Nagpur'),
(4, 'Admin', 'Nashik');

CREATE TABLE Consumers (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    Age INT,
    City VARCHAR(50)
);

INSERT INTO Consumers
VALUES
(101, 'Amit', 1, 35000, 25, 'Pune'),
(102, 'Priya', 2, 60000, 30, 'Mumbai'),
(103, 'Rahul', 3, 45000, 28, 'Nagpur'),
(104, 'Sneha', 2, 70000, 35, 'Pune'),
(105, 'Karan', 4, 40000, 40, 'Nashik'),
(106, 'Neha', 1, 38000, 27, 'Mumbai'),
(107, 'Vikas', 3, 55000, 32, 'Pune'),
(108, 'Pooja', 2, 65000, 29, 'Nagpur');

--Display:EmployeeID, EmployeeName,DepartmentName,Location, Salary using INNER JOIN 

SELECT 
      Emp.EmployeeID,
      Emp.EmployeeName,
      Dept.DepartmentName,
      Dept.Location,
      Emp.Salary
      FROM Consumers Emp
      INNER JOIN Department Dept
      ON  Emp.DepartmentID = Dept.DepartmentID

--Display:EmployeeID, EmployeeName,DepartmentName,Location, salary using left join
SELECT 
      Emp.EmployeeID,
      Emp.EmployeeName,
      Dept.DepartmentName,
      Dept.Location,
      Emp.Salary
      FROM Consumers Emp
      LEFT JOIN Department Dept
      ON Emp.DepartmentID= Dept.DepartmentID

--Display:EmployeeID, EmployeeName,DepartmentName,Location, salary using Right Join 
SELECT 
      Emp.EmployeeID,
      Emp.EmployeeName,
      Dept.DepartmentName,
      Dept.Location,
      Emp.Salary
      FROM Consumers Emp
      RIGHT JOIN Department Dept
      ON Emp.DepartmentID = Dept.DepartmentID

--Display:EmployeeID, EmployeeName,DepartmentName,Location, salary using Full Outer join 
SELECT 
      Emp.EmployeeID,
      Emp.EmployeeName,
      Dept.DepartmentName,
      Dept.Location,
      Emp.Salary
      FROM Consumers Emp
      FULL OUTER JOIN 
      Department Dept
      ON Emp.DepartmentID = Dept.DepartmentID 

---For self join
CREATE TABLE Companydata
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    ManagerID INT
);
INSERT INTO Companydata
VALUES
(1, 'Amit', NULL),
(2, 'Priya', 1),
(3, 'Rahul', 1),
(4, 'Sneha', 2),
(5, 'Karan', 2),
(6, 'Neha', 3);

SELECT
    E.EmployeeID,
    E.EmployeeName AS Employee,
    M.EmployeeName AS Manager
FROM Companydata E
INNER JOIN Companydata M
ON E.ManagerID = M.EmployeeID;

