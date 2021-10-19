-- TASK 24
--  sub query and tabel
SELECT n,count(*) FROM (
   SELECT ProductID,
          COUNT(*) AS n
   FROM ProductCostHistory
   GROUP BY ProductID
) AS T
GROUP BY n


-- TASK 25
SELECT ProductName,
       ProductNumber,
       CHARINDEX('-', ProductNumber) AS HyphenLocation  ,
       IIF(CHARINDEX('-', ProductNumber)=0,ProductNumber, SUBSTRING(ProductNumber, 0,CHARINDEX('-', ProductNumber))) AS BaseProductNumber,
       IIF(CHARINDEX('-', ProductNumber)=0,NULL,SUBSTRING(ProductNumber,CHARINDEX('-', ProductNumber)+1,LEN(ProductNumber))) AS Size
FROM Product
WHERE ProductID>533

-- TASK 26
WITH tmp AS
    (
SELECT ProductName,
       ProductNumber,
       ProductSubcategoryID,
       IIF(CHARINDEX('-', ProductNumber)=0,ProductNumber, SUBSTRING(ProductNumber, 0,CHARINDEX('-', ProductNumber))) AS BaseProductNumber,
       IIF(CHARINDEX('-', ProductNumber)=0,NULL,SUBSTRING(ProductNumber,CHARINDEX('-', ProductNumber)+1,LEN(ProductNumber))) AS Size
FROM Product
WHERE ProductID>533
)
SELECT BaseProductNumber ,
       COUNT(*) AS TotalSizes
FROM tmp
    INNER JOIN ProductSubcategory PC ON  tmp.ProductSubcategoryID=PC.ProductSubcategoryID
WHERE PC.ProductCategoryID=3
GROUP BY BaseProductNumber ;


-- TASK 27
WITH tmp AS (
   SELECT ProductID,
          StandardCost,
          LAG(StandardCost) over (PARTITION BY ProductID ORDER BY StartDate) AS ncost
   FROM ProductCostHistory
)
SELECT  tmp.ProductID,
        P.ProductName,
        count(tmp.StandardCost) AS TotalCostChanges
FROM tmp INNER JOIN  Product P ON P.ProductID = tmp.ProductID
WHERE tmp.StandardCost<>ncost OR ncost IS NULL
GROUP BY tmp.ProductID , P.ProductName;


-- TASK 28
WITH tmp AS (
   SELECT ProductID,
          StandardCost,
          StartDate,
          LAG(StandardCost) over (PARTITION BY ProductID ORDER BY ProductID) AS ncost
   FROM ProductCostHistory
)
SELECT  tmp.ProductID,
        tmp.StartDate,
        P.ProductName ,
        tmp.ncost-tmp.StandardCost AS PriceDifference
FROM tmp INNER JOIN  Product P ON P.ProductID = tmp.ProductID
WHERE tmp.StandardCost<>ncost
ORDER BY PriceDifference DESC

-- TASK 29
-- I think union all should be changed to union
;with FraudSuspects as (
Select *
From Customer
Where
CustomerID in (29401,11194,16490,22698,26583,12166,16036,25110,18172,11997,26731))
, SampleCustomers as (
Select top 100 *
From Customer
Where
CustomerID not in (29401,11194,16490,22698,26583,12166,16036,25110,18172,11997,26731)
Order by
NewID()
)
Select * From FraudSuspects
Union
Select * From SampleCustomers


-- Task 30
;with tmp AS (
    SELECT ProductID,
           CalendarDate
    FROM ProductListPriceHistory,
         Calendar
    WHERE CalendarDate BETWEEN StartDate and EndDate
)

SELECT CalendarDate,
       ProductID,
       Count(*) AS TotalRows
FROM tmp
GROUP BY  CalendarDate,ProductID
HAVING    Count(*)>1

-- TASK 31
;with maxmin as(
SELECT  ProductID,
           min(StartDate) As start ,
           max(EndDate) As ends
FROM ProductListPriceHistory
GROUP BY ProductID
),
tmp AS (
    SELECT ProductID,
           CalendarDate
    FROM ProductListPriceHistory
        INNER JOIN  Calendar ON CalendarDate BETWEEN StartDate and ISNULL(EndDate,GETDATE())
)
SELECT T.* FROM (
        SELECT CalendarDate,
               ProductID,
               Count(*) AS TotalRows
        FROM tmp
        GROUP BY CalendarDate,ProductID
        HAVING  Count(*)>1
) AS T inner join maxmin ON maxmin.ProductID = t.ProductID
where t.CalendarDate BETWEEN  start and ends

-- TASK 32
DECLARE @dn date;
SET @dn='2014-06-30';
SELECT CalendarMonth,
       COUNT(DISTINCT  SalesOrderID) AS TotalOrders,
       SUM(COUNT(DISTINCT  SalesOrderID)) OVER(ORDER BY CalendarMonth) AS  RunningTotal
FROM  SalesOrderHeader
    INNER JOIN  Calendar ON CalendarMonth = FORMAT(OrderDate,'yyyy/MM - MMM')
WHERE OrderDate BETWEEN DATEADD(YEAR,-1,@dn) and @dn
GROUP BY  CalendarMonth
ORDER BY CalendarMonth

-- TASK 33
WITH tmp AS (
SELECT ST.TerritoryID ,
       ST.TerritoryName,
       ST.CountryCode ,
       DueDate,
       ShipDate
FROM SalesOrderHeader SOH
    INNER JOIN SalesTerritory ST on SOH.TerritoryID = ST.TerritoryID
)

SELECT TerritoryID ,
       TerritoryName,
       CountryCode ,
       COUNT(*) AS TotalOrders ,
       COUNT(IIF(ShipDate>DueDate,0,NULL)) AS TotalLateOrders
FROM tmp
GROUP BY  TerritoryID ,TerritoryName,CountryCode
ORDER BY  TerritoryID ;


-- TASK 34
-- Solution 4 20 logical reads


-- Solution #1
--  Table 'SalesOrderHeader'. Scan count 2, logical reads 40, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- [2021-10-19 08:54:59] 1 row retrieved starting from 1 in 280 ms (execution: 26 ms, fetching: 254 ms)

-- Solution #2
-- Table 'SalesOrderHeader'. Scan count 2, logical reads 40, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- [2021-10-19 08:56:49] 1 row retrieved starting from 1 in 95 ms (execution: 28 ms, fetching: 67 ms)

-- -- Solution #3
-- Table 'SalesOrderHeader'. Scan count 4, logical reads 80, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- [2021-10-19 08:58:20] 1 row retrieved starting from 1 in 84 ms (execution: 25 ms, fetching: 59 ms)


-- Solution #4
-- Table 'SalesOrderHeader'. Scan count 1, logical reads 20, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
-- [2021-10-19 08:59:00] 1 row retrieved starting from 1 in 67 ms (execution: 14 ms, fetching: 53 ms)

-- TASK 35

with P AS (
    SELECT P.ProductID,
           PS.ProductSubCategoryName
    FROM Product P
        INNER JOIN ProductSubcategory PS on P.ProductSubcategoryID = PS.ProductSubcategoryID
),
 O AS (
   SELECT SOD.ProductID ,
          SOD.LineTotal,
          SalesOrderHeader.*
   FROM SalesOrderHeader
        inner join SalesOrderDetail SOD on SalesOrderHeader.SalesOrderID = SOD.SalesOrderID
),tmp AS (
SELECT O.CustomerID,
       O.OrderDate ,
       O.SalesOrderID,
       P.ProductID,
       O.LineTotal ,
       P.ProductSubCategoryName,
       ROW_NUMBER() over (PARTITION BY O.CustomerID ORDER BY  C.CustomerID,OrderDate DESC, LineTotal DESC) AS r
FROM O
 INNER JOIN Customer C on O.CustomerID = C.CustomerID
 INNER JOIN P ON O.ProductID = P.ProductID
WHERE O.CustomerID IN (19500,19792,24409,26785)
    )

SELECT tmp.CustomerID,
       Customer.FirstName+' '+Customer.LastName,
       tmp.ProductSubCategoryName
FROM tmp INNER JOIN  Customer ON Customer.CustomerID = tmp.CustomerID
WHERE r=1

-- TASK 36
WITH tmp AS(
SELECT OT.SalesOrderID,
       TE.EventName ,
       OT.EventDateTime AS TrackingEventDate,
       LEAD(EventDateTime) over (PARTITION BY SalesOrderID ORDER BY EventDateTime) AS NextTrackingEventDate
FROM OrderTracking OT INNER JOIN  TrackingEvent TE on OT.TrackingEventID = TE.TrackingEventID
WHERE SalesOrderID IN (68857,70531,70421)
)

SELECT tmp.*,
       DATEDIFF(hour ,TrackingEventDate,NextTrackingEventDate) HoursInStage
FROM tmp;


-- TASK 37
WITH tmp AS(
SELECT OT.SalesOrderID,
       TE.EventName ,
       OT.TrackingEventID,
       OT.EventDateTime AS TrackingEventDate,
       LEAD(EventDateTime) over (PARTITION BY SalesOrderID ORDER BY EventDateTime) AS NextTrackingEventDate
FROM OrderTracking OT INNER JOIN  TrackingEvent TE on OT.TrackingEventID = TE.TrackingEventID
)

SELECT CASE WHEN OnlineOrderFlag=1 THEN 'Online' ELSE 'Offline' END AS OnlineOfflineStatus,
       tmp.EventName,
       AVG(DATEDIFF(hour ,TrackingEventDate,NextTrackingEventDate))
FROM tmp
    INNER JOIN SalesOrderHeader SOH ON SOH.SalesOrderID = tmp.SalesOrderID
GROUP BY  tmp.EventName,CASE WHEN OnlineOrderFlag=1 THEN 'Online' ELSE 'Offline' END ,TrackingEventID
ORDER By OnlineOfflineStatus ,TrackingEventID

-- CASE 38
WITH tmp AS(
SELECT OT.SalesOrderID,
       TE.EventName ,
       OT.TrackingEventID,
       OT.EventDateTime AS TrackingEventDate,
       LEAD(EventDateTime) over (PARTITION BY SalesOrderID ORDER BY EventDateTime) AS NextTrackingEventDate
FROM OrderTracking OT INNER JOIN  TrackingEvent TE on OT.TrackingEventID = TE.TrackingEventID
)

SELECT tmp.EventName,
       AVG(CASE WHEN SOH.OnlineOrderFlag=0 THEN DATEDIFF(hour ,TrackingEventDate,NextTrackingEventDate) ELSE NULL END) OfflineAvgHoursInStage,
       AVG(CASE WHEN SOH.OnlineOrderFlag=1 THEN DATEDIFF(hour ,TrackingEventDate,NextTrackingEventDate) ELSE NULL END) OnlineAvgHoursInStage
FROM tmp
    INNER JOIN SalesOrderHeader SOH ON SOH.SalesOrderID = tmp.SalesOrderID
GROUP BY  tmp.EventName , TrackingEventID
ORDER BY  tmp.TrackingEventID;


-- TASK 39
WITH  Cus AS (
    SELECT *FROM Customer
       WHERE CustomerID IN (13763,13836,20331,21113,26313)
),
 CusOrd AS (
     SELECT C.CustomerID,
            C.FirstName+' '+C.LastName As CustomerName,
            SOH.SalesOrderID
     FROM SalesOrderHeader AS SOH
         INNER JOIN Cus C on SOH.CustomerID = C.CustomerID
 ),
 CusOrdOD AS (
     SELECT CO.* ,
            SOD.ProductID,
            SOD.LineTotal
     FROM SalesOrderDetail SOD
         INNER JOIN  CusOrd CO ON CO.SalesOrderID=SOD.SalesOrderID
 ),ProSub AS (
     SELECT ProductID,
            PS.ProductSubCategoryName
     FROM Product
       INNER JOIN ProductSubcategory PS on Product.ProductSubcategoryID = PS.ProductSubcategoryID
),CusPro AS (
    SELECT CusOrdOD.CustomerID,
           CusOrdOD.CustomerName,
           ProSub.ProductSubCategoryName,
           MAX(CusOrdOD.LineTotal) As LineTotal
    FROM CusOrdOD
        INNER JOIN ProSub ON CusOrdOD.ProductID = ProSub.ProductID
    GROUP BY CusOrdOD.CustomerID,CusOrdOD.CustomerName,ProSub.ProductSubCategoryName
), ans AS(
SELECT CusPro.* ,
       row_number() over (PARTITION BY CustomerID ORDER BY CustomerID,LineTotal DESC) r
FROM CusPro
)

SELECT CustomerID,
       CustomerName,
       [1] AS TopProdSubCat1,
       [2] AS TopProdSubCat1 ,
       [3] AS TopProdSubCat1
FROM (
    SELECT CustomerID,
           CustomerName,
           ProductSubCategoryName,
           r
    FROM ans
) as t
PIVOT (
    max(t.ProductSubCategoryName)
    for r in([1],[2],[3])
) as sv
ORDER BY CustomerID


-- TASK 40
with pdate AS (
    SELECT ProductID,
           Min(StartDate)                     AS FirstStartDate,
           Max(IsNull(EndDate, '2014-05-29')) AS LastEndDate
    FROM ProductListPriceHistory
    GROUP BY ProductID
) ,
ptmp AS (
SELECT ProductID,
       CalendarDate
FROM pdate full join Calendar
ON CalendarDate>=FirstStartDate AND CalendarDate<=LastEndDate
)

SELECT ptmp.ProductID,
       CalendarDate AS DateWithMissingPrice
FROM ProductListPriceHistory PLH RIGHT JOIN ptmp
ON ptmp.ProductID=PLH.ProductID AND
   ptmp.CalendarDate BETWEEN StartDate AND  IsNull(EndDate, '2014-05-29')
WHERE PLH.ProductID IS NULL and ptmp.ProductID is not NULL












