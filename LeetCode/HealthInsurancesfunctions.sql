Use HealthInsurance;
SELECT  * FROM Customers;
SELECT  * FROM Polices;
SELECT  * FROM Claims;
INSERT INTO Claims (PolicyID, ClaimAmount, ClaimDate, ClaimStatus)
VALUES
(101, 50000, '2025-04-10', 'Approved'),
(101, 25000, '2025-05-12', 'Pending'),
(102, 75000, '2025-06-01', 'Approved'),
(103, 40000, '2025-06-15', 'Rejected'),
(104, 30000, '2025-07-01', 'Approved'),
(104, 20000, '2025-07-10', 'Approved'),
(102, 15000, '2025-07-15', 'Pending'),
(101, 10000, '2025-07-20', 'Approved'),
(103, 60000, '2025-08-01', 'Rejected'),
(104, 45000, '2025-08-05', 'Approved');


--Create a function that returns age using CustomerID.
CREATE FUNCTION fngetCustomerAge
(
    @CustID INT
)
Returns INT 
AS
BEGIN
      DECLARE @Age INT;
      
      SELECT @Age = DATEDIFF(YEAR,DOB,GETDATE()) -
      CASE
          WHEN DATEADD(YEAR, DATEDIFF(YEAR,DOB, GETDATE()), DOB) > GETDATE()
          THEN 1
          ELSE 0
        END
FROM Customers
WHERE CustomerID = @CustID;

RETURN @Age;
END;
          
SELECT dbo.fnGetCustomerAge(1) AS Age;


--Total Policies of Customer
CREATE FUNCTION fn_TotalPolicies 
(
   @CustID INT 
)
RETURN INT
AS
BEGIN 
      DECLARE @Total INT;

      SELECT @Total = COUNT(*)
      FROM Polices
      WHERE CustomerID= @CustID
      RETURN @Total;
 END;


