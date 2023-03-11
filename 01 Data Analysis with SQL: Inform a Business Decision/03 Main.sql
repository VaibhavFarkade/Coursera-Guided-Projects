--Exploring all the tables
SELECT * FROM Customers;
SELECT * FROM Categories;
SELECT * FROM Employees;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM Shippers;
SELECT * FROM Suppliers;



-- We need to award bonus to employees who had top 5 order amounts

-- If we do not consider units of products purchased, the following question answers the question "Which employees sold highest price product"

SELECT E.FirstName, E.LastName, P.Price
FROM Employees AS E
INNER JOIN Orders AS O ON
E.EmployeeID = O.EmployeeID
INNER JOIN OrderDetails AS OD ON
O.OrderID = OD.OrderID
INNER JOIN Products AS P ON
OD.ProductID = P.ProductID
ORDER BY P.Price DESC
LIMIT 5;

-- Output:->
-- Number of Records: 5
-- FirstName   	LastName    	Price
-- Margaret    	Peacock	        263.5
-- Nancy   	    Davolio 	    263.5
-- Robert  	    King	        263.5
-- Margaret    	Peacock	        263.5
-- Steven  	    Buchanan    	263.5


-- To answer the original question we need to calculate the total amount an Employee was able to sell, 
--it could be done by multiply quantity by product price and adding all products sold by an employee

SELECT E.FirstName, E.LastName, SUM((P.Price * OD.Quantity)) AS TotalAmount
FROM Employees AS E
INNER JOIN Orders AS O ON
E.EmployeeID = O.EmployeeID
INNER JOIN OrderDetails AS OD ON
O.OrderID = OD.OrderID
INNER JOIN Products AS P ON
OD.ProductID = P.ProductID
GROUP BY O.OrderID
ORDER BY TotalAmount DESC
LIMIT 5;


-- Output:->
-- Number of Records: 5
-- FirstName	LastName	TotalAmount
-- Steven	    Buchanan	15353.6
-- Robert	    King	    14366.5
-- Margaret	    Peacock	        14104
-- Robert	    King	    13427
-- Margaret	    Peacock	        9244.250000000002


-- In this result, 2 of the employees are repeated as they had more than one great sales. 
-- But we need to select top 5 distinct employees to award incentives. 
-- The guide suggests to include a having clause which consists of ID's of top performers.
-- But in real time we'll need to calculate that for ourselves, so I did my own version of the answer.


-- Guide:->
SELECT E.FirstName, E.LastName, O.OrderID, SUM((P.Price * OD.Quantity)) AS TotalAmount
FROM Employees AS E
INNER JOIN Orders AS O ON
E.EmployeeID = O.EmployeeID
INNER JOIN OrderDetails AS OD ON
O.OrderID = OD.OrderID
INNER JOIN Products AS P ON
OD.ProductID = P.ProductID
GROUP BY O.OrderID
HAVING O.OrderID IN (10372, 10424, 10417, 10324, 10351)
ORDER BY TotalAmount DESC
LIMIT 5;


-- My Version:->
SELECT E.FirstName, E.LastName, O.OrderID, SUM((P.Price * OD.Quantity)) AS TotalAmount
FROM Employees AS E
INNER JOIN Orders AS O ON
E.EmployeeID = O.EmployeeID
INNER JOIN OrderDetails AS OD ON
O.OrderID = OD.OrderID
INNER JOIN Products AS P ON
OD.ProductID = P.ProductID
GROUP BY O.OrderID
HAVING O.OrderID NOT IN (10360, 10353, 10440, 10430)
ORDER BY TotalAmount DESC
LIMIT 5;

-- Since we won't know which IDs have highest sales amount and we not able to use DISTINCT clause on the W3Schools editor 
-- I made sure that the other than highest of the employee no other entry comes in the top 5

-- Output:->
-- FirstName	LastName	OrderID	    TotalAmount
-- Steven	    Buchanan	10372	    15353.6
-- Robert	    King	    10424	    14366.5
-- Margaret	    Peacock	    10417	    14104
-- Anne	        Dodsworth	10324	    7698.45
-- Nancy	    Davolio	    10351	    7103.599999999999