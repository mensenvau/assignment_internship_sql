-- TASK 1
-- CASE 1 => YEAR(orderdate)=2015 AND MONTH(orderdate)=6;

SELECT orderid ,
       orderdate ,
       custid ,
       empid
FROM Sales.Orders
WHERE  YEAR(orderdate)=2015 AND MONTH(orderdate)=6;

-- CASE 2 => WHERE Sales.Orders.orderdate LIKE '2015-06%';
-- WHERE Sales.Orders.orderdate LIKE '2015-06%';
-- CASE 3 => BETWEEN
-- WHERE orderdate  BETWEEN '2015-06-01' AND '2015-06-31';


-- TASK 2
-- The EOMONTH() function returns the last day of the month of a specified date .
SELECT orderid ,
       orderdate ,
       custid ,
       empid
FROM Sales.Orders
WHERE DAY(EOMONTH(orderdate))=DAY(orderdate);


-- TASK 3
-- lastname LIKE LIKE '%e%e%'
SELECT empid ,
       firstname,
       lastname
FROM HR.Employees
WHERE HR.Employees.lastname  LIKE '%e%e%';


-- TASK 4
-- We calculate the sum in groups by orderid
SELECT orderid,
        SUM(qty*unitprice) AS totalvalue
FROM  Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty*unitprice)> 10000
ORDER BY totalvalue  DESC;



-- TASK 5
-- (Latin1_General_BIN) case sensitive
SELECT empid ,
       lastname
FROM HR.Employees
WHERE  LEFT(lastname,1) COLLATE  Latin1_General_BIN BETWEEN  'a' AND 'z'


-- TASK 6
-- Explain the difference between the following two queries
-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';

-- Query 1 - For each empid (orderdate <'20160501') the Orders COUNT () is calculated
-- Query 2 - For each empid MAX orderdate (orderdate <'20160501') Orders are COUNT ()

-- TASK 7
-- With the ball we get the first 3 avgfreight
-- sorted => ORDER BY avgfreight DESC
SELECT TOP 3
       shipcountry,
       AVG(freight) AS avgfreight
FROM  Sales.Orders
WHERE YEAR(orderdate)=2015
GROUP BY shipcountry
ORDER BY avgfreight DESC


-- TASK 8
-- FUNCTION ROW_NUMBER() => numbered according to the given OVER ()
SELECT custid ,
       orderdate,
       orderid ,
       ROW_NUMBER() OVER (PARTITION BY custid ORDER BY orderid) AS rownum
FROM Sales.Orders


-- TASK 9
-- SWITCH CASE
SELECT empid ,
       firstname,
       lastname ,
       titleofcourtesy,
       CASE
           WHEN titleofcourtesy='Ms.' OR titleofcourtesy='Mrs.' THEN 'Female'
           WHEN titleofcourtesy='Mr.' THEN  'Male'
           ELSE 'Unknown'
      END AS gender
FROM HR.Employees


-- TASK 10
-- CASE 1 => ISNULL REPLACE CHAR(255)
-- CASE 2 => IS NOT NULL UNION IS NULL
SELECT  custid ,
        region
FROM  Sales.Customers
ORDER BY  ISNULL(region,CHAR(255)) , region


-- TASK 11
-- We equate the MAX to the order date (SELECT MAX(orderdate) FROM Sales.Orders)
-- You can also take a variable
DECLARE  @Max_date DATETIME ;
SET @Max_date = (SELECT MAX(orderdate) FROM Sales.Orders)
SELECT orderid ,
       orderdate,
       custid,
       empid
FROM Sales.Orders
WHERE  orderdate = @Max_date

-- TASK 12
-- @max_count save max order count
DECLARE @max_count INT;
SELECT TOP 1 @max_count=COUNT(custid) FROM Sales.Orders GROUP BY custid ORDER BY COUNT(custid) DESC;
SELECT custid ,
       orderid,
       orderdate,
       empid
FROM  (SELECT *,
       COUNT(custid) OVER(PARTITION BY custid ORDER BY custid) as count
FROM Sales.Orders ) AS T
WHERE T.count=@max_count


-- TASK 13
-- We will determine orders on and after ‘2016-05-01’
-- then the empid returns
-- We can take all orders except this empid
SELECT empid ,
       firstName,
       lastname
FROM Hr.Employees
WHERE empid NOT IN (SELECT distinct empid FROM Sales.Orders WHERE orderdate>='2016-05-01')

-- TASK 14
-- Not in  Employees country
-- In the ‘Employess’ table we get the ones that are not in the ‘country’ row
SELECT
    distinct  country
FROM Sales.Customers
WHERE country NOT IN (SELECT distinct country FROM HR.Employees)


-- TASK 15
-- tmp save Gurup By custid and max(orderdate)
WITH tmp AS (
    SELECT custid,
           max(orderdate) as mdate
    FROM Sales.Orders
    GROUP BY custid)

SELECT  O.custid,
        O.orderid,
        O.orderdate ,
        O.empid
FROM Sales.Orders as O INNER JOIN tmp
ON O.custid = tmp.custid AND O.orderdate=tmp.mdate
ORDER BY  O.custid

-- TASK 16
-- NOT IN 2016 and IN 2015
-- you can also save the condition to two (select Sales.Orders ) variables
SELECT C.custid ,
       C.companyname
FROM Sales.Customers C
WHERE
      C.custid NOT IN (SELECT custid FROM Sales.Orders WHERE YEAR(orderdate) = 2016) AND
      C.custid     IN (SELECT custid FROM Sales.Orders WHERE YEAR(orderdate) = 2015)
ORDER BY  C.custid

-- TASK 17
-- tmp save
WITH tmp AS(
SELECT custid
FROM Sales.Orders O INNER JOIN Sales.OrderDetails CD
ON CD.orderid = O.orderid
WHERE CD.productid = 12
)

SELECT C.custid ,
       C.companyname
FROM Sales.Customers C
WHERE C.custid IN (SELECT *FROM tmp)

-- TASK 18
-- SUM OVER() FUNCTION ROWS BETWEEN 
SELECT custid,
       ordermonth,
       qty,
       SUM(qty) OVER (PARTITION BY custid ORDER BY ordermonth ASC,custid ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING) AS runqty
FROM Sales.CustOrders


-- TASK 19
-- In - Checks for availability among given values if True False otherwise
-- EXISTS - EXISTS - Returns at least 1 Rows in a given query True otherwise False


-- TASK 20
-- DATEDIFF function => GET DATA DIFF
-- LAG function =>  GET previous date 
SELECT custid ,
       orderdate,
       orderid,
       LAG(orderdate) OVER (PARTITION BY custid ORDER BY orderdate) AS ldate
       INTO #tmp
FROM Sales.Orders

SELECT custid ,
       orderdate,
       orderid,
       IIF(ldate IS NULL,NULL,DATEDIFF(DAY,ldate,orderdate)) diff
FROM #tmp


-- TASK 21
-- RUN CODE FILE(Week 2 - Exercises.sql)
SELECT TOP 3 * FROM dbo.Employee
WHERE Employee.ID IN (
    SELECT Employee_ID
    FROM dbo.Projects
    GROUP BY Employee_ID
    HAVING COUNT(DISTINCT Project_ID) >= 3
)
ORDER BY Salary

-- TASK 22
-- I used tblPerson table
-- It would be great if the Google interview question was more (Level = Easy,Medium)
-- my solution
-- If ChildGender is only Famle and Male
SELECT Parent FROM tblPerson
GROUP BY Parent
HAVING COUNT(DISTINCT ChildGender)>1
