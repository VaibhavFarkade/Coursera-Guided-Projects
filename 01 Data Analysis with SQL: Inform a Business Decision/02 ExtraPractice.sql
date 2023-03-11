-- Use SQL to count the number of orders placed by each customers

SELECT C.CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID
ORDER BY TotalOrders DESC;