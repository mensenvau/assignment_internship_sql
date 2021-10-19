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
-- DATE CONVERT FUNCTION 
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
-- Enddate is null 
SELECT ProductID ,
       StandardCost
FROM ProductCostHistory
WHERE (StartDate<='2012-04-15' AND EndDate IS NULL) OR
      (StartDate<='2012-04-15' AND  EndDate>='2012-04-15')
ORDER BY  ProductID

-- TASK 6
SELECT ProductID ,
       StandardCost
FROM ProductCostHistory
WHERE  (StartDate<='2014-04-15' AND EndDate IS NULL) OR
       (StartDate<='2014-04-15' AND  EndDate>='2014-04-15')
ORDER BY  ProductID

-- TASK 7
-- FORMAT date 
SELECT FORMAT(StartDate,'yyyy/MM') AS ProductListPriceMonth,
       COUNT(*) AS TotalRows
FROM ProductListPriceHistory
GROUP BY FORMAT(StartDate,'yyyy/MM')


-- TASK 8
-- TABLE Calendar 
-- CASE  1
DECLARE  @start  varchar(50)  = (SELECT MIN(FORMAT(StartDate,'yyyy/MM - MMM') ) FROM ProductListPriceHistory)
DECLARE  @end varchar(50)   = (SELECT MAX(FORMAT(EndDate,'yyyy/MM - MMM')) FROM ProductListPriceHistory)
SELECT C.CalendarMonth ,
        COUNT(StartDate) AS TotalRows
FROM   Calendar C
    LEFT JOIN ProductListPriceHistory  PH
    ON C.CalendarDate = PH.StartDate
WHERE  C.CalendarMonth between @start and @end
GROUP BY  C.CalendarMonth
ORDER BY  C.CalendarMonth
print(@start)

-- CASE  2 
-- CReate new table 
DECLARE  @start  date  = (SELECT min(startDate) FROM ProductListPriceHistory)
DECLARE  @end  date  = (SELECT max(startDate) FROM ProductListPriceHistory)
CREATE  TABLE  #tmp (
    dt date
)
-- add new table date
WHILE(@start<=@end) BEGIN
    INSERT  INTO #tmp (dt) VALUES (@start)
    SET @start = DATEADD(mm,1,@start)
END

-- SELECT *FROM #tmp ;
SELECT FORMAT(dt,'yyyy/MM MMM') AS CalendarMonth,
       COUNT(StartDate) AS TotalRows
FROM  #tmp
    LEFT JOIN ProductListPriceHistory  PH ON FORMAT(StartDate,'yyyy/MM MMM') = FORMAT(#tmp.dt,'yyyy/MM MMM')
GROUP BY   FORMAT(dt,'yyyy/MM MMM')

-- delete new table
-- DROP TABLE #tmp


-- TASK 9 
-- EndDate is Null
SELECT ProductID,
       ListPrice
FROM ProductListPriceHistory WHERE EndDate IS NULL

-- TASK 10 
-- ProductID is null 
SELECT  P.ProductID,
        ProductName
FROM Product P
    LEFT JOIN  ProductListPriceHistory PH ON PH.ProductID = P.ProductID
WHERE PH.ProductID IS NULL

-- TASK 11
-- Copy code....
WITH tmp AS (
SELECT ProductID
FROM ProductCostHistory
WHERE  (StartDate<='2014-04-15' AND EndDate IS NULL) OR
       (StartDate<='2014-04-15' AND  EndDate>='2014-04-15')
)
SELECT Pc.ProductID
FROM ProductCostHistory PC
    LEFT JOIN tmp on PC.ProductID = tmp.ProductID
WHERE tmp.ProductID IS NULL


-- TASK 12
-- HAVING  count(ProductID)
SELECT ProductID
FROM ProductListPriceHistory
WHERE EndDate IS NULL
GROUP BY ProductID
HAVING  count(ProductID)>1


-- TASK 13
-- 25MS  bu yamon natija shekili
SELECT  P.ProductID ,
        P.ProductName,
        PSC.ProductSubCategoryName ,
        ISNULL(CONVERT(varchar,MIN(OrderDate),23),NULL)   AS FirstOrder,
        ISNULL(CONVERT(varchar,MAX(OrderDate),23),NULL)   AS LastOrder
FROM Product P
     LEFT JOIN  SalesOrderDetail SD ON   SD.ProductID = P.ProductID
     LEFT JOIN  SalesOrderHeader SOH ON  SD.SalesOrderID = SOH.SalesOrderID
     LEFT JOIN  ProductSubcategory PSC ON    P.ProductSubcategoryID = PSC.ProductSubcategoryID
GROUP BY  P.ProductID, P.ProductName,  PSC.ProductSubCategoryName
ORDER BY  P.ProductName

-- TASK 14 
-- Last price save table 
WITH last_price AS (
    SELECT * FROM ProductListPriceHistory WHERE EndDate IS NULL
)
SELECT
    P.ProductID,
       P.ListPrice AS Prod_ListPrice ,
       LP.ListPrice AS Prod_ListPrice ,
       P.ListPrice-LP.ListPrice AS Diff
FROM  Product p INNER JOIN  last_price LP on P.ProductID = LP.ProductID
WHERE P.ListPrice<>LP.ListPrice

-- TASK 15
--  save tmp table 
WITH tmp AS (
    SELECT OrderQty,OrderDate,ProductID FROM SalesOrderHeader
        INNER JOIN SalesOrderDetail SOD on SalesOrderHeader.SalesOrderID = SOD.SalesOrderID
),
ans AS (
SELECT
       P.ProductID,
       FORMAT(OrderDate,'yyyy-MM-dd') AS OrderDate,
       ProductName,
       OrderQty AS Qty ,
       SellStartDate ,
       SellEndDate
FROM Product P
    INNER JOIN tmp ON tmp.ProductID = P.ProductID
WHERE OrderDate NOT BETWEEN  P.SellStartDate  AND ISNULL(SellEndDate,getdate())
    )
SELECT *FROM ans  ORDER BY  ProductID,OrderDate


-- TASK 16
WITH tmp AS (
    SELECT OrderQty,OrderDate,ProductID FROM SalesOrderHeader
        INNER JOIN SalesOrderDetail SOD on SalesOrderHeader.SalesOrderID = SOD.SalesOrderID
)
SELECT P.ProductID,
       FORMAT(OrderDate,'yyyy-MM-dd') AS OrderDate,
       ProductName,
       OrderQty AS Qty ,
       SellStartDate ,
       SellEndDate ,
       CASE
         WHEN OrderDate<P.SellStartDate  THEN 'Sold after start date'
         ELSE 'Sold before end date'
       END AS ProblemType
FROM Product P
    INNER JOIN tmp ON tmp.ProductID = P.ProductID
WHERE OrderDate NOT BETWEEN  P.SellStartDate  AND ISNULL(SellEndDate,getdate())
ORDER BY  ProductID,OrderDate

-- TASK 17 
--  3 varibale 
DECLARE @c1 INT = (
SELECT count(*) FROM SalesOrderHeader
WHERE DATEDIFF(SECOND,OrderDate, FORMAT(OrderDate,'yyyy-MM-dd'))<>0)

DECLARE  @c2 INT = (SELECT count(*) FROM SalesOrderHeader)

DECLARE  @c3 float = 1.0*@c1/@c2 ;
-- and select 
SELECT @c1,@c2,@c3;

-- TASK 18
--  not workin 'Color'
--  workin colum name Color
-- colum name is not found in ''
Select
Product.ProductID
,ProductName
,ProductSubCategoryName
,FirstOrder = Convert(date, Min(OrderDate))
,LastOrder = Convert(date, Max(OrderDate))
From Product
Left Join SalesOrderDetail Detail
on Product.ProductID = Detail.ProductID
Left Join SalesOrderHeader Header
on Header.SalesOrderID = Detail .SalesOrderID
Left Join ProductSubCategory
on ProductSubCategory .ProductSubCategoryID = Product.ProductSubCategoryID
Where Color = 'Silver'
Group by
Product.ProductID
,ProductName
,ProductSubCategoryName
Order by LastOrder desc


-- TASK 19 
-- Ntile 1,2,3,4 
-- 25,50,75,100 interval 
SELECT ProductID,
       ProductName,
       StandardCost,
       ListPrice ,
       ListPrice-StandardCost AS RawMargin ,
       Ntile(4)  OVER (ORDER BY ListPrice-StandardCost DESC) AS Quartile
FROM Product
WHERE ListPrice-StandardCost<>0
ORDER BY  ProductName

-- TASK 20 
SELECT C.CustomerID,
       CONCAT(FirstName,' ',LastName) AS CustomerName,
       count(SalesPersonEmployeeID) AS TotalDifferentSalesPeople
FROM SalesOrderHeader
     INNER JOIN Customer C on SalesOrderHeader.CustomerID = C.CustomerID
GROUP BY C.CustomerID , CONCAT(FirstName,' ',LastName)
HAVING  count(SalesPersonEmployeeID)>1
ORDER BY  CustomerName

-- TASK 21
-- change places  "Join"

Select top 100
   Customer.CustomerID
  ,CustomerName = FirstName + ' ' + LastName
  ,OrderDate
  ,SalesOrderHeader.SalesOrderID
  ,SalesOrderDetail.ProductID
  ,Product.ProductName
  ,LineTotal
From SalesOrderHeader
Join SalesOrderDetail
on SalesOrderHeader .SalesOrderID = SalesOrderDetail .SalesOrderID
Join Product
on Product.ProductID = SalesOrderDetail.ProductID
Join Customer
on Customer.CustomerID = SalesOrderHeader.CustomerID
Order by CustomerID,OrderDate


-- TASK 22 
-- having ProductName 
SELECT ProductName FROM Product
GROUP BY  ProductName
HAVING  count(ProductName)>1

-- TASK 23
-- CASE 1
SELECT MAX(ProductID)AS ProductID,
       ProductName FROM Product
GROUP BY  ProductName
HAVING  count(ProductName)>1

-- CASE 2
SELECT ProductID,
       ProductName
FROM (
    SELECT ProductID,
       ProductName ,
       ROW_NUMBER() over (Partition By ProductName ORDER BY  ProductName) AS r
    FROM Product
) AS T
WHERE r=2 

-- intermediate problems.