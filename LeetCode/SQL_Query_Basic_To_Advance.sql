--Basic to advance Query 

--SELECT & FROM
SELECT * FROM Orders;
SELECT Order_id, Customer_id, revenue FROM Orders;
SELECT DISTINCT city FROM Customers;
SELECT DISTINCT city, region FROM Customers;
SELECT order_id, revenue * 1.18 As revenue_with_gst FROM ders;
SELECT CONCAT(first_name, ' ' , last_name) AS Full_name FROM employees;
SELECT UPPER(city) AS City_upper FROM Customers;
SELECT LOWER(Email) AS email_clean FROM Customers;
SELECT TRIM(Name) As Name_Clean FROM Customers;
SELECT LENGTH(email) AS Email_Length FROM Users;
SELECT Round(revenue, 2) As revenue_rounded FROM orders;
SELECT NOW() AS Current_timestamp;
SELECT order_id, COALESCE(discount, 0) AS discount FROM orders;
SELECT order_id, IFNULL(notes, 'NO notes') AS notes FROM or ders;
SELECT order_id, NULLIF(status, 'pending') As status FROM orders

--WHERE 
SELECT * FROM orders WHERE status='completed';
SELECT * FROM orders WHERE revenue > 500000;
SELECT * FROM orders WHERE revenue BETWEEN  10000 AND 500000;
SELECT * FROM orders WHERE CITY IN('Delhi', 'Mumbai');
SELECT * FROM orders WHERE CiTY NOT IN ('Delhi','Mumbai')
SELECT * FROM Customers Where EMAIL LIKE '%@gmail.com';
