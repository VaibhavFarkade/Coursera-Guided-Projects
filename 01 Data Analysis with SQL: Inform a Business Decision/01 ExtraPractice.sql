-- Joining Customer and Orders Table
-- Return CustomerName, OrderID and OrderDate

SELECT C.CustomerName AS CustomerName,
	   O.OrderID AS OrderID, 
       O.OrderDate AS OrderDate
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID;