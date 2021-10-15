-- TASK 1
SELECT ProductID,COUNT(StandardCost) FROM ProductCostHistory
GROUP BY  ProductID
ORDER BY ProductID

-- TASK 2
SELECT C.CustomerID ,
       COUNT(SalesOrderID)  AS TotalOrders
FROM Customer C INNER JOIN SalesOrderHeader SOH on C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID
ORDER BY  TotalOrders DESC


-- TASK 3
SELECT ProductID ,
        CONVERT(varchar,MIN(OrderDate),23) AS FirstOrder,
        CONVERT(varchar,MAX(OrderDate),23)   AS LastOrder
FROM SalesOrderDetail SD INNER JOIN SalesOrderHeader SOH on SD.SalesOrderID = SOH.SalesOrderID
GROUP BY  ProductID
ORDER BY  ProductID


--TASK 4
SELECT  P.ProductID ,
        P.ProductName,
        CONVERT(varchar,MIN(OrderDate),23) AS FirstOrder,
        CONVERT(varchar,MAX(OrderDate),23)   AS LastOrder
FROM SalesOrderDetail SD
     INNER JOIN SalesOrderHeader SOH on SD.SalesOrderID = SOH.SalesOrderID
     INNER JOIN Product P on SD.ProductID = P.ProductID
GROUP BY  P.ProductID, P.ProductName
ORDER BY  P.ProductID

-- TASK 5

SELECT ProductID ,
       StandardCost
FROM ProductCostHistory
WHERE (StartDate is NULL AND EndDate>='2012-04-15') OR
      (StartDate<='2012-04-15' AND EndDate IS NULL) OR
      (StartDate<='2012-04-15' AND  EndDate>='2012-04-15')
ORDER BY  ProductID

-- TASK 6
SELECT ProductID ,
       StandardCost
FROM ProductCostHistory
WHERE (StartDate is NULL AND EndDate>='2014-04-15.') OR
      (StartDate<='2014-04-15' AND EndDate IS NULL) OR
      (StartDate<='2014-04-15' AND  EndDate>='2014-04-15')
ORDER BY  ProductID

-- TASK 7
SELECT DATAModifiedDate FROM ProductListPriceHistory